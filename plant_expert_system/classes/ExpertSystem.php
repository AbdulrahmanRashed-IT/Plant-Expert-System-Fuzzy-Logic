<?php
require_once __DIR__ . '/../config/database.php';

class ExpertSystem {
    private $conn;
    
    public function __construct() {
        try {
            $database = new Database();
            $this->conn = $database->connect();
            
            if (!$this->conn) {
                throw new Exception("Database connection failed");
            }
        } catch (Exception $e) {
            error_log("ExpertSystem constructor error: " . $e->getMessage());
            throw new Exception("Failed to initialize expert system: " . $e->getMessage());
        }
    }

    /* ======================
    Diseases
    ======================= */
    public function getAllDiseases() {
        try {
            // Map nama_hama to nama_penyakit for compatibility with frontend
            $query = "SELECT kode, nama_hama AS nama_penyakit, nama_latin, deskripsi, tingkat_bahaya 
                      FROM hama 
                      ORDER BY kode";
            $stmt = $this->conn->prepare($query);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error fetching diseases: " . $e->getMessage());
            return false;
        }
    }

    /* ======================
    FUZZY Diagnosis
    ======================= */
    public function fuzzyDiagnosis($symptoms) {
        $results = [];
        
        try {
            $pestQuery = "SELECT kode, nama_hama AS nama_penyakit, nama_latin, deskripsi, tingkat_bahaya 
                          FROM hama";
            $pestStmt = $this->conn->prepare($pestQuery);
            $pestStmt->execute();
            $pests = $pestStmt->fetchAll(PDO::FETCH_ASSOC);
            
            foreach ($pests as $pest) {
                $fuzzyScore = $this->calculateFuzzyMembership($symptoms, $pest['kode']);
                
                if ($fuzzyScore > 0) {
                    $results[] = [
                        'pest' => $pest,
                        'fuzzy_score' => $fuzzyScore,
                        'confidence_level' => $this->getFuzzyConfidenceLevel($fuzzyScore),
                        'control_methods' => $this->getControlMethods($pest['kode'])
                    ];
                }
            }
            
            usort($results, function($a, $b) {
                return $b['fuzzy_score'] <=> $a['fuzzy_score'];
            });
            
            return $results;
        } catch (PDOException $e) {
            error_log("Fuzzy diagnosis error: " . $e->getMessage());
            return [];
        }
    }
    
    private function calculateFuzzyMembership($userSymptoms, $pestCode) {
        try {
            if (empty($userSymptoms)) {
                return 0;
            }
            $placeholders = str_repeat('?,', count($userSymptoms) - 1) . '?';
            
            $query = "SELECT fr.nilai_keanggotaan, fr.bobot_kepentingan, g.bobot 
                      FROM fuzzy_rules fr 
                      JOIN gejala g ON fr.kd_gejala = g.kd_gejala 
                      WHERE fr.kode_hama = ? AND fr.kd_gejala IN ($placeholders)";
            
            $params = array_merge([$pestCode], $userSymptoms);
            $stmt = $this->conn->prepare($query);
            $stmt->execute($params);
            $rules = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            if (empty($rules)) {
                return 0;
            }
            
            $totalWeight = 0;
            $weightedSum = 0;
            
            foreach ($rules as $rule) {
                $weight = $rule['bobot_kepentingan'] * $rule['bobot'];
                $membershipValue = $rule['nilai_keanggotaan'];
                
                $weightedSum += $membershipValue * $weight;
                $totalWeight += $weight;
            }
            
            $fuzzyScore = $totalWeight > 0 ? $weightedSum / $totalWeight : 0;
            return round($fuzzyScore, 3);
            
        } catch (PDOException $e) {
            error_log("Fuzzy membership calculation error: " . $e->getMessage());
            return 0;
        }
    }
    
    private function getFuzzyConfidenceLevel($score) {
        if ($score >= 0.8) return 'Sangat Tinggi';
        if ($score >= 0.6) return 'Tinggi';
        if ($score >= 0.4) return 'Sedang';
        if ($score >= 0.2) return 'Rendah';
        return 'Sangat Rendah';
    }
    
    public function getControlMethods($pestCode) {
        try {
            $query = "SELECT nama_obat, solusi 
                      FROM solusi 
                      WHERE kode_hama = ? 
                      ORDER BY nama_obat";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$pestCode]);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error fetching control methods: " . $e->getMessage());
            return [];
        }
    }
    
    public function getAllSymptoms() {
        try {
            $query = "SELECT * FROM gejala ORDER BY kd_gejala";
            $stmt = $this->conn->prepare($query);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error fetching symptoms: " . $e->getMessage());
            return false;
        }
    }
    
    /* ======================
    Pests
    ======================= */
    public function getAllPests() {
        try {
            $query = "SELECT kode, nama_hama AS nama_penyakit, nama_latin, deskripsi, tingkat_bahaya 
                      FROM hama 
                      ORDER BY kode";
            $stmt = $this->conn->prepare($query);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error fetching pests: " . $e->getMessage());
            return false;
        }
    }
    
    public function getPestByCode($code) {
        try {
            $query = "SELECT kode, nama_hama AS nama_penyakit, nama_latin, deskripsi, tingkat_bahaya 
                      FROM hama 
                      WHERE kode = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$code]);
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error fetching pest by code: " . $e->getMessage());
            return false;
        }
    }
    
    public function pestAnalysis($pestCode) {
        try {
            $pest = $this->getPestByCode($pestCode);
            if (!$pest) return null;
            
            $query = "SELECT g.kd_gejala, g.gejala, fr.nilai_keanggotaan, fr.bobot_kepentingan 
                      FROM gejala g 
                      JOIN fuzzy_rules fr ON g.kd_gejala = fr.kd_gejala 
                      WHERE fr.kode_hama = ? 
                      ORDER BY fr.nilai_keanggotaan DESC";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$pestCode]);
            $symptoms = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            return [
                'pest' => $pest,
                'symptoms' => $symptoms,
                'control_methods' => $this->getControlMethods($pestCode)
            ];
        } catch (PDOException $e) {
            error_log("Pest analysis error: " . $e->getMessage());
            return null;
        }
    }
}
?>

<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../classes/ExpertSystem.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!isset($input['symptoms']) || !is_array($input['symptoms'])) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid symptoms data']);
        exit;
    }
    
    try {
        $expertSystem = new ExpertSystem();
        $results = $expertSystem->fuzzyDiagnosis($input['symptoms']);
        
        // The fuzzyDiagnosis method returns 'pest', 'fuzzy_score', 'confidence_level', 'control_methods'.
        // The frontend expects 'disease', 'confidence', 'matched_symptoms', 'solutions'.
        // We need to map these.
        $formattedResults = [];
        foreach ($results as $result) {
            $formattedResults[] = [
                'disease' => $result['pest'], // Map 'pest' to 'disease'
                'confidence' => $result['fuzzy_score'] * 100, // Convert fuzzy score (0-1) to percentage (0-100)
                'confidence_level' => $result['confidence_level'], // Keep confidence level
                'matched_symptoms' => $input['symptoms'], // The symptoms provided by the user are the matched symptoms
                'solutions' => $result['control_methods'] // Map 'control_methods' to 'solutions'
            ];
        }

        echo json_encode([
            'success' => true,
            'results' => $formattedResults,
            'total_symptoms' => count($input['symptoms']),
            'method' => 'fuzzy_logic'
        ]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Diagnosis failed: ' . $e->getMessage()]);
    }
} else {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
}
?>
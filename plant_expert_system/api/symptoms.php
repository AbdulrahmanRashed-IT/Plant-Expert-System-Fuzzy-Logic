<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once '../classes/ExpertSystem.php';

try {
    $db = new Database();
    $conn = $db->connect();

    $search = isset($_GET['search']) ? $_GET['search'] : '';

    if ($search) {
        $stmt = $conn->prepare("SELECT * FROM gejala WHERE gejala LIKE ? ORDER BY gejala");
        $stmt->execute(["%$search%"]);
    } else {
        $stmt = $conn->prepare("SELECT * FROM gejala ORDER BY gejala");
        $stmt->execute();
    }

    $symptoms = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "success" => true,
        "symptoms" => $symptoms
    ]);
} catch (Exception $e) {
    echo json_encode([
        "success" => false,
        "message" => $e->getMessage()
    ]);
}
?>

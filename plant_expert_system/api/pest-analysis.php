<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');

require_once '../classes/ExpertSystem.php';

if (!isset($_GET['pest_code'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Pest code is required']);
    exit;
}

try {
    $expertSystem = new ExpertSystem();
    $analysis = $expertSystem->pestAnalysis($_GET['pest_code']);
    
    if ($analysis) {
        echo json_encode([
            'success' => true,
            'analysis' => $analysis
        ]);
    } else {
        http_response_code(404);
        echo json_encode(['error' => 'Pest not found']);
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Analysis failed: ' . $e->getMessage()]);
}
?>
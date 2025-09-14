<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../classes/ExpertSystem.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    
    // Changed 'pest_code' to 'disease_code' to match the frontend request
    if (!isset($input['disease_code'])) {
        http_response_code(400);
        echo json_encode(['error' => 'Disease code required']);
        exit;
    }
    
    $expertSystem = new ExpertSystem();
    // Changed 'pestAnalysis' to 'pestAnalysis' (already correct) and passed 'disease_code'
    $analysis = $expertSystem->pestAnalysis($input['disease_code']);
    
    if (!$analysis) {
        http_response_code(404);
        echo json_encode(['error' => 'Pest not found']);
        exit;
    }
    
    echo json_encode([
        'success' => true,
        'pest' => $analysis['pest'], // Renamed 'pest' from 'disease' for consistency with backend
        'required_symptoms' => $analysis['symptoms'],
        'control_methods' => $analysis['control_methods']
    ]);
} else {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
}
?>
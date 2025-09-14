<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once '../classes/ExpertSystem.php';

try {
    $expertSystem = new ExpertSystem();
    $diseases = $expertSystem->getAllDiseases(); // FIXED: call diseases not pests

    echo json_encode([
        'success' => true,
        'diseases' => $diseases
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Error fetching diseases: ' . $e->getMessage()
    ]);
}

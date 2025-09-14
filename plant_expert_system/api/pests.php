<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once '../classes/ExpertSystem.php';

try {
    $expertSystem = new ExpertSystem();
    $pests = $expertSystem->getAllPests();

    echo json_encode([
        'success' => true,
        'pests' => $pests
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Error fetching pests: ' . $e->getMessage()
    ]);
}

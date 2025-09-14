<?php
class Database {
    private $host = 'localhost';
    private $db_name = 'sikar'; // must match your imported DB name
    private $username = 'root'; // adjust if needed
    private $password = '';     // adjust if needed
    private $conn;

    public function connect() {
        $this->conn = null;
        try {
            $this->conn = new PDO(
                "mysql:host=" . $this->host . ";dbname=" . $this->db_name,
                $this->username,
                $this->password
            );
            $this->conn->exec("set names utf8mb4");
        } catch (PDOException $e) {
            echo json_encode([
                "success" => false,
                "message" => "Database connection failed: " . $e->getMessage()
            ]);
            exit;
        }
        return $this->conn;
    }
}

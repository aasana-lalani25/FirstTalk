<?php
$host = "localhost"; // Update if needed
$user = "root"; // Your MySQL username
$password = ""; // Your MySQL password
$database = "first_talk"; // Your database name

$conn = new mysqli($host, $user, $password, $database);

// Check connection
if ($conn->connect_error) {
    die(json_encode(['error' => 'Database connection failed: ' . $conn->connect_error]));
}
?>

<?php
session_start();
include 'db_connection.php'; // Ensure this file correctly connects to your database

header("Content-Type: application/json");

// Check if the session email is set
if (!isset($_SESSION['email'])) {
    echo json_encode(['error' => 'Session email not set', 'name' => 'Admin']);
    exit();
}

$email = $_SESSION['email'];

// Log the email for debugging (check server logs)
error_log("Fetching name for email: " . $email);

// Prepare and execute the SQL statement
$sql = "SELECT name FROM login WHERE email = ?";
$stmt = $conn->prepare($sql);

if ($stmt) {
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();

    if ($user) {
        echo json_encode(['name' => $user['name']]);
    } else {
        echo json_encode(['error' => 'User not found', 'name' => 'Admin']);
    }

    $stmt->close();
} else {
    echo json_encode(['error' => 'Database query failed', 'name' => 'Admin']);
}

$conn->close();
?>

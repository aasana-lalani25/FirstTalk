<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

$conn = new mysqli("localhost", "root", "", "deafapp");

if ($conn->connect_error) {
    echo json_encode(["success" => false, "error" => "Connection failed"]);
    exit();
}

$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

if (empty($email) || empty($password)) {
    echo json_encode(["success" => false, "error" => "Missing input"]);
    exit();
}

// Sanitize input to prevent SQL injection
$email = $conn->real_escape_string($email);
$password = $conn->real_escape_string($password);

// Query to check if the user exists with the given email and password
$sql = "SELECT * FROM user WHERE email = '$email' AND password = '$password' LIMIT 1";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    echo json_encode(["success" => true, "user" => $user]);
} else {
    echo json_encode(["success" => false, "error" => "Incorrect email or password"]);
}

$conn->close();
?>

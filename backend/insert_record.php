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

$name = $_POST['name'] ?? '';
$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

if (empty($name) || empty($email) || empty($password)) {
    echo json_encode(["success" => false, "error" => "Missing input"]);
    exit();
}

// Sanitize
$name = $conn->real_escape_string($name);
$email = $conn->real_escape_string($email);
$password = $conn->real_escape_string($password);

// Check if email already exists
$checkSql = "SELECT * FROM user WHERE email = '$email'";
$checkResult = $conn->query($checkSql);

if ($checkResult->num_rows > 0) {
    echo json_encode(["success" => false, "error" => "You are already a user, please login"]);
    exit();
}

// Insert
$sql = "INSERT INTO user (name, email, password) VALUES ('$name', '$email', '$password')";
if ($conn->query($sql) === TRUE) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "error" => $conn->error]);
}

$conn->close();
?>

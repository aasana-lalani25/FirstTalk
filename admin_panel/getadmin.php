<?php
session_start();

// Database connection
$host = "localhost";
$user = "root";
$password = "";
$db = "first_talk";

$data = mysqli_connect($host, $user, $password, $db);
if (!$data) {
    die(json_encode(["error" => "Database connection failed."]));
}

if (isset($_SESSION["email"])) {
    $email = $_SESSION["email"];

    // Fetch the admin's name
    $sql = "SELECT name FROM login WHERE email = '$email'";
    $result = mysqli_query($data, $sql);

    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        echo json_encode(["name" => $row["name"]]);
    } else {
        echo json_encode(["error" => "Admin not found."]);
    }
} else {
    echo json_encode(["error" => "Not logged in."]);
}
?>

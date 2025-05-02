<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

error_reporting(E_ALL);
ini_set('display_errors', 1);

// Include database connection
$host = "localhost";
$user = "root";
$password = "";
$dbname = "deafapp";

$conn = new mysqli($host, $user, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]));
}

// Get JSON input
$data = json_decode(file_get_contents("php://input"), true);

// Extract and sanitize inputs
$email = $conn->real_escape_string($data["email"]);
$recovery_email = $conn->real_escape_string($data["recovery_email"]);
$first_name = $conn->real_escape_string($data["first_name"]);
$last_name = $conn->real_escape_string($data["last_name"]);
$phone_no = $conn->real_escape_string($data["phone_no"]);
$dob = $conn->real_escape_string($data["dob"]);
$gender = $conn->real_escape_string($data["gender"]);
$bio = $conn->real_escape_string($data["bio"]);
$house_no = $conn->real_escape_string($data["house_no"]);
$area = $conn->real_escape_string($data["area"]);
$city = $conn->real_escape_string($data["city"]);
$state = $conn->real_escape_string($data["state"]);
$country = $conn->real_escape_string($data["country"]);
$pincode = $conn->real_escape_string($data["pincode"]);
$hard_of_hearing = $conn->real_escape_string($data["hard_of_hearing"]);

// Try to update, or insert if not exists
$sql = "INSERT INTO user_profiles (email, recovery_email, first_name, last_name, phone_no, dob, gender, bio, house_no, area, city, state, country, pincode, hard_of_hearing)
        VALUES ('$email', '$recovery_email', '$first_name', '$last_name', '$phone_no', '$dob', '$gender', '$bio', '$house_no', '$area', '$city', '$state', '$country', '$pincode', '$hard_of_hearing')
        ON DUPLICATE KEY UPDATE
            recovery_email = VALUES(recovery_email),
            first_name = VALUES(first_name),
            last_name = VALUES(last_name),
            phone_no = VALUES(phone_no),
            dob = VALUES(dob),
            gender = VALUES(gender),
            bio = VALUES(bio),
            house_no = VALUES(house_no),
            area = VALUES(area),
            city = VALUES(city),
            state = VALUES(state),
            country = VALUES(country),
            pincode = VALUES(pincode),
            hard_of_hearing = VALUES(hard_of_hearing)";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["status" => "success", "message" => "Profile saved successfully"]);
} else {
    echo json_encode(["status" => "error", "message" => "Error: " . $conn->error]);
}

$conn->close();
?>

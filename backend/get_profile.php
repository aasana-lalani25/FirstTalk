<?php
// Start the session to access session variables
session_start();

// Include the database connection file
include('dbconnection.php');

// Check if the user is logged in by verifying the session variable 'id'
if (isset($_SESSION['id'])) {
    $user_id = $_SESSION['id'];  // Retrieve user_id from session

    // Prepare the SQL query to fetch the user's profile
    $sql = "SELECT * FROM user_profiles WHERE id = '$user_id'";

    // Execute the query
    $result = mysqli_query($conn, $sql);

    if ($result) {
        // Fetch the profile data as an associative array
        $profile = mysqli_fetch_assoc($result);

        // Return the profile data as a JSON response
        echo json_encode($profile);
    } else {
        // Return an error if the query failed
        echo json_encode(["error" => "Failed to fetch profile"]);
    }
} else {
    // Return an error if the user is not logged in
    echo json_encode(["error" => "User not logged in"]);
}

// Close the database connection
mysqli_close($conn);
?>

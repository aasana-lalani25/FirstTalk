<?php
session_start();

// Database connection details
$host = "localhost";
$user = "root";
$password = "";
$db = "first_talk";

// Establish the database connection
$data = mysqli_connect($host, $user, $password, $db);
if ($data === false) {
    die("Connection error");
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get email and password from the form and sanitize inputs
    $email = trim(mysqli_real_escape_string($data, $_POST["email"])); // Remove extra spaces
    $password = trim(mysqli_real_escape_string($data, $_POST["password"])); // Remove extra spaces

    // Prepare the SQL query to check the email in the database
    $sql = "SELECT * FROM userlogin WHERE email = '$email'";
    $result = mysqli_query($data, $sql);

    // Check if the query was successful
    if ($result) {
        $row = mysqli_fetch_array($result);

        // Check if a row is returned and validate the password
        if ($row) {
            // Use password_verify to check if the entered password matches the hashed password in the DB
            if (password_verify($password, $row["password"])) {  // password_verify is used for hashed passwords
                // Store user session data
                $_SESSION["email"] = $row["email"];
                $_SESSION["name"] = $row["name"]; // Optional: store user's name if needed
                // Redirect user to their dashboard or home page (Admin or regular user)
                header("Location: userhome.php");  // Redirect to admin home
                exit(); // Exit to ensure no further code is executed
            } else {
                // Invalid password
                echo "<script type='text/javascript'>
                        alert('Incorrect password.');
                      </script>";
            }
        } else {
            // No user found with that email
            echo "<script type='text/javascript'>
                    alert('No user found with that email.');
                  </script>";
        }
    } else {
        // Error executing the query
        echo "<script type='text/javascript'>
                alert('Error executing the query: " . mysqli_error($data) . "');
              </script>";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> User Login</title>
    <link rel="stylesheet" href="login.css">
</head>
<body>
    <div class="container">
        <!-- Left Section: Login Form -->
        <div class="left-section">
            <div class="login-box">
                <h1> User Login</h1>
                <form action="#" method="POST">
                    <div class="input-group">
                        <label>Email:</label>
                        <input type="email" name="email" required>
                    </div>
                    <div class="input-group">
                        <label>Password:</label>
                        <input type="password" name="password" required>
                    </div>
                    <div class="input-group">
                        <input type="submit" value="Login">
                    </div>
                </form>
                <!-- Register Here Text -->
                <p class="register-text">New user? <a href="userregister.php">Register here</a></p>
            </div>
        </div>

        <!-- Right Section: Logo and Image -->
        <div class="right-section">
            <!-- You can add a background image or any content here -->
        </div>
    </div>
</body>
</html>

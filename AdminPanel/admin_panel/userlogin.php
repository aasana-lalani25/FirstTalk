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
    <title>User Login</title>
    <link rel="stylesheet" href="login.css">
    <!-- FontAwesome for the eye icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Left Section: Login Form -->
        <div class="left-section">
            <div class="logo-container"></div>
            <div class="login-box">
                <h1>User Login</h1>
                <form action="#" method="POST">
                    <div class="input-group">
                        <label>Email:</label>
                        <input type="email" name="email" required>
                    </div>
                    <div class="input-group">
                        <label>Password:</label>
                        <div class="password-container">
                            <input type="password" id="password" name="password" required>
                            <i class="fa-solid fa-eye" id="togglePassword"></i> <!-- Eye Icon Added -->
                        </div>
                    </div>
                    <div class="input-group">
                        <input type="submit" value="Login">
                    </div>
                    <p class="forgot-password"><a href="forgotpassword.php">Forgot Password?</a></p>
                </form>
                <br>
                <p class="register-text">New user? <a href="userregister.php">Register here</a></p>
            </div>
        </div>

        <!-- Right Section: Logo and Image -->
        <div class="right-section">
            <!-- Background image or other content -->
        </div>
    </div>

    <!-- JavaScript to Toggle Password Visibility -->
    <script>
        document.getElementById("togglePassword").addEventListener("click", function () {
            let passwordField = document.getElementById("password");
            let icon = this;

            if (passwordField.type === "password") {
                passwordField.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                passwordField.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        });
    </script>

    <!-- CSS for Password Field Styling -->
    <style>
        .password-container {
            position: relative;
            width: 100%;
        }
        .password-container input {
            width: 100%;
            padding-right: 40px; /* Space for the icon */
        }
        .password-container i {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 18px;
            color: #555;
        }
    </style>
</body>
</html>


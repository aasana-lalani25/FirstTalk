<?php
session_start();

// Database connection details
$host = "localhost";
$user = "root";
$password = "";
$db = "first_talk";

// Establish the database connection
$data = new mysqli($host, $user, $password, $db);

// Check if connection failed
if ($data->connect_error) {
    die("Database connection failed: " . $data->connect_error);
}

// Handle form submission
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get email and password from the form
    $email = trim($data->real_escape_string($_POST["email"]));
    $password = trim($_POST["password"]);

    // Use prepared statements to prevent SQL injection
    $stmt = $data->prepare("SELECT * FROM login WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    // Check if email exists
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();

        // Verify password
        if (password_verify($password, $row["password"])) {
            $_SESSION["email"] = $row["email"];
            $_SESSION["name"] = $row["name"];

            header("Location: dashboard.php");
            exit();
        } else {
            $_SESSION["error"] = "Incorrect password. Please try again.";
        }
    } else {
        $_SESSION["error"] = "No user found with this email. Please register first.";
    }
    $stmt->close();
    $data->close();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link rel="stylesheet" href="login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="left-section">
            <div class="login-box">
                <h1>Admin Login</h1>

                <!-- Display error message -->
                <?php if (isset($_SESSION["error"])): ?>
                    <div class="error-message">
                        <?php 
                        echo $_SESSION["error"];
                        unset($_SESSION["error"]); // Clear the message after displaying
                        ?>
                    </div>
                <?php endif; ?>

                <form action="login.php" method="POST">
                    <div class="input-group">
                        <label>Email:</label>
                        <input type="email" name="email" required>
                    </div>
                    <div class="input-group">
                        <label>Password:</label>
                        <div class="password-container">
                            <input type="password" id="password" name="password" required>
                            <i class="fa-solid fa-eye" id="togglePassword"></i>
                        </div>
                    </div>
                    <div class="input-group">
                        <input type="submit" value="Login">
                    </div>
                    <p class="forgot-password"><a href="forgotpassword.php">Forgot Password?</a></p>
                </form>
                <p class="register-text">New admin? <a href="register.php">Register here</a></p>
            </div>
        </div>

        <div class="right-section"></div>
    </div>

    <!-- JavaScript for password visibility toggle -->
    <script>
        document.getElementById("togglePassword").addEventListener("click", function () {
            let passwordField = document.getElementById("password");
            let icon = this;

            if (passwordField.type === "password") {
                passwordField.type = "text";
                icon.classList.replace("fa-eye", "fa-eye-slash");
            } else {
                passwordField.type = "password";
                icon.classList.replace("fa-eye-slash", "fa-eye");
            }
        });
    </script>

    <!-- CSS for error message and password field -->
    <style>
        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .password-container {
            position: relative;
            width: 100%;
        }
        .password-container input {
            width: 100%;
            padding-right: 40px;
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

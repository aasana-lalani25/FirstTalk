<?php
session_start();
$host = "localhost";
$user = "root";
$password = "";
$db = "first_talk";

// Database connection
$data = mysqli_connect($host, $user, $password, $db);
if ($data === false) {
    die("Connection error");
}

// Get token from URL
$token = isset($_GET['token']) ? $_GET['token'] : '';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $new_password = trim($_POST["password"]);
    $confirm_password = trim($_POST["confirm_password"]);

    if ($new_password !== $confirm_password) {
        echo "<script>alert('Passwords do not match.');</script>";
    } elseif (strlen($new_password) < 6) {
        echo "<script>alert('Password must be at least 6 characters long.');</script>";
    } else {
        // Validate token
        $sql = "SELECT * FROM userlogin WHERE reset_token='$token' AND reset_expiry > NOW()";
        $result = mysqli_query($data, $sql);

        if (mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_array($result);
            $hashed_password = password_hash($new_password, PASSWORD_DEFAULT);

            // Update password and remove reset token
            $update = "UPDATE userlogin SET password='$hashed_password', reset_token=NULL, reset_expiry=NULL WHERE reset_token='$token'";
            if (mysqli_query($data, $update)) {
                echo "<script>alert('Password reset successful. Please login.'); window.location.href='login.php';</script>";
            } else {
                echo "<script>alert('Error updating password.');</script>";
            }
        } else {
            echo "<script>alert('Invalid or expired token.'); window.location.href='forgotpassword.php';</script>";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link rel="stylesheet" href="login.css"> <!-- Same theme as login -->
</head>
<body>
    <div class="container">
        <div class="left-section">
            <div class="login-box">
                <h1>Reset Password</h1>
                <p>Enter your new password below.</p>
                <form action="#" method="POST">
                    <div class="input-group">
                        <label>New Password:</label>
                        <input type="password" name="password" required>
                    </div>
                    <div class="input-group">
                        <label>Confirm Password:</label>
                        <input type="password" name="confirm_password" required>
                    </div>
                    <div class="input-group">
                        <input type="submit" value="Reset Password">
                    </div>
                </form>
                <p class="register-text"><a href="login.php">Back to Login</a></p>
            </div>
        </div>
        <div class="right-section">
            <!-- You can add an image or keep it as per theme -->
        </div>
    </div>
</body>
</html>

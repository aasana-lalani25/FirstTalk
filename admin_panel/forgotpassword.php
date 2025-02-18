<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'vendor/autoload.php'; // Load PHPMailer (If using Composer)

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

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = trim(mysqli_real_escape_string($data, $_POST["email"]));

    // Check if email exists
    $sql = "SELECT * FROM login WHERE email = '$email'";
    $result = mysqli_query($data, $sql);
    
    if (mysqli_num_rows($result) > 0) {
        // Generate a unique reset token
        $token = bin2hex(random_bytes(50));

        // Set expiry time (1 hour from now)
        $expiry = date("Y-m-d H:i:s", strtotime("+1 hour"));
        $update = "UPDATE login SET reset_token='$token', reset_expiry='$expiry' WHERE email='$email'";
        
        if (mysqli_query($data, $update)) {
            // Email reset link
            $reset_link = "http://yourwebsite.com/resetpassword.php?token=$token"; // Change to your domain
            
            // Initialize PHPMailer
            $mail = new PHPMailer(true);

            try {
                $mail->isSMTP();
                $mail->Host = 'smtp.gmail.com';
                $mail->SMTPAuth = true;
                $mail->Username = 'firsttalkit@gmail.com'; // Change this
                $mail->Password = 'FirstTalk@mscit'; // Use an App Password if 2FA is enabled
                $mail->SMTPSecure = 'tls';
                $mail->Port = 587;

                $mail->setFrom('firsttalkit@gmail.com', 'FirstTalk');
                $mail->addAddress($email);

                $mail->isHTML(true);
                $mail->Subject = 'Password Reset Request';
                $mail->Body = "
                    <h2>Password Reset Request</h2>
                    <p>Click the link below to reset your password:</p>
                    <p><a href='$reset_link' style='color: blue;'>Reset Password</a></p>
                    <p>This link is valid for 1 hour.</p>
                ";

                $mail->send();
                echo "<script>alert('A password reset link has been sent to your email.');</script>";
            } catch (Exception $e) {
                echo "<script>alert('Mailer Error: " . $mail->ErrorInfo . "');</script>";
            }
        } else {
            echo "<script>alert('Error updating reset token.');</script>";
        }
    } else {
        echo "<script>alert('No user found with this email.');</script>";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="login.css"> <!-- Same theme as login -->
</head>
<body>
    <div class="container">
        <div class="left-section">
            <div class="login-box">
                <h1>Forgot Password?</h1>
                <p>Enter your email, and we will send you a reset link.</p>
                <form action="#" method="POST">
                    <div class="input-group">
                        <label>Email:</label>
                        <input type="email" name="email" required>
                    </div>
                    <div class="input-group">
                        <input type="submit" value="Send Reset Link">
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

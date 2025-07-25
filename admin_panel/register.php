<?php
$host = "localhost";
$user = "root";
$password = "";
$db = "first_talk";

// Connect to the database
$data = mysqli_connect($host, $user, $password, $db);
if ($data === false) {
    die("Connection error");
}

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get form data
    $name = mysqli_real_escape_string($data, $_POST["name"]);
    $email = mysqli_real_escape_string($data, $_POST["email"]);
    $password = mysqli_real_escape_string($data, $_POST["password"]);

    // Check if the email already exists in the database
    $check_sql = "SELECT * FROM login WHERE email = '$email'";
    $result = mysqli_query($data, $check_sql);
    if (mysqli_num_rows($result) > 0) {
        // If user exists, show error
        echo "<script type='text/javascript'>
                alert('This email is already registered!');
              </script>";
    } else {
        // Hash the password for security
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        // Insert the user data into the database
        $sql = "INSERT INTO login (name, email, password) VALUES ('$name', '$email', '$hashed_password')";

        if (mysqli_query($data, $sql)) {
            // Show success popup on successful registration
            echo "<script type='text/javascript'>
                    alert('Registration successful!');
                  </script>";
        } else {
            // If error occurred while inserting
            echo "<script type='text/javascript'>
                    alert('Error: " . mysqli_error($data) . "');
                  </script>";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration</title>
    <link rel="stylesheet" href="register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> <!-- FontAwesome -->
    <script>
        // Function to check password validity
        function validatePassword() {
            const password = document.getElementById("password").value;
            const passwordMessage = document.getElementById("password-message");
            const submitButton = document.getElementById("submit-button");

            const passwordPattern = /^(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;

            if (password.match(passwordPattern)) {
                passwordMessage.style.display = "none";
                submitButton.disabled = false;
            } else {
                passwordMessage.style.display = "block";
                submitButton.disabled = true;
            }
        }

        // Function to check email validity
        function validateEmail() {
            const email = document.getElementById("email").value;
            const emailMessage = document.getElementById("email-message");
            const submitButton = document.getElementById("submit-button");

            const emailPattern = /^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com)$/;

            if (email.match(emailPattern)) {
                emailMessage.style.display = "none";
                submitButton.disabled = false;
            } else {
                emailMessage.style.display = "block";
                submitButton.disabled = true;
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <!-- Left Section (Form) -->
        <div class="left-section">
            <!-- Logo Container -->
            <div class="logo-container">

            </div>

            <div class="login-box">
                <h1>Admin Registration</h1>
                <form action="#" method="POST">
                    <div class="input-group">
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" required>
                    </div>

                    <div class="input-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required oninput="validateEmail()">
                        <p id="email-message" style="color: red; display: none;">Please enter a valid email (Gmail or Yahoo)</p>
                    </div>

                    <div class="input-group">
                        <label for="password">Password:</label>
                        <div class="password-container">
                            <input type="password" id="password" name="password" required oninput="validatePassword()">
                            <i class="fa-solid fa-eye" id="togglePassword"></i> <!-- Eye icon -->
                        </div>
                        <p id="password-message" style="color: red; display: none;">Password must be at least 8 characters long, contain 1 uppercase letter, 1 number, and 1 special character.</p>
                    </div>

                    <button type="submit" class="btn" id="submit-button" disabled>Register</button>
                    <p class="register-text">Already have an account? <a href="login.php">Login here</a></p>
                </form>
            </div>
        </div>

        <!-- Right Section -->
        <div class="right-section">
            <div class="image-container"></div>
        </div>
    </div>

    <!-- JavaScript to toggle password visibility -->
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

    <!-- CSS for password field styling -->
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

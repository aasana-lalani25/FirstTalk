<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome - Deaf App Admin Panel</title>
    <link rel="stylesheet" href="welcome.css">
    <script>
        // Function to navigate to the login or register page
        function navigateToPage(option) {
            if (option === 'login') {
                window.location.href = 'login.php'; // Admin login
            } else if (option === 'register') {
                window.location.href = 'register.php'; // Admin register
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <!-- Left Section: Logo and Description -->
        <div class="left-section">
            <div class="logo-container">
                <img src="logo.jpeg" alt="App Logo" class="logo">
                <h1>FirstTalk</h1>
                <p class="description">A platform to connect, communicate, and create a positive impact for the Deaf community.</p>
            </div>
        </div>

        <!-- Right Section: Image and Buttons -->
        <div class="right-section" style="position: relative;">
            <!-- Admin Buttons -->
            <div class="admin-buttons" style="position: absolute; top: 20px; right: 20px; display: flex; gap: 10px; z-index: 2;">
                <button class="admin-btn" onclick="navigateToPage('login')">Admin Login</button>
                <button class="admin-btn" onclick="navigateToPage('register')">Admin Register</button>
            </div>
            <img src="bg.png" alt="Background Image" class="background-image" style="position: relative; z-index: 1;">
        </div>
    </div>
</body>
</html>

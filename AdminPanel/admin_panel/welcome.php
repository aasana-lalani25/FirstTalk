<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome - Deaf App Admin Panel</title>
    <link rel="stylesheet" href="welcome.css">
    <script>
        // Function to toggle the visibility of the dropdown menu for User or Admin
        function toggleDropdown(buttonType) {
            const userDropdown = document.getElementById('user-dropdown');
            const adminDropdown = document.getElementById('admin-dropdown');

            // Close the opposite dropdown
            if (buttonType === 'user') {
                if (adminDropdown.style.display === 'block') {
                    adminDropdown.style.display = 'none';
                }
                // Toggle the user dropdown
                userDropdown.style.display = (userDropdown.style.display === 'block') ? 'none' : 'block';
            } else if (buttonType === 'admin') {
                if (userDropdown.style.display === 'block') {
                    userDropdown.style.display = 'none';
                }
                // Toggle the admin dropdown
                adminDropdown.style.display = (adminDropdown.style.display === 'block') ? 'none' : 'block';
            }
        }

        // Function to navigate to the login or register page based on the selection
        function navigateToPage(buttonType, option) {
            if (buttonType === 'admin') {
                if (option === 'login') {
                    window.location.href = 'login.php'; // Admin login should now redirect to login.php
                } else if (option === 'register') {
                    window.location.href = 'register.php'; // Admin register page
                }
            } else if (buttonType === 'user') {
                if (option === 'login') {
                    window.location.href = 'userlogin.php'; // User login page
                } else if (option === 'register') {
                    window.location.href = 'userregister.php'; // User register page
                }
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
        <div class="right-section">
            <!-- Navigation buttons (User and Admin) -->
            <div class="top-buttons">
                <button class="user-btn" onclick="toggleDropdown('user')">User</button>
                <!-- User Dropdown Menu -->
                <div id="user-dropdown" class="dropdown-menu" style="display: none;">
                    <button class="dropdown-item" onclick="navigateToPage('user', 'login')">User Login</button>
                    <button class="dropdown-item" onclick="navigateToPage('user', 'register')">User Register</button>
                </div>

                <button class="admin-btn" onclick="toggleDropdown('admin')">Admin</button>
                <!-- Admin Dropdown Menu -->
                <div id="admin-dropdown" class="dropdown-menu" style="display: none;">
                    <button class="dropdown-item" onclick="navigateToPage('admin', 'login')">Admin Login</button> <!-- Admin Login should now go to login.php -->
                    <button class="dropdown-item" onclick="navigateToPage('admin', 'register')">Admin Register</button>
                </div>
            </div>
            <img src="bg_login.png" alt="Background Image" class="background-image">
        </div>
    </div>
</body>
</html>

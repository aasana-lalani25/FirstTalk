<?php
session_start();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Home</title>
</head>
<body>
    <h1> This is User Dashboard</h1>
    <p>Welcome, <?php echo $_SESSION["name"]; ?>!</p>

    <!-- Logout link -->
    <a href="userlogout.php">Logout</a>
</body>
</html>

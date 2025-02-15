<?php
session_start();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Home</title>
</head>
<body>
    <h1> This is Admin Dashboard</h1> 
    <?php echo $_SESSION["name"]; ?>

    <a href="logout.php">Logout</a>
</body>
</html>
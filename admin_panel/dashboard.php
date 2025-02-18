<?php
session_start();

// Redirect if not logged in
if (!isset($_SESSION['email'])) {
    header("Location: login.php");
    exit();
}

// Fetch admin name from session
$adminName = isset($_SESSION['name']) ? $_SESSION['name'] : 'Admin';
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
        }
        .sidebar {
            width: 210px;
            background: #f5a623;
            min-height: 100vh;
            padding: 20px;
            color: white;
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .logo-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .logo-container img {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: 50%;
        }
        .sidebar h2 {
            margin-top: 15px;
            font-size: 18px;
            text-align: center;
        }
        .content {
            flex-grow: 1;
            padding: 20px;
            margin-left: 240px;
            width: calc(100% - 240px);
        }
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .profile-container {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
        }
        .profile-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #000;
            border: 2px solid #000;
        }
        .profile-icon i {
            font-size: 20px;
            color: white;
        }
        .profile-text {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }
        .cards-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            gap: 15px;
        }
        .card {
            background: white;
            padding: 20px;
            flex: 1;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            font-size: 18px;
            font-weight: bold;
        }
        .charts-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
            flex-wrap: wrap;
        }
        .chart-container {
            width: 320px;
            height: 320px;
            background: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        canvas {
            max-width: 100%;
            max-height: 280px;
        }
        @media (max-width: 768px) {
            .sidebar {
                width: 180px;
            }
            .content {
                margin-left: 200px;
                width: calc(100% - 200px);
            }
            .cards-container {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo-container">
            <img src="logo.jpeg" alt="Logo">
            <h1>First Talk</h1>
        </div>
        <h2 id="adminGreeting">Loading...</h2> <!-- Admin name and email will be displayed here -->
    </div>
    <div class="content">
        <div class="dashboard-header">
            <h1>Dashboard</h1>
            <div class="profile-container" onclick="window.location.href='profile.php'">
                <div class="profile-icon">
                    <i class="fas fa-user"></i>
                </div>
                <span class="profile-text" id="adminName">Loading...</span>
            </div>
        </div>
        <div class="cards-container">
            <div class="card">Total Users: 50</div>
            <div class="card">Active Users: 35</div>
            <div class="card">Inactive Users: 15</div>
        </div>
        <div class="charts-container">
            <div class="chart-container">
                <h3>Age Category</h3>
                <canvas id="ageChart"></canvas>
            </div>
            <div class="chart-container">
                <h3>Gender Distribution</h3>
                <canvas id="genderChart"></canvas>
            </div>
        </div>
    </div>

    <script>
        // Fetch and display the admin's name and email
        document.addEventListener("DOMContentLoaded", function () {
            fetch('get_admin_name.php')
                .then(response => response.json())
                .then(data => {
                    if (data.error) {
                        console.error("Error:", data.error);
                        document.getElementById('adminName').textContent = "Admin";
                        document.getElementById('adminGreeting').textContent = "Hello, Admin!";
                    } else {
                        document.getElementById('adminName').textContent = data.name;
                        document.getElementById('adminGreeting').innerHTML = `Hello, ${data.name}!<br><small>${data.email}</small>`;
                    }
                })
                .catch(error => {
                    console.error("Fetch error:", error);
                    document.getElementById('adminName').textContent = "Admin";
                    document.getElementById('adminGreeting').textContent = "Hello, Admin!";
                });
        });

        // Chart.js Configuration
        const ageCtx = document.getElementById('ageChart').getContext('2d');
        new Chart(ageCtx, {
            type: 'bar',
            data: {
                labels: ['0-20', '21-40', '41-60', '61+'],
                datasets: [{
                    label: 'Users',
                    data: [20, 30, 50, 40],
                    backgroundColor: '#f5a623'
                }]
            }
        });

        const genderCtx = document.getElementById('genderChart').getContext('2d');
        new Chart(genderCtx, {
            type: 'doughnut',
            data: {
                labels: ['Female', 'Male', 'Other'],
                datasets: [{
                    data: [25, 30, 5],
                    backgroundColor: ['#3498db', '#e74c3c', '#2ecc71']
                }]
            }
        });
    </script>
</body>
</html>

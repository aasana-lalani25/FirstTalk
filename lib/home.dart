import 'package:flutter/material.dart';
import 'courses.dart';// Ensure CoursesPage is correctly imported
import 'profile.dart';

// Home page where user's name will be displayed
class HomePage extends StatelessWidget {
  final String userName;

  // Constructor that takes the name passed from the registration page
  const HomePage({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          // User's name displayed below the AppBar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                'Hi, $userName!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Profile Details button with icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30), // Adjust padding for vertical space
            child: ElevatedButton.icon(
              onPressed: () {
                // Navigate to the Profile Details page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileDetailsPage()), // Correct navigation here
                );
              },
              icon: Icon(Icons.person, color: Colors.black),
              label: Text(
                'Profile Details',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                minimumSize: Size(double.infinity, 50), // Make the button take full width
              ),
            ),
          ),
          // Your Courses button with icon (similar to Profile Details button)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10), // Adjust padding for vertical space
            child: ElevatedButton.icon(
              onPressed: () {
                // Navigate to the Your Courses page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CoursesPage()), // Correct navigation here
                );
              },
              icon: Icon(Icons.line_weight, color: Colors.black), // Icon for Your Courses button
              label: Text(
                'Your Courses',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                minimumSize: Size(double.infinity, 50), // Make the button take full width
              ),
            ),
          ),
          // Expanded widget to take up remaining space
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(0), // Adjust bottom padding if needed
                child: Image.asset(
                  'assets/home.jpg', // Make sure to add this image in the assets folder
                  width: double.infinity, // Make the image fill the width of the screen
                  fit: BoxFit.fill, // Adjust the image's aspect ratio to cover the space
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



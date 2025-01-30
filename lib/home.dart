import 'package:flutter/material.dart';

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display user name with greeting
              Text(
                'Hi, $userName!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Profile Details button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Profile Details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileDetailsPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,  // Use backgroundColor instead of primary
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: Text(
                  'Profile Details',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              // Your Courses button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Your Courses page (example)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => YourCoursesPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,  // Use backgroundColor instead of primary
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: Text(
                  'Your Courses',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example Profile Details Page
class ProfileDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Text('Profile details content goes here.'),
      ),
    );
  }
}

// Example Your Courses Page
class YourCoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Courses'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Text('Courses content goes here.'),
      ),
    );
  }
}

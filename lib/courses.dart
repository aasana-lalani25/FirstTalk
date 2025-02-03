import 'package:first_talk/profile.dart';
import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('First Talk',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfileDetailsPage()), // Correct navigation here
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              height: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/people_talking.jpg'),
                  // Placeholder image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 130),
            Text('Translate with FirstTalk',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _buildOption(Icons.document_scanner, 'Sign language translate'),
            _buildOption(Icons.video_library, 'Learning with videos'),
            _buildOption(Icons.upload, 'Upload Videos'),
            _buildOption(Icons.search, 'Search in'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orangeAccent,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {},
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: Colors.black,
            ),
            SizedBox(width: 16),
            Text(title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

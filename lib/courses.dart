import 'package:deaf_app/profile.dart';
import 'package:flutter/material.dart';
import 'search.dart';
import 'learning_videos_page.dart';
import 'camera.dart';
import 'upload.dart';

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
                    builder: (context) => ProfileDetailsPage()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/people_talking.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 130),
              Text('Translate with FirstTalk',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              _buildOption(Icons.document_scanner, 'Sign language translate', context),
              _buildOption(Icons.video_library, 'Learning with videos', context),
              _buildOption(Icons.upload, 'Upload Media', context),
              _buildOption(Icons.search, 'Search In', context),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String title, [BuildContext? context]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orangeAccent,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {
          if (title == 'Sign language translate' && context != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignLanguageTranslationPage(),
              ),
            );
          } else if (title == 'Search In' && context != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ),
            );
          } else if (title == 'Learning with videos' && context != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LearningVideosPage(),
              ),
            );
          } else if (title == 'Upload Media' && context != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadPage(),
              ),
            );
          }
        },
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.black),
            SizedBox(width: 16),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

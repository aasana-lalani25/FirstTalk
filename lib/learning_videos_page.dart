import 'package:flutter/material.dart';

class LearningVideosPage extends StatelessWidget {
  final List<Map<String, String>> videoData = [
    {
      'title': 'How to Sign Language',
      'thumbnail': 'assets/howtosign.jpeg'
    },
    {
      'title': 'Understanding Sign Language',
      'thumbnail': 'assets/understand.jpeg'
    },
    {
      'title': 'Sign Language Basics',
      'thumbnail': 'assets/basic.jpeg'
    },
    // Add more video data here with title and thumbnail
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          'Learning with Videos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      centerTitle: true,),
      body: ListView.builder(
        itemCount: videoData.length,
        itemBuilder: (context, index) {
          return VideoTile(
            title: videoData[index]['title']!,
            thumbnail: videoData[index]['thumbnail']!,
          );
        },
      ),
    );
  }
}

class VideoTile extends StatelessWidget {
  final String title;
  final String thumbnail;

  VideoTile({required this.title, required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Image.asset(thumbnail,
                width: double.infinity, height: 180, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LearningVideosPage extends StatelessWidget {
  final List<Map<String, String>> videoData = [
    {
      'title': 'How to Sign Language',
      'videoUrl': 'assets/videos/howtosign.mp4', // Path to your video file
    },
    {
      'title': 'Understanding Sign Language',
      'videoUrl': 'assets/videos/understand.mp4', // Path to your video file
    },
    {
      'title': 'Sign Language Basics',
      'videoUrl': 'assets/videos/basic.mp4', // Path to your video file
    },
    // Add more video data here with title and video URL
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
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: videoData.length,
        itemBuilder: (context, index) {
          return VideoTile(
            title: videoData[index]['title']!,
            videoUrl: videoData[index]['videoUrl']!,
          );
        },
      ),
    );
  }
}

class VideoTile extends StatefulWidget {
  final String title;
  final String videoUrl;

  VideoTile({required this.title, required this.videoUrl});

  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            _controller.value.isInitialized
                ? GestureDetector(
              onTap: _togglePlayPause,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            )
                : Container(
              height: 180,
              color: Colors.grey[300],
              child: Center(child: CircularProgressIndicator()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
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

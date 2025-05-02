import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LearningVideosPage extends StatelessWidget {
  final List<Map<String, String>> videoData = [
    {
      'title': 'Learn Sign Language',
      'videoUrl': 'https://www.youtube.com/watch?v=6w1ZDaE-whc',
    },
    {
      'title': 'ASL for Kids',
      'videoUrl': 'https://youtu.be/fnFWAzd3Kfw?si=QQD9K2oNiHd4qphp',
    },
    {
      'title': 'Basic ASL Colors',
      'videoUrl': 'https://youtu.be/Sa9UNIQbAXM?si=C_LKiuIQhzNZG5LV',
    },
    {
      'title': 'Warmup Games',
      'videoUrl': 'https://youtu.be/HZj8zm7KXug?si=lquCurGOdCLJo3VB',
    },
    {
      'title': '100 Basic Signs - American Sign Language',
      'videoUrl': 'https://www.youtube.com/watch?v=Raa0vBXA8OQ',
    },
    {
      'title': 'Indian Sign Language',
      'videoUrl': 'https://youtu.be/JPV-vboWfhY?si=lwqaeqQuQhQzM7Vb',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Learning with Videos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: videoData.length,
        itemBuilder: (context, index) {
          return YouTubeVideoTile(
            title: videoData[index]['title']!,
            videoUrl: videoData[index]['videoUrl']!,
          );
        },
      ),
    );
  }
}

class YouTubeVideoTile extends StatefulWidget {
  final String title;
  final String videoUrl;

  const YouTubeVideoTile({
    Key? key,
    required this.title,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _YouTubeVideoTileState createState() => _YouTubeVideoTileState();
}

class _YouTubeVideoTileState extends State<YouTubeVideoTile> {
  late YoutubePlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    if (videoId == null || videoId.isEmpty) {
      print('⚠️ Invalid YouTube URL: ${widget.videoUrl}');
    }

    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
        controlsVisibleAtStart: true,
        useHybridComposition: true, // ✅ Essential for proper playback
      ),
    );

    _controller.addListener(() {
      final isPlayingNow = _controller.value.isPlaying;
      if (_isPlaying != isPlayingNow) {
        setState(() {
          _isPlaying = isPlayingNow;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                bottomActions: [
                  const SizedBox(width: 10),
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                  PlaybackSpeedButton(), // ✅ Make sure this is added
                  FullScreenButton(),
                ],
              ),
              builder: (context, player) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: _togglePlayPause,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: player,
                            ),
                          ),
                          if (!_isPlaying)
                            const Icon(Icons.play_circle_fill,
                                size: 64, color: Colors.white70),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

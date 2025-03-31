import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final List<File> _uploadedMedia = [];

  Future<void> _pickMedia(ImageSource source, {bool isVideo = false}) async {
    final pickedFile = isVideo
        ? await ImagePicker().pickVideo(source: source)
        : await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      File mediaFile = File(pickedFile.path);
      _confirmUpload(mediaFile);
    }
  }

  void _confirmUpload(File mediaFile) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Upload"),
        content: Text("Are you sure you want to upload this file?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _uploadedMedia.add(mediaFile);
              });
              Navigator.pop(context);
            },
            child: Text("Upload"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload Media",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _pickMedia(ImageSource.gallery, isVideo: false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.image, color: Colors.black),
                      SizedBox(width: 10),
                      Text("Select Image", style: TextStyle(fontSize: 16, color: Colors.black)),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _pickMedia(ImageSource.gallery, isVideo: true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.video_library, color: Colors.black),
                      SizedBox(width: 10),
                      Text("Select Video", style: TextStyle(fontSize: 16, color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _uploadedMedia.isEmpty
                ? Center(child: Text("No media uploaded yet."))
                : GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _uploadedMedia.length,
              itemBuilder: (context, index) {
                File mediaFile = _uploadedMedia[index];
                return mediaFile.path.endsWith(".mp4")
                    ? VideoPreview(videoFile: mediaFile)
                    : Image.file(mediaFile, fit: BoxFit.cover);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPreview extends StatefulWidget {
  final File videoFile;

  VideoPreview({required this.videoFile});

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.value.isPlaying ? _controller.pause() : _controller.play();
      },
      child: _controller.value.isInitialized
          ? ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
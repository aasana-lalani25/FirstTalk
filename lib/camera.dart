import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SignLanguageTranslationPage extends StatefulWidget {
  @override
  _SignLanguageTranslationPageState createState() => _SignLanguageTranslationPageState();
}

class _SignLanguageTranslationPageState extends State<SignLanguageTranslationPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isRecording = false;
  XFile? _videoFile;
  String _gestureText = ""; // Simulated translation text

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        _cameraController = CameraController(_cameras![0], ResolutionPreset.medium);
        await _cameraController!.initialize();
        if (mounted) {
          setState(() {});
        }
      } else {
        throw Exception("No cameras found");
      }
    } catch (e) {
      print("Camera error: $e");
    }
  }

  Future<void> _startRecording() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;

    try {
      await _cameraController!.startVideoRecording();
      setState(() {
        _isRecording = true;
        _gestureText = "Recording Started..."; // Indicate recording
      });
    } catch (e) {
      print("Error starting video recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    if (_cameraController == null || !_cameraController!.value.isRecordingVideo) return;

    try {
      XFile videoFile = await _cameraController!.stopVideoRecording();
      setState(() {
        _isRecording = false;
        _videoFile = videoFile;
        _gestureText = _generateGestureText(); // Simulated translation
      });

      print("Video saved at: ${videoFile.path}");
    } catch (e) {
      print("Error stopping video recording: $e");
    }
  }

  // Simulating gesture recognition output
  String _generateGestureText() {
    // In a real-world scenario, you'd use an ML model here
    List<String> sampleTexts = [
      "I love you!"
    ];
    return "Detected Gesture: ${sampleTexts[DateTime.now().second % sampleTexts.length]}";
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Language Translation",
          style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: _cameraController == null || !_cameraController!.value.isInitialized
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: CameraPreview(_cameraController!),
          ),
          SizedBox(height: 10),
          Text(
            _gestureText,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                if (_isRecording) {
                  await _stopRecording();
                } else {
                  await _startRecording();
                }
              },
              icon: Icon(_isRecording ? Icons.stop : Icons.videocam, color: Colors.black),
              label: Text(_isRecording ? "Stop" : "Start Recording",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
            ),
          ),
        ],
      ),
    );
  }
}
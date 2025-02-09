import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AnalyzingProvider with ChangeNotifier {

  VideoPlayerController? _controller;
  bool _isVideoSelected = false;
  bool _isPlaying = false;
  bool _isFullScreen = false;
  String? _selectedAction;

  VideoPlayerController? get controller => _controller;
  bool get isVideoSelected => _isVideoSelected;
  String? get selectedAction => _selectedAction; // Getter for selected action

  Future<void> pickVideo() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);

      if (result != null && result.files.single.path != null) {
        _controller?.dispose();
        _controller = VideoPlayerController.file(File(result.files.single.path!))
          ..initialize().then((_) {
            _isVideoSelected = true;
            notifyListeners();
          });
      }
    } catch (e) {
      debugPrint("Error picking video: $e");
    }
  }

  void togglePlayPause() {
    if (_controller != null) {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
      _isPlaying = !_isPlaying;
      notifyListeners();
    }
  }

  void toggleFullScreen(BuildContext context) {
    if (_controller != null) {
      if (_isFullScreen) {
        Navigator.pop(context);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              ),
            ),
          ),
        );
      }
      _isFullScreen = !_isFullScreen;
      notifyListeners();
    }
  }

  void setSelectedAction(String? action) {
    _selectedAction = action;
    notifyListeners();
  }

  // Method to deselect the video
  void deselectVideo() {
    _controller?.dispose();
    _controller = null;
    _isVideoSelected = false;
    _isPlaying = false;
    _selectedAction = null;
    notifyListeners(); // Notify listeners to update the UI
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

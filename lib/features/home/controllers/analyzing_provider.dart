import 'dart:convert';
import 'dart:io';
import 'package:deepfake/repository/analyzing_repository.dart';
import 'package:deepfake/resources/routes/route_names.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AnalyzingProvider with ChangeNotifier {

  final AnalyzingRepository _analyzingRepository;

  AnalyzingProvider(this._analyzingRepository);

  VideoPlayerController? _controller;
  File? _selectedVideo;
  bool _isVideoSelected = false;
  bool _isPlaying = false;
  bool _isFullScreen = false;
  String? _selectedAction;
  String? _analysisMessage;
  bool? _isDeepFake;
  String _iconPath = 'assets/images/normal_icon.png';
  bool _isAnalyzing = false;
  bool get isAnalyzing => _isAnalyzing;



  VideoPlayerController? get controller => _controller;
  bool get isVideoSelected => _isVideoSelected;
  String? get selectedAction => _selectedAction;
  String? get analysisMessage => _analysisMessage;
  bool? get isDeepFake => _isDeepFake;
  String get iconPath => _iconPath;


  Future<void> pickVideo() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);

      if (result != null && result.files.single.path != null) {
        _selectedVideo = File(result.files.single.path!);
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

  Future<void> analyzeVideo(BuildContext context) async {
    if (_selectedVideo == null || _selectedAction == null) {
      _analysisMessage = "Error: Please select both a video and an action before analyzing.";
      notifyListeners();
      debugPrint("Error: Please select both a video and an action before analyzing.");
      return;
    }

    _isAnalyzing = true;
    notifyListeners();

    try {
      // Directly assign the parsed JSON response
      Map<String, dynamic> jsonResponse = await _analyzingRepository.analyzingVideo(_selectedVideo!, _selectedAction!);

      Map<String, dynamic> eyeModel = jsonResponse["predictions"]["eye_model"];
      Map<String, dynamic> lipModel = jsonResponse["predictions"]["lip_model"];

      double eyeFakeConfidence = eyeModel["confidence"]["Fake"];
      double lipFakeConfidence = lipModel["confidence"]["Fake"];

      // Set icon based on confidence scores

      bool isDeepFake = (eyeFakeConfidence > 0.5 || lipFakeConfidence > 0.5);
      _iconPath = isDeepFake ? 'assets/images/deep_fake_icon.png' : 'assets/images/normal_icon.png';

      _analysisMessage = "Analysis Complete.";
      notifyListeners();

      if(!context.mounted) return;
      if (isDeepFake) {
        Navigator.pushNamed(context, RouteNames.normalScreen);
      } else {
        Navigator.pushNamed(context, RouteNames.normalScreen);
      }

      debugPrint("Video analysis request sent successfully.");
    } catch (e) {
      _analysisMessage = "Error analyzing video: $e";
      debugPrint("Error analyzing video: $e");
    }
    _isAnalyzing = false;
    notifyListeners();
    deselectVideo();
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

  void setSelectedAction(BuildContext context, String? action) {
    _selectedAction = action;
    _analysisMessage = null;
    notifyListeners();
    analyzeVideo(context);
  }


  void deselectVideo() {
    _controller?.dispose();
    _controller = null;
    _selectedVideo = null;
    _isVideoSelected = false;
    _selectedAction = null;
    _analysisMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

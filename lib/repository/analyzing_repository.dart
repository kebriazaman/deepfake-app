import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class AnalyzingRepository {
  Future<Map<String, dynamic>> analyzingVideo(File videoFile, String action) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://regularly-whole-raccoon.ngrok-free.app/predict/'),
      );

      request.headers.addAll({
        "ngrok-skip-browser-warning": "true",
      });

      request.files.add(await http.MultipartFile.fromPath('video', videoFile.path));
      request.fields['action'] = action;

      var response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        log(responseBody, name: 'AnalyzingResponse');

        return jsonDecode(responseBody) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to analyze video: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Error analyzing video: $e');
    }
  }
}

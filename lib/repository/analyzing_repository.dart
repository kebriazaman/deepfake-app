import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AnalyzingRepository {
  Future<dynamic> analyzingVideo(File videoFile, String action) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://your-api-endpoint.com/analyze'),
      );
      request.files.add(await http.MultipartFile.fromPath('video', videoFile.path));
      request.fields['action'] = action;

      var response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        return jsonDecode(responseBody) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to analyze video: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error analyzing video: $e');
    }

  }

}

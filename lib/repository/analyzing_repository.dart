import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../data/app_exceptions/app_exception.dart';

class AnalyzingRepository {
  Future<Map<String, dynamic>> analyzingVideo(File videoFile, String action) async {

    dynamic jsonResponse;

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

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      log('status code: ${response.statusCode}', name: 'AnalyzingStatus');
      final jsonResponse = returnResponse(response); // 🧠 central response handler

      log(jsonResponse.toString(), name: 'AnalyzingResponse');
      return jsonResponse;
    } on SocketException catch (e) {
      throw NoInternetException('There is no Internet Connection. Please try again.');
    } catch (e) {
      throw Exception('Error analyzing video: $e');
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        log(response.body.toString());
        return jsonDecode(response.body.toString());
      case 201:
        return jsonDecode(response.body.toString());
      case 404:
        final decodedMessage = jsonDecode(response.body.toString());
        String? message = decodedMessage['Data']?['message'];
        message ??= decodedMessage['message'];
        throw UnAuthorizedUserException(message!);
      case 401:
        String message = jsonDecode(response.body.toString())['detail'];
        throw InvalidCredentialsException(message);
      case 403:
        String message = jsonDecode(response.body.toString())['detail'];
        throw UnAuthorizedUserException(message);
      case 409:
        String message = jsonDecode(response.body.toString())['detail'];
        log(message.toString());
        throw UserExistsException(message);
      case 500:
        String message = jsonDecode(response.body.toString())['detail'];
        throw ServerException(message);
      case 400:
        String? message = jsonDecode(response.body.toString())['detail'];
        throw ServerException(message ?? 'Something went wrong.');
    }
  }


}

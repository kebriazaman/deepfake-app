import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../data/app_exceptions/app_exception.dart';


class AuthRepository {
  Future<dynamic> loginUser({required String email, required String password}) async {

    dynamic jsonResponse;
    try {

      dynamic response = await http.post(
        Uri.parse('https://regularly-whole-raccoon.ngrok-free.app/login'),
        body: {'username': email, 'password': password},
      ).timeout(const Duration(seconds: 6));

      log('status code: ${response.statusCode}');
      jsonResponse = returnResponse(response);
    }  on SocketException {
      throw NoInternetException('There is no Internet Connection. Please try again.');
    } on TimeoutException {
      throw RequestTimeoutException('The request took too long. Please check your connection and try again.');
    } catch (e) {
      print("Login failed: $e");
      rethrow;
    }
    return jsonResponse;
  }

  Future<dynamic> signupUser({required String username, required String email, required String confirmPassword}) async {

    dynamic jsonResponse;

    try {
      final response = await http.post(
        Uri.parse('https://regularly-whole-raccoon.ngrok-free.app/signup'),
        body: {
          'username': username,
          'email': email,
          'password': confirmPassword,
        },
      ).timeout(const Duration(seconds: 6));
      log('status code: ${response.statusCode}');
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException('There is no Internet Connection. Please try again.');
    } on TimeoutException {
      throw RequestTimeoutException('The request took too long. Please check your connection and try again.');
    } catch (e) {
      print("Signup failed: $e");
      rethrow;
    }
    return jsonResponse;
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

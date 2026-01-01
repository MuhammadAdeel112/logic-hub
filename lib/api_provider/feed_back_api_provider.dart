import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../core/constants/api_end_points.dart';
import 'session_handling_view_model.dart';

class FeedbackApiProvider extends ChangeNotifier {
  late Future<Map<String, dynamic>> _feedbackRequestFuture = Future.value({});
  bool _isLoading = false;

  Future<Map<String, dynamic>> get feedbackRequestFuture =>
      _feedbackRequestFuture;
  bool get isLoading => _isLoading;

  Future<void> submitFeedback(String name, String email, String phone,
      String additionalFeedback) async {
    try {
      // Set loading to true before initiating the request
      _isLoading = true;
      notifyListeners(); // Notify listeners about the change in loading status

      var token = await SessionHandlingViewModel().getToken();

      final headers = {
        'x-auth-token': token ?? '',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'additionalFeedback': additionalFeedback,
      });

      final response = await http.post(
        Uri.parse(ApiEndPoints.feedbackEndpoint),
        headers: headers,
        body: body,
      );
      print(response.body);
      if (response.statusCode == 200) {
        // Feedback submitted successfully
        _feedbackRequestFuture = Future.value({
          'success': true,
          'message': 'Feedback submitted',
        });
      } else {
        // Handle unsuccessful submission
        final decodedBody = jsonDecode(response.body);
        _feedbackRequestFuture = Future.value({
          'success': false,
          'message': decodedBody['msg'] ?? 'Unknown error',
        });
        print('Error: ${decodedBody['msg'] ?? 'Unknown error'}');
      }
    } catch (e) {
      // Handle any errors during the request
      _feedbackRequestFuture = Future.value({
        'success': false,
        'message': 'Error: $e',
      });
      print('Error: $e');
    } finally {
      // Set loading to false after the request is complete
      _isLoading = false;
      notifyListeners(); // Notify listeners about the change in loading status
    }
  }
}

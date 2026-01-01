import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../core/constants/api_end_points.dart';
import 'session_handling_view_model.dart';

class JobCancelationRequestProvider extends ChangeNotifier {
  // late Future<Map<String, dynamic>> _leaveRequestFuture;
  late Future<Map<String, dynamic>> _jobCancelationRequestFuture =
      Future.value({'success': false, 'message': 'Not submitted'});
  bool _isLoading = false;

  Future<Map<String, dynamic>> get jobCancelationRequestFuture =>
      _jobCancelationRequestFuture;
  bool get isLoading => _isLoading;

  Future<void> submitJobCancelationRequest(
      String JobId, String title, String description) async {
    try {
      _isLoading = true; // Set loading to true before initiating the request
      notifyListeners(); // Notify listeners about the change in loading status

      var token = await SessionHandlingViewModel().getToken();

      final headers = {
        'x-auth-token': token ?? '',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'title': title,
        'reason': description,
      });

      final response = await http.post(
        Uri.parse(ApiEndPoints.jobCancelationRequestEndPoints(JobId)),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        // Leave request submitted successfully
        _jobCancelationRequestFuture = Future.value(
            {'success': true, 'message': 'Leave request submitted'});
      } else {
        // Handle unsuccessful submission
        final decodedBody = jsonDecode(response.body);
        _jobCancelationRequestFuture = Future.value({
          'success': false,
          'message': decodedBody['msg'] ?? 'Unknown error'
        });
        print('Error: ${decodedBody['msg'] ?? 'Unknown error'}');
      }
    } catch (e) {
      // Handle any errors during the request
      _jobCancelationRequestFuture =
          Future.value({'success': false, 'message': 'Error: $e'});
      print('Error: $e');
    } finally {
      _isLoading = false; // Set loading to false after the request is complete
      notifyListeners(); // Notify listeners about the change in loading status
    }
  }
}

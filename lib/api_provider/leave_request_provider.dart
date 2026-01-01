import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../core/constants/api_end_points.dart';
import 'session_handling_view_model.dart';

class LeaveRequestProvider extends ChangeNotifier {
  // late Future<Map<String, dynamic>> _leaveRequestFuture;
  late Future<Map<String, dynamic>> _leaveRequestFuture =
      Future.value({'success': false, 'message': 'Not submitted'});
  bool _isLoading = false;

  Future<Map<String, dynamic>> get leaveRequestFuture => _leaveRequestFuture;

  bool get isLoading => _isLoading;

  Future<void> submitLeaveRequest(
    String role,
    String title,
    String description, {
    String? requestedLeaveHours,
    required String startDate,
    required String endDate,
  }) async {
    try {
      _isLoading = true; // Set loading to true before initiating the request
      notifyListeners(); // Notify listeners about the change in loading status

      var token = await SessionHandlingViewModel().getToken();

      final headers = {
        'x-auth-token': token ?? '',
        'Content-Type': 'application/json',
      };

      final body;

      if (requestedLeaveHours == null) {
        body = jsonEncode({
          'title': title,
          'reason': description,
          'type': role,
          'startDate' : startDate,
          'endDate' : endDate,
        });
      } else {
        body = jsonEncode({
          'title': title,
          'reason': description,
          'type': role,
          'requestedLeaveHours': requestedLeaveHours,
          'startDate' : startDate,
          'endDate' : endDate,
        });
      }

      final response = await http.post(
        Uri.parse(ApiEndPoints.leaveRequestEndPoints),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        // Leave request submitted successfully
        _leaveRequestFuture = Future.value(
            {'success': true, 'message': 'Leave request submitted'});
      } else {
        // Handle unsuccessful submission
        final decodedBody = jsonDecode(response.body);
        _leaveRequestFuture = Future.value({
          'success': false,
          'message': decodedBody['msg'] ?? 'Unknown error'
        });
        print('Error: ${decodedBody['msg'] ?? 'Unknown error'}');
        print("status code : ${response.statusCode}");
      }
    } catch (e) {
      // Handle any errors during the request
      _leaveRequestFuture =
          Future.value({'success': false, 'message': 'Error: $e'});
      print('Error: $e');
    } finally {
      _isLoading = false; // Set loading to false after the request is complete
      notifyListeners(); // Notify listeners about the change in loading status
    }
  }
}

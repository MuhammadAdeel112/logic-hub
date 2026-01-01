

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../core/constants/api_end_points.dart';
import 'session_handling_view_model.dart';

class TaskUpdateApiProvider extends ChangeNotifier {
  late Future<Map<String, dynamic>> _taskUpdateFuture;
  bool _isLoading = false;

  Future<Map<String, dynamic>> get taskUpdateFuture => _taskUpdateFuture;
  bool get isLoading => _isLoading;

  void resetLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateTaskStatus(
      Map<String, dynamic> payload, String jobId) async {
    try {
      _isLoading = true;
      notifyListeners();

      var token = await SessionHandlingViewModel().getToken();
      var headers = {
        'x-auth-token': token ?? '',
        'Content-Type': 'application/json',
      };

      final response = await http.put(
        Uri.parse(ApiEndPoints.taskUpdateEndPoints(jobId)),
        headers: headers,
        body: jsonEncode(payload),
      );

      print(':::response code in API hit of TaskUpdateApiProvider ${response.statusCode}');

      if (response.statusCode == 200) {
        _taskUpdateFuture = Future.value({
          'success': true,
          'message': 'Task update successful',
        });
      } else {
        final decodedBody = jsonDecode(response.body);
        _taskUpdateFuture = Future.value({
          'success': false,
          'message': decodedBody['msg'] ?? 'Unknown error',
        });
        print('Error: ${decodedBody['msg'] ?? 'Unknown error'}');
      }
    } catch (e) {
      _taskUpdateFuture =
          Future.value({'success': false, 'message': 'Error: $e'});
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

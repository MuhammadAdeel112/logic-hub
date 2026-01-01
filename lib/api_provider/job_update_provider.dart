import 'package:divine_employee_app/core/constants/api_end_points.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'session_handling_view_model.dart';

class UpdateJobApiProvider extends ChangeNotifier {
  late Future<Map<String, dynamic>> _jobUpdateRequestFuture;
  bool _isLoading = false;

  Future<Map<String, dynamic>> get jobUpdateRequestFuture =>
      _jobUpdateRequestFuture;
  bool get isLoading => _isLoading;

  void resetLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> updateJob(String jobId, String extraDistance,
      String jobNotes, String extraAmount, String extraTime) async {
    try {
      _isLoading = true;
      notifyListeners();

      var token = await SessionHandlingViewModel().getToken();

      var headers = {
        'x-auth-token': token ?? '',
                'Content-Type': 'application/json; charset=UTF-8',

      };

      // Use the actual URL instead of '{{liveUrlrl}}'
      var request = http.Request(
        'PUT',
        Uri.parse(ApiEndPoints.updateJob(jobId)),
      );
      request.body = json.encode({
        "extraDistance": extraDistance,
        "jobNotes": jobNotes,
        "extraAmount": extraAmount,
        "extraTime": extraTime,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        // Parse the response body if needed
        // Example: var decodedBody = json.decode(await response.stream.bytesToString());
        _jobUpdateRequestFuture = Future.value(
            {'success': true, 'message': 'Job Updated Successfully'});
      } else {
        print(response.reasonPhrase);

        // Handle errors appropriately
        // Example: var decodedBody = json.decode(await response.stream.bytesToString());
        _jobUpdateRequestFuture = Future.value({
          'success': false,
          'message':
              'Job Updation failed', // Provide an appropriate error message
        });
      }
    } catch (e) {
      _jobUpdateRequestFuture =
          Future.value({'success': false, 'message': 'Error: $e'});
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return _jobUpdateRequestFuture;
  }
}

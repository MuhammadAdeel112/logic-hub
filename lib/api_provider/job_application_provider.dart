import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../core/constants/api_end_points.dart';
import 'session_handling_view_model.dart';

class JobApplicationProvider extends ChangeNotifier {
  late Future<Map<String, dynamic>> _jobApplicationFuture =
      Future.value({'success': false, 'message': 'Not submitted'});
  bool _isLoading = false;

  Future<Map<String, dynamic>> get jobApplicationFuture =>
      _jobApplicationFuture;
  bool get isLoading => _isLoading;

  Future<void> submitJobApplication(String jobId) async {
    try {
      _isLoading = true;
      notifyListeners();

      var token = await SessionHandlingViewModel().getToken();

      final headers = {
        'x-auth-token': token ?? '',
      };

      final body = jsonEncode({}); // Add your request body here if needed

      final response = await http.post(
        Uri.parse(ApiEndPoints.jobApplicationEndpoint(jobId)),
        headers: headers,
        body: body.isNotEmpty ? body : null,
      );

      if (response.statusCode == 200) {
        _jobApplicationFuture =
            Future.value({'success': true, 'message': 'Application submitted'});
      } else {
        final decodedBody = jsonDecode(response.body);
        _jobApplicationFuture = Future.value({
          'success': false,
          'message': decodedBody['msg'] ?? 'Unknown error'
        });
        print('Error: ${decodedBody['msg'] ?? 'Unknown error'}');
      }
    } catch (e) {
      _jobApplicationFuture =
          Future.value({'success': false, 'message': 'Error: $e'});
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

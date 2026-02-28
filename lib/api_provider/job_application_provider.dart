import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/api_end_points.dart';
import 'session_handling_view_model.dart';

class JobApplicationProvider extends ChangeNotifier {
  late Future<Map<String, dynamic>> _jobApplicationFuture =
  Future.value({'success': false, 'message': 'Not submitted'});

  bool _isLoading = false;
  final Set<String> _appliedJobIds = {};

  JobApplicationProvider() {
    _loadAppliedJobs();
  }

  Future<Map<String, dynamic>> get jobApplicationFuture => _jobApplicationFuture;
  bool get isLoading => _isLoading;

  // 🔥 String conversion ensure karein taake comparison mein error na aaye
  bool isJobApplied(String jobId) => _appliedJobIds.contains(jobId.toString());

  Future<void> _loadAppliedJobs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? savedIds = prefs.getStringList('applied_ids');
      if (savedIds != null) {
        _appliedJobIds.clear(); // Purana data clear karke fresh load karein
        _appliedJobIds.addAll(savedIds);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error loading IDs: $e");
    }
  }

  Future<void> _saveJobId(String jobId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _appliedJobIds.add(jobId.toString());
      await prefs.setStringList('applied_ids', _appliedJobIds.toList());
      notifyListeners(); // UI ko foran update karega
    } catch (e) {
      debugPrint("Error saving ID: $e");
    }
  }

  Future<void> submitJobApplication(String jobId) async {
    try {
      _isLoading = true;
      _jobApplicationFuture = Future.value({'success': false, 'message': 'Submitting...'});
      notifyListeners();

      var token = await SessionHandlingViewModel().getToken();
      final response = await http.post(
        Uri.parse(ApiEndPoints.jobApplicationEndpoint(jobId)),
        headers: {
          'x-auth-token': token ?? '',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({}),
      );

      final decodedBody = jsonDecode(response.body);

      // 🔥 200, 201, 400, ya 409... har soorat mein lock lagana hai
      if (response.statusCode == 200 || response.statusCode == 201) {
        await _saveJobId(jobId);
        _jobApplicationFuture = Future.value({'success': true, 'message': 'Applied successfully!'});
      } else if (response.statusCode == 400 || response.statusCode == 409) {
        // Agar backend error de ke "Already applied", tab bhi ID save karlein taake UI change ho jaye
        await _saveJobId(jobId);
        _jobApplicationFuture = Future.value({'success': true, 'message': 'Already applied for this job!'});
      } else {
        _jobApplicationFuture = Future.value({'success': false, 'message': decodedBody['msg'] ?? 'Error'});
      }
    } catch (e) {
      _jobApplicationFuture = Future.value({'success': false, 'message': 'Network Error'});
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
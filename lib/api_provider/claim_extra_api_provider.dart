import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:flutter/material.dart';

import '../core/constants/api_end_points.dart';

class ClaimExtraApiProvider with ChangeNotifier {
  bool isLoading = false;
  late Future<Map<String, dynamic>> _claimExtraFuture;

  Future<Map<String, dynamic>> get claimExtraFuture => _claimExtraFuture;
  Future<Map<String, dynamic>> submitIncidentReport({
    required String jobId,
    required String jobNotes,
    required String outofpocket,
    required String extradistance,
    required String extrahours,
    String? imagePath,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      var token = await SessionHandlingViewModel().getToken();

      final headers = {
        'x-auth-token': token ?? '',
      };

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(ApiEndPoints.claimExtraEndPoints(jobId)),
      );

      request.fields.addAll({
        'jobNotes': jobNotes,
        'outofpocket': outofpocket,
        'extradistance': extradistance,
        'extraTime': extrahours,
        'extrahours': extrahours,
      });

      if (imagePath != null) {
        // Add file to the request only if imagePath is not null
        request.files
            .add(await http.MultipartFile.fromPath('imageUrl', imagePath));
      }

      request.headers.addAll(headers);

      final response = await request.send();
      print(':::${response.statusCode}');
      print(':::${response.stream}');
      // Handle response
      if (response.statusCode == 200 || response.statusCode == 201) {
        _claimExtraFuture = Future.value({
          'success': true,
          'message': 'Claim Extra submitted',
        });
        return {
          'success': true,
          'message': 'Request successful',
        };
      } else {
        final decodedBody = jsonDecode(await response.stream.bytesToString());
        _claimExtraFuture = Future.value({
          'success': false,
          'message': decodedBody['msg'] ?? 'Unknown error',
        });
        print('Error: ${response.reasonPhrase}');
        return {
          'success': false,
          'message': decodedBody['msg'] ?? 'Unknown error',
        };
      }
    } catch (e) {
      _claimExtraFuture = Future.value({
        'success': false,
        'message': 'Error: $e',
      });
      print('Error: $e');
      return {
        'success': false,
        'message': 'Error: $e',
      };
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:flutter/material.dart';
import '../core/constants/api_end_points.dart';

class IncidentReportProvider with ChangeNotifier {
  bool isLoading = false;
  late Future<Map<String, dynamic>> _incidentReportFuture;

  Future<Map<String, dynamic>> get incidentReportFuture => _incidentReportFuture;

  Future<Map<String, dynamic>> submitIncidentReport({
    required String jobId,
    required String clientName,
    required String shiftManagerName,
    required DateTime selectedDateTime,
    required String staffDesignation,
    required String location,
    required String incidentType,
    required String actionTakenByStaff,
    required String description,
    required String imagePath,
  }) async {
    try {
      print('\\\\\\\\\\\\\\\\\\\\');

      isLoading = true;
      notifyListeners();

      var token = await SessionHandlingViewModel().getToken();

      final headers = {
        'x-auth-token': token ?? '',
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiEndPoints.generateIncidentReportEndPoints(jobId)),
      );

      request.fields.addAll({
        'clientName': clientName,
        'staffName': shiftManagerName,
        'staffDesignation': staffDesignation,
        'location': location,
        'description': description,
        'time': selectedDateTime.toString(),
        'type': incidentType,
        'action': actionTakenByStaff,
      });

      if(imagePath != null && imagePath.isNotEmpty && imagePath != 'null'){
        request.files.add(await http.MultipartFile.fromPath('imageUrl', imagePath));
      }

      request.headers.addAll(headers);

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      print('response code for new api provider : ${response.statusCode}');
      print('response body for new api provider : $responseString');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request successful');
        _incidentReportFuture = Future.value({'success': true, 'message': 'Incident report submitted'});
        return {
          'success': true,
          'message': 'Request successful',
        };
      } else {
        // --- FIXED BLOCK ---
        // Hum check karenge ke kya response JSON hai ya HTML
        try {
          final decodedBody = jsonDecode(responseString);
          _incidentReportFuture = Future.value({'success': false, 'message': decodedBody['msg'] ?? decodedBody['message'] ?? 'Unknown error'});

          return {
            'success': false,
            'message': decodedBody['msg'] ?? decodedBody['message'] ?? 'Unknown error',
          };
        } catch (e) {
          // Agar yahan catch hua, matlab server ne HTML bheja hai
          print('Server returned HTML or non-JSON response: $responseString');
          _incidentReportFuture = Future.value({'success': false, 'message': 'Server Error (${response.statusCode}). Please contact support.'});

          return {
            'success': false,
            'message': 'Server Error (${response.statusCode}). Please contact support.',
          };
        }
        // --- FIXED BLOCK ENDS ---
      }

    } catch (e, s) {
      if(kDebugMode){
        print("error occured = $e");
        print("stackTrace = $s");
      }
      _incidentReportFuture = Future.value({'success': false, 'message': 'Error: $e'});
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
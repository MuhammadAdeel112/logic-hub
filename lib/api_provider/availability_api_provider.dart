import 'dart:convert';
import 'package:divine_employee_app/core/constants/api_end_points.dart';
import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../view/availability/presentation/provider/create_availability_provider_for_local.dart';

class AvailabilityApiProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> setAvailability(
      {required String employeeId,
      required DateTime startDate,
      required DateTime endDate,
      required List<Map<String, dynamic>> days,
      required context}) async {
    try {
      isLoading = true;
      var token = await SessionHandlingViewModel().getToken();

      final headers = {
        'x-auth-token': token ?? '',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'employeeId': employeeId,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'days': days,
      });

      final response = await http.post(
        Uri.parse(ApiEndPoints.updateAvailability),
        headers: headers,
        body: body,
      );
      print(':::request${response.request}');
      print(':::body${response.body}');
      print(':::body${response}');
      print(
          'response code for availability api provider : ${response.statusCode}');
      print('response body for availability api provider : ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        Provider.of<CreateAvailabilityProviderForLocal>(context, listen: false)
            .resetAvailability();
        return {
          'success': true,
          'message': 'Availability set successfully',
        };
      } else {
        print('object after in ');
        final decodedBody = jsonDecode(response.body);
        return {
          'success': false,
          'message': decodedBody['msg'] ?? 'Unknown error',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    } finally {
      isLoading = false;
    }
  }
}

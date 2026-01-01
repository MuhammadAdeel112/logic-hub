import 'dart:convert';
import 'package:divine_employee_app/core/constants/api_end_points.dart';
import 'package:divine_employee_app/core/utils/get_current_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'session_handling_view_model.dart';

class ClockOutApiProvider extends ChangeNotifier {
  late Future<Map<String, dynamic>> _clockOutRequestFuture;
  bool _isLoading = false;

  Future<Map<String, dynamic>> get clockOutRequestFuture =>
      _clockOutRequestFuture;

  bool get isLoading => _isLoading;

  void resetLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> submitClockOutRequest(
      String clockInId, BuildContext context) async {
    Map<String, dynamic>? locationData = await getCurrentLocation(context);

    if (locationData == null) {
      if (kDebugMode) print("Failed to get location.");
      return Future.value(
          {'success': false, 'message': 'Failed to fetch location'});
    }

    if (kDebugMode) print("Location Data at clockout: $locationData");

    try {
      _isLoading = true;
      notifyListeners();
      var token = await SessionHandlingViewModel().getToken();

      if (token == null || token.isEmpty) {
        if (kDebugMode) print("Error: Token not found.");
        return Future.value(
            {'success': false, 'message': 'Authentication failed'});
      }

      var headers = {
        'x-auth-token': token,
        'Content-Type': 'application/json',
      };

      if(kDebugMode){
        print("Sending Request to: ${ApiEndPoints.clockOutEndPoints(clockInId)}");
        print("Headers: $headers");
        print("Request Body: ${jsonEncode(locationData)}");
      }

      final response = await http
          .put(
            Uri.parse(ApiEndPoints.clockOutEndPoints(clockInId)),
            headers: headers,
            body: jsonEncode(locationData),
          )
          .timeout(Duration(seconds: 10));

      print(':::response code for clockout in api hit${response.statusCode}');
      if (kDebugMode) print('::: Response body: ${response.body}');
      if (response.statusCode == 200) {
        _clockOutRequestFuture =
            Future.value({'success': true, 'message': 'Clock-Out successful'});
      } else {
        final decodedBody = jsonDecode(response.body);
        _clockOutRequestFuture = Future.value({
          'success': false,
          'message': decodedBody['msg'] ?? 'Unknown error',
        });
        print('Error: ${decodedBody['msg'] ?? 'Unknown error'}');
      }
    } catch (e) {
      _clockOutRequestFuture =
          Future.value({'success': false, 'message': 'Error: $e'});
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return _clockOutRequestFuture;
  }
}

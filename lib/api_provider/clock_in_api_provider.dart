import 'dart:convert';
import 'package:divine_employee_app/core/constants/api_end_points.dart';
import 'package:divine_employee_app/core/utils/get_current_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'session_handling_view_model.dart';

class ClockInApiProvider extends ChangeNotifier {
  Future<Map<String, dynamic>> _clockInRequestFuture = Future.value({});
  bool _isLoading = false;

  Future<Map<String, dynamic>> get clockInRequestFuture =>
      _clockInRequestFuture;

  bool get isLoading => _isLoading;

  void resetLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> submitClockInRequest(String clockInId, BuildContext context) async {
    Map<String, dynamic>? locationData = await getCurrentLocation(context);

    if (locationData == null) {
      if (kDebugMode) print("Failed to get location.");
      return Future.value({'success': false, 'message': 'Failed to fetch location'});
    }

    if (kDebugMode) print("Location Data: $locationData");

    try {
      _isLoading = true;
      notifyListeners();

      var token = await SessionHandlingViewModel().getToken();
      if (token == null || token.isEmpty) {
        if (kDebugMode) print("Error: Token not found.");
        return Future.value({'success': false, 'message': 'Authentication failed'});
      }

      var headers = {
        'x-auth-token': token,
        'Content-Type': 'application/json',
      };

      final response = await http.put(
        Uri.parse(ApiEndPoints.clockInEndPoints(clockInId)),
        headers: headers,
        body: jsonEncode(locationData),
      );

      if (kDebugMode) print('::: Response body: ${response.body}');

      if (response.statusCode == 200) {
        _clockInRequestFuture =
            Future.value({'success': true, 'message': 'Clock-in successful'});
      } else {
        final decodedBody = jsonDecode(response.body);
        _clockInRequestFuture = Future.value({
          'success': false,
          'message': decodedBody['msg'] ?? 'Unknown error',
        });
        if (kDebugMode) print('Error: ${decodedBody['msg'] ?? 'Unknown error'}');
      }
    } catch (e) {
      _clockInRequestFuture =
          Future.value({'success': false, 'message': 'Error: $e'});
      if (kDebugMode) print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return _clockInRequestFuture;
  }
}




// import 'dart:convert';
// import 'package:divine_employee_app/core/constants/api_end_points.dart';
// import 'package:divine_employee_app/core/utils/get_current_location.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'session_handling_view_model.dart';
//
// class ClockInApiProvider extends ChangeNotifier {
//   Future<Map<String, dynamic>>? _clockInRequestFuture;
//   bool _isLoading = false;
//
//   Future<Map<String, dynamic>>? get clockInRequestFuture =>
//       _clockInRequestFuture;
//
//   bool get isLoading => _isLoading;
//
//   void resetLoading() {
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   Future<Map<String, dynamic>> submitClockInRequest(String clockInId) async {
//     Map<String, dynamic>? locationData = await getCurrentLocation();
//
//     if (locationData == null) {
//       if (kDebugMode) print("Failed to get location.");
//       return {'success': false, 'message': 'Failed to fetch location'};
//     }
//
//     if (kDebugMode) print("Location Data: $locationData");
//
//     try {
//       _isLoading = true;
//       notifyListeners();
//
//       var token = await SessionHandlingViewModel().getToken();
//       if (token == null || token.isEmpty) {
//         if (kDebugMode) print("Error: Token not found.");
//         return {'success': false, 'message': 'Authentication failed'};
//       }
//
//       var headers = {
//         'x-auth-token': token,
//         'Content-Type': 'application/json',
//       };
//
//       final response = await http.put(
//         Uri.parse(ApiEndPoints.clockInEndPoints(clockInId)),
//         headers: headers,
//         body: jsonEncode(locationData),
//       );
//
//       if (kDebugMode) print('::: Response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         _clockInRequestFuture =
//             Future.value({'success': true, 'message': 'Clock-in successful'});
//       } else {
//         final decodedBody = jsonDecode(response.body);
//         _clockInRequestFuture = Future.value({
//           'success': false,
//           'message': decodedBody['msg'] ?? 'Unknown error',
//         });
//         if (kDebugMode) print('Error: ${decodedBody['msg'] ?? 'Unknown error'}');
//       }
//     } catch (e) {
//       _clockInRequestFuture =
//           Future.value({'success': false, 'message': 'Error: $e'});
//       if (kDebugMode) print('Error: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//
//     return _clockInRequestFuture ?? {'success': false, 'message': 'Request failed'};
//   }
// }

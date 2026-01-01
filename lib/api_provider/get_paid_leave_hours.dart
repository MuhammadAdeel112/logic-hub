import 'dart:convert';

import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:divine_employee_app/core/constants/api_end_points.dart';
import 'package:http/http.dart' as http;
class GetPaidLeaveHours {
  Future<String?> getPaidHours () async {
    // final response = await http.get(Uri.parse(getPaidLeaveHoursEndPoints));

    try{
      var token = await SessionHandlingViewModel().getToken();

      final headers = {
        'x-auth-token': token ?? '',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse(ApiEndPoints.getPaidLeaveHoursEndPoints),
        headers: headers,
      );
      print(':::request${response.request}');
      print(':::body${response.body}');
      print(':::body${response}');
      print(
          'response code for availability api provider : ${response.statusCode}');

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        print("jsonData ::: $jsonData");
        return jsonData['leaveAvailableHours'].toString();
      }
      else {
        print("Error");
        return null;
      }
    }catch (e){
      print("Error :::: $e");
    }

  }

}
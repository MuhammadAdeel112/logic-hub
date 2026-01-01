import 'dart:convert';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/main.dart';
import 'package:divine_employee_app/view/auth/presentation/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:flutter/material.dart';

import '../core/constants/api_end_points.dart';

class ProfileUpdateApiProvider with ChangeNotifier {
  bool isLoading = false;

  Future<Map<String, dynamic>>   updateProfilee({
    String? name,
    String? phone,
    String? password,
    String? Fcm,
    String? imagePath,
  }) async {
    try {
      isLoading = true;
      notifyListeners(); // Notify listeners about the loading state change

      var token = await SessionHandlingViewModel().getToken();

      final headers = {
        'x-auth-token': token ?? '',
        // Use 'multipart/form-data' instead of 'application/json'
        'Content-Type': 'multipart/form-data',
      };

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(ApiEndPoints.updateProfileEndPoint),
      );

      print('check if they are null $name $phone $password $imagePath');
      // Add fields only if they are provided
      if (name != null) request.fields['name'] = name;
      if (phone != null) request.fields['phone'] = phone;
      if (password != null) request.fields['password'] = password;
      if (Fcm != null) request.fields['fcmToken'] = Fcm;

      if (imagePath != null) {
        // Add file only if imagePath is provided
        print('image path is not null in api $imagePath');
        request.files
            .add(await http.MultipartFile.fromPath('imageUrl', imagePath));
      }
// Print the request content before sending
      print('Request Content: ${request.toString()}');

      request.headers.addAll(headers);

      final response = await request.send();

      print(
          'response code for profile update api provider : ${response.statusCode}');
      print(
          'response body for profile update api provider : ${await response.stream.bytesToString()}');

      if (response.statusCode == 200) {
        print('Profile updated successfully');

        return {
          'success': true,
          'message': 'Profile updated successfully',
        };
      } else {
        final decodedBody = jsonDecode(await response.stream.bytesToString());
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
      notifyListeners(); // Notify listeners about the loading state change
    }
  }



  ///////delete
   Future<void> deleteAccountForEmployee(
      Map<String, dynamic> payload, BuildContext context) async {
    try {
     isLoading = true;
      notifyListeners();

      var token = await SessionHandlingViewModel().getToken();
      var headers = {
        'x-auth-token': token ?? '',
        'Content-Type': 'application/json',
      };

      final response = await http.delete(
        Uri.parse(ApiEndPoints.delete),
        headers: headers,
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        await ProfileUpdateApiProvider().updateProfilee(Fcm: '');
        SessionHandlingViewModel().removeUser();
        navigatorKey.currentState!.popUntil((route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
        Utils.showFlushbar('Deleted Scuessfully', context);
      } else {
        final decodedBody = jsonDecode(response.body);
       Utils.showFlushbar(decodedBody['msg'], context);
        print('Error: ${decodedBody['msg'] ?? 'Unknown error'}');
      }
    } catch (e) {
      print('Error : $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}
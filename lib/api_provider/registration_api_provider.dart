import 'dart:convert';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/view/registration/state/dob_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../core/constants/api_end_points.dart';

class RegistrationApiProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isGlobalOptionFormOkay = false;

  Future<void> createEmplyee(
      {required String employeeName,
      required String employeeEmail,
      required String emplyeePhoneNumber,
      required DateTime employeeDOB,
      required String employeeAddress,
      required String employeeLisenese,
      required String employeePassword,
      required context}) async {
    try {
      setLoadingState(true);
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(ApiEndPoints.registration));
      request.body = json.encode({
        "name": employeeName,
        "email": employeeEmail,
        "DOB": employeeDOB.toUtc().toIso8601String(),
        "password": employeePassword,
        "phone": emplyeePhoneNumber,
        "driving_license": "valid",
        "address": employeeAddress,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(':::: Whiile gristration ${response.statusCode}');
      print(':::: Whiile body ${response.request}');
      if (response.statusCode == 201 ) {
        Utils.showToastMessage('Registered');
        Provider.of<UserDateOfBirth>(context, listen: false).resetState();
        Navigator.pop(context);
        String responseBody = await response.stream.bytesToString();

        try {
          print('responseBody : $responseBody');
        } catch (e) {
          print("Error decoding JSON response: ${e.toString()}");
          // Handle the error, possibly return or throw an exception
          return;
        }
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("Error occurred during login :${e.toString()}");
    } finally {
      setLoadingState(false);
    }
  }
}

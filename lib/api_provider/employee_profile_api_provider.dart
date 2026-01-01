// import 'dart:convert';
// import 'package:divine_employee_app/api_provider/data_provider_for_employee_profile.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import '../core/constants/api_end_points.dart'; // Import your API endpoints

// import '../models/get_employee_model.dart';
// import 'session_handling_view_model.dart'; // Import your GetEmployeeModel

// class EmployeeProfileApiProvider with ChangeNotifier {
//   Future<GetEmployeeModel> fetchEmployeeProfile() async {
//     try {
//       var token = await SessionHandlingViewModel().getToken();

//       var url = Uri.parse(ApiEndPoints.employeeProfileEndPoint);
//       await Future.delayed(Duration(seconds: 1));

//       var response =
//           await http.get(url, headers: {'x-auth-token': token ?? ''});
//       // print('employee profile ::: ' + response.body);
//       // print(response.statusCode);
//       if (response.statusCode == 200) {
//         return GetEmployeeModel.fromJson(jsonDecode(response.body));
//       } else {
//         print(
//             "Error: Fetching employee profile with status code ${response.statusCode}.");
//         throw Exception("Failed to load employee profile");
//       }
//     } catch (e) {
//       print("Error: Fetching employee profile: ${e.toString()}");
//       throw e;
//     }
//   }

//   Future<void> fetchEmployeeProfileAndNotify(BuildContext context) async {
//     try {
//       final employeeProfile = await fetchEmployeeProfile();
//       Provider.of<DataProviderForEmployeeProfile>(context, listen: false)
//           .setEmployeeProfile(employeeProfile);
//     } catch (e) {
//       print('Error fetching data from API: $e');
//       print('Error fetching data from API: $e');
//       Provider.of<DataProviderForEmployeeProfile>(context, listen: false)
//           .setError(
//               'Failed to fetch employee profile. Please try again later.');
//     }
//   }
// }

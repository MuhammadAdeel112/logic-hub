// import 'dart:convert';

// import 'package:divine_employee_app/api_provider/profile_update_api_provider.dart';
// import 'package:divine_employee_app/core/utils/utlis.dart';
// import 'package:divine_employee_app/repositories/auth_repository.dart';
// import 'package:divine_employee_app/view/jobs/presentation/screens/job_home_screen.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../core/utils/routes/routes_name.dart';
// import '../view/auth/presentation/state/bottom_app_bar_provider.dart';
// import 'session_handling_view_model.dart';

// class AuthViewModel with ChangeNotifier {
//   bool _isLoading = false;
//   bool get loading => _isLoading;

//   setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   final _myRepo = AuthRepository();
//   var tokenSaved;

//   final firebaseMessaging = FirebaseMessaging.instance;
//   var FCMToken = '';
//   Future<void> LoginApi(dynamic data, BuildContext context) async {
//     final currentTabProvider =
//         Provider.of<BottomNavigationBarProvider>(context, listen: false);
//     setLoading(true);
//     _myRepo.LoginApi(data)
//         .then((value) async => {
//               setLoading(false),
//               if (kDebugMode)
//                 {print('Api data in view model :::' + value.toString())},
//               // SessionHandlingViewModel().saveToken(value['token']),
//               // Utils.showToastMessage('Login Successful'),
//               // Navigator.pushNamed(context, RoutesName.app_dashboard),
//               if (value.containsKey('token'))
//                 {
//                   tokenSaved = await SessionHandlingViewModel()
//                       .saveToken(value['token']),
//                   if (tokenSaved)
//                     {
//                       Utils.showToastMessage('Login Successful'),
//                       await firebaseMessaging.requestPermission(),
//                       FCMToken = (await firebaseMessaging.getToken())!,
//                       if (kDebugMode)
//                         print('::: FCMToken at login  = ${FCMToken}'),
//                       await ProfileUpdateApiProvider()
//                           .updateProfilee(Fcm: FCMToken),
//                       if (kDebugMode)
//                         print(
//                             'Token from shared preferences: ${await SessionHandlingViewModel().getToken()}'),
//                       currentTabProvider.setCurrentTab(5),
//                       currentTabProvider.setCurrentScreen(JobHomeScreen()),
//                       Navigator.pushReplacementNamed(
//                           context, RoutesName.app_dashboard),
//                     }
//                   else
//                     {
//                       Utils.showToastMessage('Error saving token'),
//                     }
//                 }
//               else
//                 {
//                   Utils.showToastMessage('Token not found in response'),
//                 }
//             })
//         .onError((error, stackTrace) {
//       setLoading(false);

//       // Extracting the "msg" from the error string
//       int jsonStartIndex = error.toString().indexOf('{');
//       int jsonEndIndex = error.toString().lastIndexOf('}') + 1;
//       String jsonResponse =
//           error.toString().substring(jsonStartIndex, jsonEndIndex);
//           print("::: the response of sign in spi :${jsonResponse}");

//       Map<String, dynamic> jsonData = json.decode(jsonResponse);
//       String msg = jsonData['msg'];
  

//       Utils.showToastMessage(msg);

//       if (kDebugMode) {
//         print(msg);
//         print(error.toString());
//       } // Add a return statement at the end
//       return Future.value(null);
//     });
//   }
// }




import 'dart:convert';
import 'dart:io'; // Import this for HttpException and SocketException

import 'package:divine_employee_app/api_provider/profile_update_api_provider.dart';
import 'package:divine_employee_app/core/data/app_exception.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/repositories/auth_repository.dart';
import 'package:divine_employee_app/view/auth/presentation/screens/login_screen.dart';
import 'package:divine_employee_app/view/auth/presentation/screens/reset_password_screen.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/job_home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/routes/routes_name.dart';
import '../view/auth/presentation/state/bottom_app_bar_provider.dart';
import 'session_handling_view_model.dart';

class AuthViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get loading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final _myRepo = AuthRepository();
  var tokenSaved;

  final firebaseMessaging = FirebaseMessaging.instance;
  var FCMToken = '';

  Future<void> LoginApi(dynamic data, BuildContext context) async {
    final currentTabProvider =
        Provider.of<BottomNavigationBarProvider>(context, listen: false);
    setLoading(true);
    _myRepo.LoginApi(data).then((value) async {
      setLoading(false);
      if (kDebugMode) {
        print('Api data in view model :::' + value.toString());
      }

      if (value.containsKey('token')) {
        tokenSaved = await SessionHandlingViewModel().saveToken(value['token']);
        if (tokenSaved) {
          Utils.showToastMessage('Login Successful');
          await firebaseMessaging.requestPermission();
          try{
            FCMToken = (await firebaseMessaging.getToken())!;
          if (kDebugMode) {
            print('::: FCMToken at login  = ${FCMToken}');
          }
          await ProfileUpdateApiProvider().updateProfilee(Fcm: FCMToken);
          if (kDebugMode) {
            print('Token from shared preferences: ${await SessionHandlingViewModel().getToken()}');
          }
          currentTabProvider.setCurrentTab(5);
          currentTabProvider.setCurrentScreen(JobHomeScreen());
          }catch(e){
            print("error :::: $e");
          }
          currentTabProvider.setCurrentTab(5);
          currentTabProvider.setCurrentScreen(JobHomeScreen());
          Navigator.pushReplacementNamed(context, RoutesName.app_dashboard);
        } else {
          Utils.showToastMessage('Error saving token');
        }
      } else {
        Utils.showToastMessage('Token not found in response');
      }
    }).onError((error, stackTrace) {
      setLoading(false);

      // Check for network issues first
      if (error is SocketException) {
        Utils.showToastMessage('No Internet connection. Please check your network.');
      } else if (error is HttpException) {
        Utils.showToastMessage('Service is temporarily unavailable. Please try again later.');
      } else if (error is FormatException) {
        Utils.showToastMessage('Bad response format.');
      } else {
        // Check if the error is a server-side issue
        String errorMessage = 'An unknown error occurred';

        // try {
        //   // Try to decode the error response if possible
        //   final jsonResponse = json.decode(error.toString());
        //   print("Error response: $jsonResponse"); // Debugging the full error response
        //
        //   // Handling specific error response codes
        //   if (jsonResponse.containsKey('status') && jsonResponse['status'] == 503) {
        //     errorMessage = 'Service is temporarily unavailable. Please try again later.';
        //   } else if (jsonResponse.containsKey('msg')) {
        //     errorMessage = jsonResponse['msg']; // Extract the specific error message
        //   } else {
        //     errorMessage = 'An unexpected error occurred. Please try again.';
        //   }
        // } catch (e) {
        //   // In case the error message format is unexpected
        //   errorMessage = 'Error parsing the error message';
        // }

        Utils.showToastMessage(errorMessage);
      }

      // Printing the full error to debug
      if (kDebugMode) {
        print("Error: ${error.toString()}");
        print("Stack Trace: $stackTrace");
      }

      return Future.value(null);
    });
  }

  Future<void> ForgotApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.ForgotApi(data).then((value) async {
      setLoading(false);
      Utils.showToastMessage(value["msg"]);
      Navigator.push(context, MaterialPageRoute(builder: ((context) => ResetPasswordScreen())));
      if (kDebugMode) {
        print('Api data in view model :::' + value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);

      if (error is SocketException) {
        Utils.showToastMessage('No Internet connection. Please check your network.');
      } else if (error is HttpException) {
        Utils.showToastMessage('Service is temporarily unavailable. Please try again later.');
      } else if (error is FormatException) {
        Utils.showToastMessage('Bad response format.');
      } else if (error is UnauthorizedException) {
        try {
          // ✅ Extract JSON from exception and show proper message
          String errorBody = error.toString();

          if (errorBody.contains("{") && errorBody.contains("msg")) {
            errorBody = errorBody.substring(errorBody.indexOf("{")); // Extract JSON part
            final Map<String, dynamic> errorMap = jsonDecode(errorBody);
            Utils.showToastMessage(errorMap['msg'] ?? "Unauthorized access.");
          } else {
            Utils.showToastMessage("Unauthorized access.");
          }
        } catch (e) {
          Utils.showToastMessage("Error processing response.");
        }
      } else {
        Utils.showToastMessage("Something went wrong. Please try again.");
      }


      // Printing the full error to debug
      if (kDebugMode) {
        print("Error: ${error.toString()}");
        print("Stack Trace: $stackTrace");
      }

      return Future.value(null);
    });
  }

  Future<void> ResetApi(dynamic data, BuildContext context, String token) async {
    setLoading(true);
    _myRepo.ResetApi(data,token).then((value) async {
      setLoading(false);
      Utils.showToastMessage(value["msg"]);
      Navigator.push(context, MaterialPageRoute(builder: ((context) => LoginScreen())));
      if (kDebugMode) {
        print('Api data in view model :::' + value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);

      if (error is SocketException) {
        Utils.showToastMessage('No Internet connection. Please check your network.');
      } else if (error is HttpException) {
        Utils.showToastMessage('Service is temporarily unavailable. Please try again later.');
      } else if (error is FormatException) {
        Utils.showToastMessage('Bad response format.');
      } else if (error is UnauthorizedException) {
        try {
          // ✅ Extract JSON from exception and show proper message
          String errorBody = error.toString();

          if (errorBody.contains("{") && errorBody.contains("msg")) {
            errorBody = errorBody.substring(errorBody.indexOf("{")); // Extract JSON part
            final Map<String, dynamic> errorMap = jsonDecode(errorBody);
            Utils.showToastMessage(errorMap['msg'] ?? "Unauthorized access.");
          } else {
            Utils.showToastMessage("Unauthorized access.");
          }
        } catch (e) {
          Utils.showToastMessage("Error processing response.");
        }
      } else {
        Utils.showToastMessage("Something went wrong. Please try again.");
      }


      // Printing the full error to debug
      if (kDebugMode) {
        print("Error: ${error.toString()}");
        print("Stack Trace: $stackTrace");
      }

      return Future.value(null);
    });
  }
}


// import 'package:divine_employee_app/models/get_employee_profile_model.dart';
// import '../core/data/network/base_api_services.dart';
// import '../core/data/network/network_api_sercives.dart';
// import '../viewmodel/session_handling_view_model.dart';

// class GetEmployeeProfileRepo {
//   BaseApiServices _apiServices = NetworkApiServices();

//   Future<GetEmployeeProfileModel> getEmployeeApiWithToken(String url) async {
//     try {
//       // Retrieve the token from shared preferences
//       String? authToken = await SessionHandlingViewModel().getToken();
//       // Check if the token is available
//       if (authToken != null) {
//         // Use the token to make the GET request
//         dynamic response=  await _apiServices.getGetApiWithToken(url, authToken);
//         return response = GetEmployeeProfileModel.fromJson(response);
//       } else {
//         throw Exception('Token not found in shared preferences');
//       }
//     } catch (e) {
//       throw e;
//     }
//   }
// }

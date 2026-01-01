import 'package:divine_employee_app/models/available_jobs_model.dart';
import '../core/data/network/base_api_services.dart';
import '../core/data/network/network_api_sercives.dart';
import '../api_provider/session_handling_view_model.dart';

class AvaliableJobRepo {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<AvailableJobsModel> fetchAvaliableJobs(String url) async {
    try {
      // Retrieve the token from shared preferences
      String? authToken = await SessionHandlingViewModel().getToken();
      // if (kDebugMode) print('::: AvaliableJobRepo $authToken');

      // Check if the token is available
      if (authToken != null) {
        // Use the token to make the GET request
        dynamic response =
            await _apiServices.getGetApiWithToken(url, authToken);
        return response = AvailableJobsModel.fromJson(response);
      } else {
        throw Exception('Token not found in shared preferences');
      }
    } catch (e) {
      throw e;
    }
  }
}

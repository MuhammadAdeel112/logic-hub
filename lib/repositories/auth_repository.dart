import 'package:divine_employee_app/core/constants/api_end_points.dart';
import 'package:divine_employee_app/core/data/network/base_api_services.dart';
import 'package:divine_employee_app/core/data/network/network_api_sercives.dart';

class AuthRepository{
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> LoginApi(dynamic data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(ApiEndPoints.logInEndPoint, data);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> ForgotApi(dynamic data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(ApiEndPoints.forgotEndPoint, data);
      if (response['status'] == 404) {
        print("Employee not found");
        throw Exception("Employee not found");
      }
      return response;
    }catch(e){
      throw e;

    }
  }

  Future<dynamic> ResetApi(dynamic data, String token)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(ApiEndPoints.resetEndPoint(token), data);
      if (response['status'] == 404) {
        print("Employee not found");
        throw Exception("Employee not found");
      }
      return response;
    }catch(e){
      throw e;
    }
  }
}
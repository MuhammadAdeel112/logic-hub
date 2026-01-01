import 'dart:async';

import 'package:divine_employee_app/core/constants/api_end_points.dart';
import 'package:divine_employee_app/core/data/app_exception.dart';
import 'package:divine_employee_app/core/data/response/api_response.dart';
import 'package:divine_employee_app/models/available_jobs_model.dart';
import 'package:divine_employee_app/models/get_employee_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/assigned_jobs_model.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'session_handling_view_model.dart';

class DataProviderForEmployeeProfile with ChangeNotifier {
  GetEmployeeModel? _employeeProfile;
  ApiReponses<GetEmployeeModel> _apiResponse = ApiReponses.loading();

  GetEmployeeModel? get employeeProfile => _employeeProfile;
  ApiReponses<GetEmployeeModel> get apiResponse => _apiResponse;

  Future<void> fetchEmployeeProfile() async {
    try {
      // Set loading state
      _apiResponse = ApiReponses.loading();
      notifyListeners();

      var token = await SessionHandlingViewModel().getToken();
      await Future.delayed(Duration(seconds: 0));

      var url = Uri.parse(ApiEndPoints.employeeProfileEndPoint);
      var response = await http.get(url, headers: {
        'x-auth-token': token ?? ''
      }).timeout(Duration(seconds: 10));

      // Handle the response using the returnResponse function
      dynamic responseBody = returnResponse(response);

      // Convert the JSON response to GetEmployeeModel
      final GetEmployeeModel employeeProfile =
      GetEmployeeModel.fromJson(responseBody);

      // Set completed state with data
      _apiResponse = ApiReponses.completed(employeeProfile);
      _employeeProfile = employeeProfile;
      await SessionHandlingViewModel().saveMyId(employeeProfile.employee.id);

      notifyListeners();
    } on SocketException catch (_) {
      // Handle socket exception (no internet connection)
      _apiResponse = ApiReponses.error('No internet connection');
      notifyListeners();
    } on TimeoutException catch (_) {
      // Handle timeout exception
      _apiResponse = ApiReponses.error('Request timeout');
      notifyListeners();
    } on AppException catch (e) {
      // Handle custom app exceptions
      _apiResponse = ApiReponses.error(e.toString());
      notifyListeners();
    } on Exception catch (e) {
      // Handle other exceptions
      _apiResponse = ApiReponses.error(e.toString());
      notifyListeners();
    }
  }

  void clearEmployeeProfile() {
    _employeeProfile = null;
    notifyListeners();
  }
}

class AssignedJobsProvider with ChangeNotifier {
  AssignedJobsModel? _assignedJobs;

  AssignedJobsModel? get assignedJobs => _assignedJobs;

  ApiReponses<AssignedJobsModel> _apiResponse = ApiReponses.loading();

  ApiReponses<AssignedJobsModel> get apiResponse => _apiResponse;

  Future<void> fetchAssignedJobs() async {
    try {
      // Set loading state
      _apiResponse = ApiReponses.loading();
      notifyListeners();

      var i = await SessionHandlingViewModel().getToken();
      await Future.delayed(Duration(seconds: 0));

      var url = Uri.parse(ApiEndPoints.employeeCurrentJobsEndPoints);
      var response = await http.get(url,
          headers: {'x-auth-token': "$i"}).timeout(Duration(seconds: 10));
      // if (kDebugMode) print('::: Assigned Jobs ${response.body}');
      print("::: the reponse of assigned job is :${response.body}");
      // Handle the response using the returnResponse function
      dynamic responseBody = returnResponse(response);

      print("Assigned Job Response Body : $responseBody");

      // Convert the JSON response to AvailableJobsModel
      final AssignedJobsModel assignedJobs =
      AssignedJobsModel.fromJson(responseBody);

      // Set completed state with data
      _apiResponse = ApiReponses.completed(assignedJobs);
      _assignedJobs = assignedJobs;

      notifyListeners();
    } on SocketException catch (_) {
      // Handle socket exception (no internet connection)
      _apiResponse = ApiReponses.error('No internet connection');
      notifyListeners();
    } on TimeoutException catch (_) {
      // Handle timeout exception
      _apiResponse = ApiReponses.error('Request timeout');
      notifyListeners();
    } on AppException catch (e) {
      // Handle custom app exceptions
      _apiResponse = ApiReponses.error(e.toString());
      notifyListeners();
    } on Exception catch (e) {
      // Handle other exceptions
      _apiResponse = ApiReponses.error(e.toString());
      notifyListeners();
    }
  }

  // Inside AvailableJobsProvider
  void clearAssignedJobs() {
    _assignedJobs = null;
    notifyListeners();
  }
}

class AvailableJobsProvider with ChangeNotifier {
  AvailableJobsModel? _availableJobs;

  AvailableJobsModel? get availableJobs => _availableJobs;

  ApiReponses<AvailableJobsModel> _apiResponse = ApiReponses.loading();

  ApiReponses<AvailableJobsModel> get apiResponse => _apiResponse;
  Future<void> fetchAvailableJobs() async {
    try {
      // Set loading state
      _apiResponse = ApiReponses.loading();
      notifyListeners();

      var i = await SessionHandlingViewModel().getToken();
      print(":::print token:$i");
      await Future.delayed(Duration(seconds: 0));

      var url = Uri.parse(ApiEndPoints.allAvialbleJobsEndPoints);
      var response = await http.get(url,
          headers: {'x-auth-token': "$i"}).timeout(Duration(seconds: 10));
      ;
      // if (kDebugMode) print('::: Available Jobs ${response.body}');
// print("::: the response of available api is :${response.body}");
// print("::: the status code of available api is :${response.statusCode}");

      // Handle the response using the returnResponse function
      dynamic responseBody = returnResponse(response);

      print("Response Body : $responseBody");

      // Convert the JSON response to AvailableJobsModel
      final AvailableJobsModel availableJobs =
      AvailableJobsModel.fromJson(responseBody);

      // Set completed state with data
      _apiResponse = ApiReponses.completed(availableJobs);
      _availableJobs = availableJobs;

      notifyListeners();
    } on SocketException catch (_) {
      // Handle socket exception (no internet connection)
      _apiResponse = ApiReponses.error('No internet connection');
      notifyListeners();
    } on TimeoutException catch (_) {
      // Handle timeout exception
      _apiResponse = ApiReponses.error('Request timeout');
      notifyListeners();
    } on AppException catch (e) {
      // Handle custom app exceptions
      _apiResponse = ApiReponses.error(e.toString());
      notifyListeners();
    } on Exception catch (e) {
      // Handle other exceptions
      _apiResponse = ApiReponses.error(e.toString());
      notifyListeners();
    }
  }

  // Inside AvailableJobsProvider
  void clearAvailableJobs() {
    _availableJobs = null;
    notifyListeners();
  }
}

dynamic returnResponse(http.Response response) {
  // print(response.body);
  switch (response.statusCode) {
    case 200:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 404:
      throw UnauthorizedException(response.body.toString());
    case 401:
      throw InvalidInputException(response.body.toString());
    default:
      throw FetchDataException(
          'Error occurred While communicating with server' +
              response.statusCode.toString());
  }
}

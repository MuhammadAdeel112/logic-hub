import 'dart:convert';
import 'dart:math';

import 'package:divine_employee_app/models/available_jobs_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../core/constants/api_end_points.dart';
import '../core/utils/utlis.dart';
import '../models/assigned_jobs_model.dart';
import 'session_handling_view_model.dart';

class JobProvider with ChangeNotifier {
  Future<AssignedJobsModel> fetchAssignedEmployeeJobs() async {
    int retryCount = 3; // Set the maximum number of retries
    int currentRetry = 0;

    while (currentRetry < retryCount) {
      var i = await SessionHandlingViewModel().getToken();
      Future.delayed(Duration(seconds: 1));

      try {
        var url = Uri.parse(ApiEndPoints.employeeCurrentJobsEndPoints);

        var response = await http.get(url, headers: {'x-auth-token': "$i"});
        if (response.statusCode == 200) {
          final currentJobsModel =
          AssignedJobsModel.fromJson(jsonDecode(response.body));
          return currentJobsModel;
        } else {
          print(
              "Error: Fetching Assigned jobs with status code ${response.statusCode}.");
        }
        break;
      } catch (e) {
        currentRetry++;
        await Future.delayed(Duration(seconds: 2));

        print("Error: Fetching Assigned jobs: ${e.toString()}");
        Utils.showToastMessage('${e.toString()}');
      }
    }
    throw (e);
  }

  Future<AvailableJobsModel> fetchAvaliableEmployeeJobs() async {
    int retryCount = 3; // Set the maximum number of retries
    int currentRetry = 0;

    while (currentRetry < retryCount) {
      var i = await SessionHandlingViewModel().getToken();
      Future.delayed(Duration(seconds: 1));

      try {
        var url = Uri.parse(ApiEndPoints.allAvialbleJobsEndPoints);

        var response = await http.get(url, headers: {'x-auth-token': "$i"});
        print(':::kk${response.body}');
        if (response.statusCode == 200) {
          final availableJobsModel =
          AvailableJobsModel.fromJson(jsonDecode(response.body));
          return availableJobsModel;
        } else {
          print(
              "Error: Fetching Available jobs with status code ${response.statusCode}.");
        }
        break;
      } catch (e) {
        print("Error: Fetching Available jobs: ${e.toString()}");
        // Increment the retry count
        currentRetry++;

        // Wait for a short duration before retrying
        await Future.delayed(Duration(seconds: 2));
      }
    }
    throw (e);
  }
}

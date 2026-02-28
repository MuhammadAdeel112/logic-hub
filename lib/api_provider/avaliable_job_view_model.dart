import 'package:divine_employee_app/core/constants/api_end_points.dart';
import 'package:divine_employee_app/core/data/response/api_response.dart';
import 'package:divine_employee_app/models/available_jobs_model.dart';
import 'package:divine_employee_app/repositories/avaliable_job_repo.dart';
import 'package:flutter/material.dart';

class AvaliableJobViewModel with ChangeNotifier {
  final _myRepo = AvaliableJobRepo();

  ApiReponses<AvailableJobsModel> availableJobs = ApiReponses.loading();

  setAvaliableJobs(ApiReponses<AvailableJobsModel> reponses) {
    availableJobs = reponses;
    notifyListeners();
  }

  void clearAvailableJobs() {
    setAvaliableJobs(ApiReponses.loading());
  }

  Future<void> fetchAvailableJobs() async {
    // 1. Pehle loading state
    setAvaliableJobs(ApiReponses.loading());

    try {
      // 2. Data fetch karein
      final value = await _myRepo.fetchAvaliableJobs(ApiEndPoints.allAvialbleJobsEndPoints);

      // 3. Data set karein
      setAvaliableJobs(ApiReponses.completed(value));
    } catch (error) {
      // 4. Error handling
      setAvaliableJobs(ApiReponses.error(error.toString()));
    }
  }
}
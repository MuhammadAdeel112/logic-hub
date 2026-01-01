
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

  Future<void> fetchAvailableJobs() async {
    setAvaliableJobs(ApiReponses.loading());
    _myRepo
        .fetchAvaliableJobs(ApiEndPoints.allAvialbleJobsEndPoints)
        .then((value) => {setAvaliableJobs(ApiReponses.completed(value))})
        .onError(
            (error, stackTrace) => {setAvaliableJobs(ApiReponses.error(error.toString()))});
  }
}

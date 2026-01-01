import 'package:divine_employee_app/models/assigned_jobs_model.dart';
import 'package:divine_employee_app/view/jobs/presentation/widgets/job_detail_tab_bar_widget.dart';
import 'package:divine_employee_app/view/jobs/presentation/widgets/show_about_cleint.dart';
import 'package:flutter/material.dart';

import '../../../../core/common widgets/reuseable_sccafold_screen.dart';
import '../../../../models/available_jobs_model.dart';
import '../widgets/job_detials_widget.dart';

class JobDetailsScreen extends StatefulWidget {
  final String location;
  final shiftType;
  final int allowances;
  final String jobTitle;
  final String jobId;
  final DateTime date;
  final String startTime;
  final String endTime;
  final distance;
  final Duration hoursOfShift;
  final description;
  final shiftManagerName;
  final String shiftManagerNo;
  final String shiftManagerId;
  final String clientName;
  final String? clientId;
  final String clientNo;
  final String clientImage;
  final List<Task> tasksForAssignedJobs;
  final List<Tasks> tasksForAvailableJobs;
  final clientInfoForAssignedJobs;
  final clientInfoForAvailableJobs;
  final String whichKindOfJob;

  const JobDetailsScreen({
    super.key,
    required this.whichKindOfJob,
    required this.location,
    required this.jobId,
    required this.shiftType,
    required this.allowances,
    required this.jobTitle,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.distance,
    required this.hoursOfShift,
    required this.description,
    this.clientId,
    required this.clientName,
    required this.clientNo,
    required this.clientImage,
    required this.shiftManagerName,
    required this.shiftManagerNo,
    required this.shiftManagerId,
    required this.tasksForAssignedJobs,
    required this.tasksForAvailableJobs,
    this.clientInfoForAssignedJobs,
    this.clientInfoForAvailableJobs,
  });

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {

  /// ✅ FIX: Client ID ab direct client object se bhi read hogi
  /// Aur sirf last 6 digits show hongi
  String getClientIdLastSix() {
    final String? id = widget.clientId ??
        widget.clientInfoForAssignedJobs?.client.id ??
        widget.clientInfoForAvailableJobs?.client.id;

    if (id == null || id.isEmpty) return '';

    return id.length > 6 ? id.substring(id.length - 6) : id;
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (widget.clientInfoForAssignedJobs != null) {
        ShowAboutClientforassignedJob(
            context, widget.clientInfoForAssignedJobs!);
      } else if (widget.clientInfoForAvailableJobs != null) {
        ShowAboutClientforAvailableJob(
            context, widget.clientInfoForAvailableJobs!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final client = widget.clientInfoForAssignedJobs?.client ??
        widget.clientInfoForAvailableJobs?.client;

    final String riskAssessment =
        client?.riskAssessment.aggressionOrViolence ?? '';

    final String livingArrangement =
        client?.livingArrangement ?? '';

    final String goal =
        client?.goalsAndSupportNeeds ?? '';

    return ReuseableScaffoldScreen(
      appBarTitle: 'Details',
      content: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                JobDetailTabBarWidget(
                  whichKindOfJob: widget.whichKindOfJob,
                  jobId: widget.jobId,
                  managerId: widget.shiftManagerId,
                  managerName: widget.shiftManagerName,
                  clientId: getClientIdLastSix(), // ✅ last 6 digits
                ),
                JobDetailsWidget(
                  shiftManagerName: widget.shiftManagerName,
                  shiftManagerNo: widget.shiftManagerNo,
                  clientName: widget.clientName,
                  clientNo: widget.clientNo,
                  location: widget.location,
                  shiftType: widget.shiftType,
                  allowances: widget.allowances,
                  jobTitle: widget.jobTitle,
                  date: widget.date,
                  startTime: widget.startTime,
                  endTime: widget.endTime,
                  distance: widget.distance,
                  HoursOfShift: widget.hoursOfShift,
                  description: widget.description,
                  tasksForAssignedJobs: widget.tasksForAssignedJobs,
                  tasksForAvailableJobs: widget.tasksForAvailableJobs,
                  clientImage: widget.clientImage,
                  clientInfoForAssignedJobs: widget.clientInfoForAssignedJobs,
                  clientInfoForAvailableJobs:
                  widget.clientInfoForAvailableJobs,
                  clientId: getClientIdLastSix(), // ✅ last 6 digits
                  riskAssessment: riskAssessment,
                  livingArrangement: livingArrangement,
                  goal: goal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:divine_employee_app/view/jobs/presentation/widgets/show_about_cleint.dart';
import 'package:flutter/material.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/models/assigned_jobs_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../api_provider/job_provider.dart';
import '../../../../core/common widgets/reuseable_sccafold_screen.dart';
import '../widgets/job_detail_tab_bar_with_timer_widget.dart';
import '../widgets/job_details_during_job_widget.dart';
import '../widgets/task_widget.dart';

class DuringJobScreen extends StatefulWidget {
  DuringJobScreen({Key? key}) : super(key: key);

  @override
  State<DuringJobScreen> createState() => _DuringJobScreenState();
}

class _DuringJobScreenState extends State<DuringJobScreen> {
  Future<AssignedJobsModel>? viewAssignedJobs;
  String? value;

  @override
  void initState() {
    super.initState();
    viewAssignedJobs = JobProvider().fetchAssignedEmployeeJobs();
    initializeSharedPreferences();
  }

  initializeSharedPreferences() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    value = sp.getString('currentJobId');
    print('$value job id at initializeSharedPreferences');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? shouldClose = await showCloseConfirmationDialog(context);
        return shouldClose ?? false;
      },
      child: ReuseableScaffoldScreen(
        onLeadingPressed: () async {
          bool? shouldClose = await showCloseConfirmationDialog(context);
          return shouldClose ?? false;
        },
        appBarTitle: 'Divine Care',
        content: FutureBuilder<AssignedJobsModel>(
          future: viewAssignedJobs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.job.isEmpty) {
              return Center(child: Text('No jobs available'));
            }

            final allJobs = snapshot.data!.job;
            final filteredJobs =
            allJobs.where((job) => job.id == value).toList();

            return ListView.builder(
              itemCount: filteredJobs.length,
              itemBuilder: (context, index) {
                Job job = filteredJobs[index];

                // ---------------- SAFE CLIENT DATA ----------------
                final client = job.client; // ✅ single object now
                final clientName =
                '${client.firstName} ${client.middleName} ${client.lastName}'
                    .trim()
                    .isNotEmpty
                    ? '${client.firstName} ${client.middleName} ${client.lastName}'.trim()
                    : "No client name";
                final clientNo = client.mobile;
                final clientId = client.id;
                final clientImage = client.profileImage;

                // ---------------- SAFE MANAGER DATA ----------------
                final manager = job.manager.isNotEmpty ? job.manager[0] : null;
                final shiftManagerName = manager?.name ?? "No manager available";
                final shiftManagerNo = manager?.phone ?? "No phone available";

                // ---------------- OTHER FIELDS ----------------
                final jobId = job.id;
                final jobTitle = job.title;
                final location = job.address.formattedAddress;
                final date = job.startTime;
                final startTime = job.startTime;
                final endTime = job.endTime;
                final duration = endTime.difference(startTime);
                final shiftType = job.shift;
                final allowances = job.allowances;
                final description = job.description;
                final tasksForAssignedJobs = job.task;

                // Auto popup of client dialog
                Future.microtask(() {
                  ShowAboutClientforassignedJob(context, job);
                });

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      JobDetailTabBarWithTimerWidget(
                        jobId: jobId,
                        clientName: clientName,
                        staffName: shiftManagerName,
                        incidentlocation: location,
                        jobTitle: jobTitle,
                        clientId: clientId,
                      ),
                      Divider(color: Colors.transparent),
                      JobDetailsDuringJobWidget(
                        shiftManagerNo: shiftManagerNo,
                        clientName: clientName,
                        clientNo: clientNo,
                        clientImage: clientImage,
                        location: location,
                        allowances: allowances,
                        jobTitle: jobTitle,
                        date: date,
                        startTime: startTime,
                        endTime: endTime,
                        HoursOfShift: duration,
                        tasksForAssignedJobs: tasksForAssignedJobs,
                        clientInfoForAssignedJobs: job,
                        shiftManagerName: shiftManagerName,
                        shiftType: shiftType,
                        distance: "null",
                        description: description,
                      ),
                      Divider(color: Colors.transparent),
                      Row(
                        children: [
                          Text(
                            'Tasks',
                            style: AppConstants.kTextStyleMediumBoldBlack,
                          ),
                        ],
                      ),
                      TasksWidet(
                        tasksForAssignedJobs: tasksForAssignedJobs,
                        jobId: jobId,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // EXIT DIALOG
  Future<bool?> showCloseConfirmationDialog(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Progress Safeguard'),
          content: Text(
              'Your job is running in the background. Feel free to leave the app; progress will continue.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => exit(0),
              child: Text('Exit'),
            ),
          ],
        );
      },
    );
  }
}

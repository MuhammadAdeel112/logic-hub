import 'package:divine_employee_app/api_provider/job_application_provider.dart';
import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/common widgets/reuseable_small_button.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common widgets/reuseable_gradient_button.dart';
import '../../../../models/available_jobs_model.dart';
import '../../../availability/presentation/screens/requested_availbility_details_screen.dart';
import '../screens/job_details_screen.dart';

class AvailableJobWidget extends StatefulWidget {
  final Jobs jobData;

  const AvailableJobWidget({Key? key, required this.jobData}) : super(key: key);

  @override
  State<AvailableJobWidget> createState() => _AvailableJobWidgetState();
}

class _AvailableJobWidgetState extends State<AvailableJobWidget> {
  bool isLoading = false;

  String get lastSixJobId {
    final jobId = widget.jobData.id.toString();
    if (jobId.length >= 6) {
      return jobId.substring(jobId.length - 6);
    }
    return jobId;
  }

  @override
  Widget build(BuildContext context) {
    // ------------------- FIXED CLIENT FIELDS -------------------
    final client = widget.jobData.client;

    String clientName =
    "${client.firstName} ${client.lastName}".trim().isEmpty
        ? 'N/A'
        : "${client.firstName} ${client.lastName}";

    String clientNo = client.mobile.isNotEmpty ? client.mobile : 'N/A';

    String clientImage =
    client.profileImage.isNotEmpty ? client.profileImage : '';

    // Manager fields
    String shiftManagerName = widget.jobData.manager.isNotEmpty
        ? widget.jobData.manager[0].name
        : 'N/A';

    String shiftManagerNo = widget.jobData.manager.isNotEmpty
        ? widget.jobData.manager[0].phone
        : 'N/A';

    // Other fields
    final String title = widget.jobData.title;
    final DateTime date = widget.jobData.startTime;
    final String startTime = formatDateTime(widget.jobData.startTime);
    final String endTime = formatDateTime(widget.jobData.endTime);
    final String taskDescription = widget.jobData.description;
    final String location = widget.jobData.address.formattedAddress;
    final String shiftType = widget.jobData.shift;
    final dynamic allowances = widget.jobData.allowances;

    // 🔥 Zaroori: jobId ko hamesha string mein rakhein comparison ke liye
    final String jobId = widget.jobData.id.toString();

    final clientInfoForAvailableJobs = widget.jobData;
    final List<Tasks> tasksForAvailableJobs = widget.jobData.task;

    Duration duration =
    widget.jobData.endTime.difference(widget.jobData.startTime);

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12.0),
      decoration: ShapeDecoration(
        color: AppConstants.kcwhiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: AppConstants.kShadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppConstants.kTextStyleMediumBoldBlack,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Job ID: $lastSixJobId",
                      style: AppConstants
                          .kTextStyleSmallRegularBlackoverflowcontrol,
                    ),
                  ],
                ),
              ),

              ReuseableSmallButton(
                text: 'See More',
                textStyle: AppConstants.kTextStyleSmallBoldGreen,
                bgColor: AppConstants.kcgreenbgColor,
                onpress: () {
                  Navigator.push(
                    context,
                    SlideTransitionPage(
                      applySlideTransition: true,
                      page: JobDetailsScreen(
                        whichKindOfJob: 'Available',
                        shiftManagerName: shiftManagerName,
                        shiftManagerNo: shiftManagerNo,
                        clientName: clientName,
                        clientNo: clientNo,
                        location: location,
                        shiftType: shiftType,
                        allowances: allowances,
                        jobTitle: title,
                        date: date,
                        startTime: startTime,
                        endTime: endTime,
                        distance: "",
                        hoursOfShift: duration,
                        description: taskDescription,
                        clientImage: clientImage,
                        clientInfoForAvailableJobs:
                        clientInfoForAvailableJobs,
                        tasksForAssignedJobs: const [],
                        tasksForAvailableJobs: tasksForAvailableJobs,
                        jobId: jobId,
                        shiftManagerId: '',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date: ${date.day}/${date.month}/${date.year}",
                style:
                AppConstants.kTextStyleSmallRegularBlackoverflowcontrol,
              ),
              Text(
                "Time: $startTime - $endTime",
                style:
                AppConstants.kTextStyleSmallRegularBlackoverflowcontrol,
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            taskDescription,
            maxLines: 2,
            style:
            AppConstants.kTextStyleSmallRegularBlackDecription,
          ),

          const Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (clientNo != 'N/A') {
                    Utils.launchPhoneDialer(context, clientNo);
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.phone_outlined, size: 15),
                    const SizedBox(width: 5),
                    Text(
                      clientNo,
                      style: AppConstants
                          .kTextStyleSmallRegularBlackoverflowcontrol,
                    ),
                  ],
                ),
              ),

              shiftType == 'day'
                  ? Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(9)),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.sunny,
                        size: 15, color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  Text('Day',
                      style: AppConstants
                          .kTextStyleSmallRegularBlackoverflowcontrol),
                ],
              )
                  : Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(9)),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.dark_mode_rounded,
                        size: 15, color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  Text('Night',
                      style: AppConstants
                          .kTextStyleSmallRegularBlackoverflowcontrol),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Utils().openGoogleMapsWithAddress(context, location);
                },
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 15),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppConstants
                            .kTextStyleSmallRegularBlackoverflowcontrol,
                      ),
                    ),
                  ],
                ),
              ),

              Consumer<JobApplicationProvider>(
                builder: (context, value, child) {
                  // 🔥 Ab ye Provider ke SharedPreferences wale data se sync ho gaya hai
                  bool isApplied = value.isJobApplied(jobId);

                  return isLoading
                      ? const CircularProgressIndicator()
                      : ReuseableSmallButton(
                    text: isApplied ? 'Applied' : 'Apply Now',
                    textStyle: AppConstants.kTextStyleSmallBoldGreen,
                    bgColor: isApplied ? Colors.grey.shade300 : AppConstants.kcgreenbgColor,

                    // Click disable if already applied
                    onpress: isApplied ? () {} : () {
                      _handleApplyClick(value, jobId);
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void _handleApplyClick(JobApplicationProvider value, String jobId) async {
    setState(() => isLoading = true);

    await value.submitJobApplication(jobId);

    _showResultDialog(context, value.jobApplicationFuture);

    if (mounted) setState(() => isLoading = false);
  }

  void _showResultDialog(
      BuildContext context, Future<Map<String, dynamic>> future) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FutureBuilder<Map<String, dynamic>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AlertDialog(
                title: Text('Submitting...'),
                content: SizedBox(height: 40, child: Center(child: CircularProgressIndicator())),
              );
            } else {
              bool success = snapshot.data?['success'] ?? false;
              String message = snapshot.data?['message'] ?? 'Unknown error';

              return AlertDialog(
                title: Text(success ? 'Success' : 'Error'),
                content: Text(message),
                actions: <Widget>[
                  ReuseableGradientButton(
                    onpress: () {
                      Navigator.of(context).pop();
                    },
                    width: MediaQuery.of(context).size.width / 4,
                    title: 'Ok',
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
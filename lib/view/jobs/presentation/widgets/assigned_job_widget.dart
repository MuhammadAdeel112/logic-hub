import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_small_button.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/models/assigned_jobs_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../models/available_jobs_model.dart';
import '../screens/job_cancelation_screen.dart';
import '../screens/job_details_screen.dart';

class AssiginedJobWidget extends StatelessWidget {
  final String JobId;
  final String title;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String taskDescription;
  final String location;
  final String phoneNumber;
  final String distance;
  final String shiftType;
  final dynamic allowances;
  final noOfJobsLenght;
  final String shiftManagerName;
  final String shiftManagerNo;
  final String shiftManagerId;
  final String clientId;
  final String clientNo;
  final String clientName;
  final String clientImage;
  final clientInfoForAssignedJobs;
  final clientInfoForAvailableJobs;
  final List<Task> tasksForAssignedJobs;
  final List<Tasks> tasksForAvailableJobs;
  final Duration duration;

  const AssiginedJobWidget(
      {Key? key,
        required this.JobId,
        required this.noOfJobsLenght,
        required this.title,
        required this.date,
        required this.startTime,
        required this.endTime,
        required this.taskDescription,
        required this.location,
        required this.phoneNumber,
        required this.distance,
        required this.shiftType,
        required this.allowances,
        required this.shiftManagerName,
        required this.shiftManagerNo,
        required this.shiftManagerId,
        required this.clientId,
        required this.clientName,
        required this.clientNo,
        required this.clientImage,
        this.clientInfoForAssignedJobs,
        this.clientInfoForAvailableJobs,
        required this.tasksForAssignedJobs,
        required this.tasksForAvailableJobs,
        required this.duration})
      : super(key: key);

  String get lastSixJobId {
    if (JobId.length >= 6) {
      return JobId.substring(JobId.length - 6);
    }
    return JobId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12.0),
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 1.1),
      decoration: ShapeDecoration(
        color: AppConstants.kcwhiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: AppConstants.kShadows,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    // --------------------- Job ID (last 6 digits) ---------------------
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
                        whichKindOfJob: 'Assigned',
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
                        distance: distance,
                        hoursOfShift: duration,
                        description: taskDescription,
                        clientImage: clientImage,
                        clientInfoForAssignedJobs:
                        clientInfoForAssignedJobs,
                        tasksForAssignedJobs: tasksForAssignedJobs,
                        tasksForAvailableJobs: tasksForAvailableJobs,
                        jobId: JobId,
                        clientId: clientId,
                        shiftManagerId: shiftManagerId,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Divider(color: Colors.transparent),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Date: ',
                      style: AppConstants.kTextStyleSmallBoldBlack,
                    ),
                    TextSpan(
                      text: '${date.day}/${date.month}/${date.year}',
                      style: AppConstants
                          .kTextStyleSmallRegularBlackoverflowcontrol,
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Time: ',
                      style: AppConstants.kTextStyleSmallBoldBlack,
                    ),
                    TextSpan(
                      text: '$startTime - $endTime',
                      style: AppConstants
                          .kTextStyleSmallRegularBlackoverflowcontrol,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: Colors.transparent),
          Text(
            taskDescription,
            maxLines: 2,
            style: AppConstants.kTextStyleSmallRegularBlackDecription,
          ),
          Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  Utils.launchPhoneDialer(context, phoneNumber);
                },
                child: Row(
                  children: [
                    Icon(Icons.phone_outlined, size: 15),
                    Text(
                      phoneNumber,
                      style: AppConstants
                          .kTextStyleSmallRegularBlackoverflowcontrol,
                    ),
                  ],
                ),
              ),
              if (allowances >= 1)
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Allowances ',
                        style: AppConstants.kTextStyleSmallBoldBlack,
                      ),
                      TextSpan(
                        text: '$allowances',
                        style: AppConstants
                            .kTextStyleSmallRegularBlackoverflowcontrol,
                      ),
                    ],
                  ),
                ),
              shiftType == 'night'
                  ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.dark_mode_rounded,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Night',
                      style: AppConstants
                          .kTextStyleSmallRegularBlackoverflowcontrol,
                    ),
                  )
                ],
              )
                  : Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.sunny,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Day',
                      style: AppConstants
                          .kTextStyleSmallRegularBlackoverflowcontrol,
                    ),
                  )
                ],
              ),
            ],
          ),
          Divider(color: Colors.transparent),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Utils().openGoogleMapsWithAddress(context, location);
                },
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 15),
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
              ReuseableSmallButton(
                text: 'Cancel Job',
                textStyle: AppConstants.kTextStyleSmallBoldRed,
                bgColor: AppConstants.kcredbgColor,
                onpress: () {
                  Navigator.push(
                    context,
                    SlideTransitionPage(
                      page: JobCancelationScreen(jobId: JobId),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

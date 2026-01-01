// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:divine_employee_app/view/jobs/presentation/widgets/show_about_cleint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:divine_employee_app/core/common%20widgets/reuseable_small_button.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';

import '../../../../models/assigned_jobs_model.dart';

class JobDetailsDuringJobWidget extends StatelessWidget {
  final shiftManagerName;
  final String shiftManagerNo;
  final String clientName;
  final String clientNo;
  final String clientImage;
  final String location;
  final shiftType;
  final int allowances;
  final String jobTitle;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final distance;
  final Duration HoursOfShift;
  final description;
  final List<Task> tasksForAssignedJobs;
  final Job? clientInfoForAssignedJobs;
  JobDetailsDuringJobWidget({
    Key? key,
    required this.shiftManagerNo,
    required this.clientName,
    required this.clientNo,
    required this.clientImage,
    required this.location,
    required this.allowances,
    required this.jobTitle,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.HoursOfShift,
    required this.tasksForAssignedJobs,
    required this.clientInfoForAssignedJobs,
    required this.shiftManagerName,
    required this.shiftType,
    required this.distance,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: ShapeDecoration(
            color: AppConstants.kcwhiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadows: AppConstants.kShadows),
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            children: [
              // picture , shiftmanager name ,phone no
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      decoration: ShapeDecoration(
                          shape: OvalBorder(), shadows: AppConstants.kShadows),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(clientImage),
                        foregroundColor: AppConstants.kcredbgColor,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Shift Manager: ',
                              style: AppConstants
                                  .kTextStyleSmallRegularBlackDecription,
                            ),
                            TextSpan(
                                text: shiftManagerName,
                                style: AppConstants.kTextStyleSmallBoldGreen),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.phone,
                              size: 15,
                            ),
                          ),
                          Text(
                            shiftManagerNo,
                            style: AppConstants.kTextStyleMediumRegularGrey,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Divider(
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clientName,
                        style: AppConstants.kTextStyleMediumBoldBlack,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.phone,
                              size: 15,
                            ),
                          ),
                          Text(
                            clientNo,
                            style: AppConstants.kTextStyleMediumRegularGrey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  ReuseableSmallButton(
                      onpress: () {
                        ShowAboutClientforassignedJob(
                            context, clientInfoForAssignedJobs!);
                      },
                      text: 'About Client',
                      bgColor: AppConstants.kcgreenbgColor,
                      textStyle: AppConstants.kTextStyleSmallBoldGreen),
                  Spacer(),
                  Spacer()
                ],
              ),
              Divider(
                color: Colors.transparent,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.location_on,
                      size: 15,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 1.5),
                    child: Text(
                      location,
                      style: AppConstants.kTextStyleMediumRegularGrey,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.transparent,
              ),
              // date time

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    jobTitle,
                    style: AppConstants.kTextStyleMediumBoldBlack,
                  ),
                ],
              ),
              Divider(
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (allowances != 0)
                    Column(
                      children: [
                        Text(
                          'Allowances: \$${allowances.toString()}',
                          style: AppConstants.kTextStyleMediumRegularBlack,
                        ),
                      ],
                    ),
                  shiftType == 'night'
                      ? Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(9)),
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.dark_mode_rounded,
                                  size: 15,
                                  color: Colors.white,
                                )),
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
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(9)),
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.sunny,
                                  size: 15,
                                  color: Colors.white,
                                )),
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
                  // Row(
                  //   children: [
                  //     Container(
                  //       margin: EdgeInsets.only(right: 4),
                  //       decoration: BoxDecoration(
                  //           color: AppConstants.kcprimaryColor,
                  //           borderRadius: BorderRadius.circular(9)),
                  //       padding: EdgeInsets.all(4),
                  //       child: SvgPicture.asset(
                  //         color: Colors.white,
                  //         height: 16,
                  //         AppConstants.distanceIconPath,
                  //       ),
                  //     ),
                  //     Text(
                  //       '$distance KM',
                  //       style: AppConstants.kTextStyleMediumRegularGrey,
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                            color: AppConstants.kcprimaryColor,
                            borderRadius: BorderRadius.circular(9)),
                        child: SvgPicture.asset(
                          // ignore: deprecated_member_use
                          color: AppConstants.kcwhiteColor,
                          AppConstants.clockIconPath,
                        ),
                      ),
                      Text(
                        '${HoursOfShift.inHours}:${HoursOfShift.inMinutes % 60} Shift',
                        style: AppConstants.kTextStyleMediumRegularGrey,
                      ),
                    ],
                  )
                ],
              ),
              Divider(
                color: Colors.transparent,
              ),
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
                            text: date.day.toString() +
                                '-' +
                                date.month.toString() +
                                '-' +
                                date.year.toString(),
                            style: AppConstants
                                .kTextStyleSmallRegularBlackoverflowcontrol),
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
                            text: startTime.hour.toString() +
                                ':' +
                                startTime.minute.toString(),
                            style: AppConstants
                                .kTextStyleSmallRegularBlackoverflowcontrol),
                        TextSpan(
                          text: ' - ',
                          style: AppConstants.kTextStyleSmallBoldBlack,
                        ),
                        TextSpan(
                            text: endTime.hour.toString() +
                                ':' +
                                endTime.minute.toString(),
                            style: AppConstants
                                .kTextStyleSmallRegularBlackoverflowcontrol),
                      ],
                    ),
                  ),
                ],
              ),

              Divider(
                color: Colors.transparent,
              ),
              // job description
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Job Description',
                        style: AppConstants.kTextStyleMediumBoldBlack,
                      ),
                    ],
                  ),
                  SizedBox(),
                ],
              ),
              Divider(
                color: Colors.transparent,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 1.3,
                      maxHeight: MediaQuery.of(context).size.height /
                          6, // Set the maximum height you desire/ Set the maximum height you desire
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        description.toString(),
                        style: AppConstants.kTextStyleSmallRegularBlack,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

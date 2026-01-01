import 'package:divine_employee_app/view/availability/presentation/screens/requested_availbility_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../models/assigned_jobs_model.dart';

class DetailsOfJobInJobReportWidget extends StatelessWidget {
  // final shiftType;
  final Job job;

  DetailsOfJobInJobReportWidget({
    required this.job,
    // required this.shiftType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Duration duration = job.endTime.difference(job.startTime);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Container(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1),
            decoration: ShapeDecoration(
                color: AppConstants.kcwhiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: AppConstants.kShadows),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // date time
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
                              text: job.startTime.day.toString() +
                                  '-' +
                                  job.startTime.month.toString() +
                                  '-' +
                                  job.startTime.year.toString(),
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
                              text: formatDateTime(job.startTime),
                              style: AppConstants
                                  .kTextStyleSmallRegularBlackoverflowcontrol),
                          TextSpan(
                            text: ' - ',
                            style: AppConstants.kTextStyleSmallBoldBlack,
                          ),
                          TextSpan(
                              text: formatDateTime(job.endTime),
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
                    Row(
                      children: [
                        job.shift == 'day'
                            ? Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                      padding: EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.sunny,
                                        size: 15,
                                        color: Colors.white,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, right: 4),
                                    child: Text(
                                      'Day',
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
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                      padding: EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.dark_mode_rounded,
                                        size: 15,
                                        color: Colors.white,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, right: 4),
                                    child: Text(
                                      'Night',
                                      style: AppConstants
                                          .kTextStyleSmallRegularBlackoverflowcontrol,
                                    ),
                                  )
                                ],
                              ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppConstants.clockIconPath,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                '${duration.inHours}:${duration.inMinutes % 60} hour',
                                style: AppConstants.kTextStyleMediumRegularGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 1.3,
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          job.description,
                          style: AppConstants.kTextStyleSmallRegularBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tasks',
              style: AppConstants.kTextStyleMediumBoldBlack,
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap:
                true, // Add this to make the ListView shrink-wrap its content
            itemCount: job.task.length, // Replace with the actual item count
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(vertical:8),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    // side: BorderSide(width: 0.25),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  '${index + 1}: ${job.task[index].title}',
                  style: AppConstants.kTextStyleSmallRegularBlack,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

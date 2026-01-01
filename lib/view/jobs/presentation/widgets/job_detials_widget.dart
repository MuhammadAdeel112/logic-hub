// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/models/assigned_jobs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:divine_employee_app/core/common widgets/reuseable_small_button.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';

import '../../../../models/available_jobs_model.dart';
import 'show_about_cleint.dart';

class JobDetailsWidget extends StatelessWidget {
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
  final String startTime;
  final String endTime;
  final distance;
  final Duration HoursOfShift;
  final description;
  final List<Task> tasksForAssignedJobs;
  final List<Tasks> tasksForAvailableJobs;
  final clientInfoForAssignedJobs;
  final clientInfoForAvailableJobs;

  final String? clientId;
  final String? riskAssessment;
  final String? livingArrangement;
  final String? goal;
  final String? sportNeed;

  const JobDetailsWidget({
    Key? key,
    required this.shiftManagerName,
    required this.shiftManagerNo,
    required this.clientName,
    required this.clientNo,
    required this.clientImage,
    required this.location,
    required this.shiftType,
    required this.allowances,
    required this.jobTitle,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.distance,
    required this.HoursOfShift,
    required this.description,
    required this.tasksForAssignedJobs,
    required this.tasksForAvailableJobs,
    required this.clientInfoForAssignedJobs,
    required this.clientInfoForAvailableJobs,
    this.clientId,
    this.riskAssessment,
    this.livingArrangement,
    this.goal,
    this.sportNeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ================= MAIN CARD =================
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: ShapeDecoration(
            color: AppConstants.kcwhiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: AppConstants.kShadows,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Column(
              children: [
                // TOP ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(clientImage),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Shift Manager: ${shiftManagerName.toString()}',
                          style: AppConstants.kTextStyleSmallBoldGreen,
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            Utils.launchPhoneDialer(context, shiftManagerNo);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.phone, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                shiftManagerNo,
                                style: AppConstants.kTextStyleMediumRegularGrey,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),

                const Divider(height: 24),

                // CLIENT INFO
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(clientName,
                              style: AppConstants.kTextStyleMediumBoldBlack),
                          const SizedBox(height: 4),
                          if (clientId != null)
                            Text(
                              'Client ID: ${clientId!.length > 6 ? clientId!.substring(clientId!.length - 6) : clientId!}',
                              style: AppConstants.kTextStyleMediumRegularGrey,
                            ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: () {
                              Utils.launchPhoneDialer(context, clientNo);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.phone, size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  clientNo,
                                  style: AppConstants.kTextStyleMediumRegularGrey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ReuseableSmallButton(
                      onpress: () {
                        if (clientInfoForAssignedJobs != null) {
                          ShowAboutClientforassignedJob(
                              context, clientInfoForAssignedJobs);
                        } else if (clientInfoForAvailableJobs != null) {
                          ShowAboutClientforAvailableJob(
                              context, clientInfoForAvailableJobs);
                        }
                      },
                      text: 'About Client',
                      bgColor: AppConstants.kcgreenbgColor,
                      textStyle: AppConstants.kTextStyleSmallBoldGreen,
                    )
                  ],
                ),

                const SizedBox(height: 10),

                // RISK / GOALS BOX
                if (riskAssessment != null ||
                    livingArrangement != null ||
                    goal != null ||
                    sportNeed != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (riskAssessment != null)
                          _infoText('Risk Assessment', riskAssessment!),
                        if (livingArrangement != null)
                          _infoText('Living Arrangement', livingArrangement!),
                        if (goal != null) _infoText('Goal', goal!),
                        if (sportNeed != null)
                          _infoText('Sport Need', sportNeed!),
                      ],
                    ),
                  ),

                const Divider(height: 16),

                // LOCATION
                InkWell(
                  onTap: () {
                    Utils().openGoogleMapsWithAddress(context, location);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, size: 18),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          location,
                          style: AppConstants.kTextStyleMediumRegularGrey,
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // JOB TITLE
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(jobTitle,
                      style: AppConstants.kTextStyleMediumBoldBlack),
                ),

                const SizedBox(height: 12),

                // ALLOWANCE + SHIFT + HOURS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (allowances != 0)
                      Text(
                        'Allowances: \$${allowances.toString()}',
                        style: AppConstants.kTextStyleMediumRegularBlack,
                      ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: shiftType == 'night'
                                ? Colors.black
                                : Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            shiftType == 'night'
                                ? Icons.dark_mode_rounded
                                : Icons.sunny,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          shiftType == 'night' ? 'Night' : 'Day',
                          style: AppConstants
                              .kTextStyleSmallRegularBlackoverflowcontrol,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppConstants.kcprimaryColor,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: SvgPicture.asset(
                            AppConstants.clockIconPath,
                            color: AppConstants.kcwhiteColor,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${HoursOfShift.inHours}:${HoursOfShift.inMinutes % 60} hour',
                          style: AppConstants.kTextStyleMediumRegularGrey,
                        ),
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 14),

                // DATE TIME
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date: ${date.day}-${date.month}-${date.year}',
                      style: AppConstants.kTextStyleSmallBoldBlack,
                    ),
                    Text(
                      'Time: $startTime - $endTime',
                      style: AppConstants.kTextStyleSmallRegularBlackoverflowcontrol,
                    )
                  ],
                ),

                const Divider(height: 22),

                // DESCRIPTION
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Job Description',
                    style: AppConstants.kTextStyleMediumBoldBlack,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description.toString(),
                  style: AppConstants.kTextStyleSmallRegularBlack,
                ),
              ],
            ),
          ),
        ),

        // ================= TASKS SECTION =================
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tasks',
              style: AppConstants.kTextStyleMediumBoldBlack,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: (tasksForAvailableJobs.isEmpty)
              ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tasksForAssignedJobs.length,
            itemBuilder: (context, index) {
              final task = tasksForAssignedJobs[index];
              return _taskTile(index + 1, (task.title ?? '').toString());
            },
          )
              : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tasksForAvailableJobs.length,
            itemBuilder: (context, index) {
              final task = tasksForAvailableJobs[index];
              return _taskTile(index + 1, (task.title ?? '').toString());
            },
          ),
        ),
      ],
    );
  }

  Widget _infoText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        '$title: $value',
        style: AppConstants.kTextStyleSmallRegularBlack,
      ),
    );
  }

  Widget _taskTile(int index, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(blurRadius: 5, color: Colors.black12, offset: Offset(0, 2))
        ],
      ),
      child: Text(
        '$index. $title',
        style: AppConstants.kTextStyleSmallRegularBlack,
      ),
    );
  }
}

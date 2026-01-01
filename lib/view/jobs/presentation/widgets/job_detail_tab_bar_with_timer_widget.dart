import 'dart:async';
import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/common%20widgets/resueable_tabbar_button.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/availability/presentation/screens/requested_availbility_details_screen.dart';
import 'package:divine_employee_app/view/jobs/presentation/provider/assigned_task_provider.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/scan_qr_code.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../api_provider/data_provider_for_employee_profile.dart';
import '../../../../api_provider/clock_out_api_provider.dart';
import '../../../../api_provider/task_update_api_provider.dart';
import '../../../../core/utils/utlis.dart';
import '../../../incidents/presentation/screens/generate_incident_screen.dart';
import '../provider/timer_model.dart';

class JobDetailTabBarWithTimerWidget extends StatefulWidget {
  final String jobId;
  final String jobTitle;
  final staffName;
  final clientName;
  final clientId;

  final incidentlocation;
  const JobDetailTabBarWithTimerWidget({
    required this.jobId,
    required this.jobTitle,
    required this.clientName,
    required this.staffName,
    required this.clientId,
    required this.incidentlocation,
    super.key,
  });

  @override
  State<JobDetailTabBarWithTimerWidget> createState() =>
      _JobDetailTabBarWithTimerWidgetState();
}

class _JobDetailTabBarWithTimerWidgetState
    extends State<JobDetailTabBarWithTimerWidget> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<DataProviderForEmployeeProfile>(context, listen: false)
          .fetchEmployeeProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final employeeData =
        Provider.of<DataProviderForEmployeeProfile>(context, listen: false);
    String staffname = employeeData.employeeProfile?.employee.name ?? '';
    String staffDesignation =
        employeeData.employeeProfile?.employee.category ?? '';

    final taskUpdateProvider = Provider.of<TaskUpdateApiProvider>(context);
    final provider = Provider.of<ClockOutApiProvider>(context);
    return Container(
      decoration: ShapeDecoration(
        color: AppConstants.kcwhiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: AppConstants.kShadows,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Consumer<WorkProvider>(builder: (context, workProvider, child) {
              final startTime = workProvider.startTime;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      color: AppConstants.kcwhiteColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: AppConstants.kcgreyColor,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Row(
                        children: [
                          Text('Clock In Time: '),
                          Text(
                            '${startTime != null ? formatDateTime(startTime) : 'N/A'}',
                            style: AppConstants.kTextStyleMediumBoldBlack,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
            Divider(
              color: Colors.transparent,
            ),
            Container(
              margin: EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: AppConstants.kcwhiteColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: AppConstants.kcgreyColor,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Consumer<WorkProvider>(
                  builder: (context, workProvider, child) {
                    final currentDuration = workProvider.getCurrentDuration();
                    return Row(
                      children: [
                        Text('Current Duration: '),
                        Text(
                            style: AppConstants.kTextStyleMediumBoldBlack,
                            '${formatDuration(currentDuration)}'),
                      ],
                    );
                  },
                ),
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               ReuseableTabbarButton(
                    borderColor: AppConstants.kcgreyColor,
                    onpress: () {
                      Navigator.push(
                          context,
                          SlideTransitionPage(
                              page: GenerateIncidentScreen(
                                  clientName: widget.clientName,
                                  JobId: widget.jobId,
                                  shiftManagerName: staffname,
                                  shiftManagerDesignation: staffDesignation,
                                  location: widget.incidentlocation)));
                    },
                    text: 'Report Incident',
                    bgColor: AppConstants.kcgreyColor,
                    textStyle: AppConstants.kTextStyleMediumBoldBlack),
                taskUpdateProvider.isLoading || provider.isLoading
                    ? CircularProgressIndicator()
                    : ReuseableTabbarButton(
                        onpress: () async {
                          var all = Provider.of<AssignedJobTaskProvider>(
                                  context,
                                  listen: false)
                              .totalLength;
                          List<String> selectedTaskIds =
                              Provider.of<AssignedJobTaskProvider>(context,
                                      listen: false)
                                  .selectedTaskIds;
                          if (selectedTaskIds.length == 0) {
                            Utils.showFlushbar(
                                'Please completed some task before clock out',
                                context);
                          } else
                          if (selectedTaskIds.length < all && selectedTaskIds.length != 0) {
                            // Utils.showFlushbar(
                            //     'Some task are missing, Do you Still want to continue?',
                            //     context);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Some tasks are missing'),
                                  content:
                                      Text('Do you still want to continue?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        // Close the dialog and cancel the action
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // Close the dialog and continue with the action
                                        Navigator.of(context).pop(true);
                                        final taskUpdateProvider =
                                            Provider.of<TaskUpdateApiProvider>(
                                                context,
                                                listen: false);

                                        Map<String, dynamic> payload = {
                                          "taskIds": selectedTaskIds,
                                          "status": true,
                                        };
                                        print('printing ${payload}');
                                        // Execute the taskUpdateProvider method and wait for the result
                                        await taskUpdateProvider
                                            .updateTaskStatus(
                                                payload, widget.jobId);

                                        // Check the result of the task update
                                        Map<String, dynamic> result =
                                            await taskUpdateProvider
                                                .taskUpdateFuture;
                                        if (result['success']) {
                                          Navigator.push(
                                              context,
                                              SlideTransitionPage(
                                                  page: ScanQrCode(
                                                      isClockOut: true,
                                                      jobTitle: widget.jobTitle,
                                                      cilentId: widget.clientId,
                                                      JobId: widget.jobId)));
                                        } else {
                                          // Handle the case where the task update was not successful
                                          // You might want to show an error message to the user
                                          Utils.showFlushbar(
                                              'Please complete all tasks first before Clock-out',
                                              // 'Task update failed: ${result['message']}',
                                              context);
                                          print(
                                              'Task update failed: ${result['message']}');
                                        }
                                      },
                                      child: Text('Continue'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            final taskUpdateProvider =
                                Provider.of<TaskUpdateApiProvider>(context,
                                    listen: false);

                            Map<String, dynamic> payload = {
                              "taskIds": selectedTaskIds,
                              "status": true,
                            };
                            print('printing ${payload}');
                            // Execute the taskUpdateProvider method and wait for the result
                            await taskUpdateProvider.updateTaskStatus(
                                payload, widget.jobId);

                            // Check the result of the task update
                            Map<String, dynamic> result =
                                await taskUpdateProvider.taskUpdateFuture;
                            if (result['success']) {
                              Navigator.push(
                                  context,
                                  SlideTransitionPage(
                                      page: ScanQrCode(
                                          isClockOut: true,
                                          jobTitle: widget.jobTitle,
                                          cilentId: widget.clientId,
                                          JobId: widget.jobId)));
                            } else {
                              // Handle the case where the task update was not successful
                              // You might want to show an error message to the user
                              Utils.showFlushbar(
                                  'Please complete all tasks first before Clock-out',
                                  // 'Task update failed: ${result['message']}',
                                  context);
                              print('Task update failed: ${result['message']}');
                            }
                          }
                        },
                        text: 'Clock Out',
                        borderColor: Colors.red,
                        bgColor: Colors.red,
                        textStyle: AppConstants.kTextStyleMediumBoldWhite)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String formatDuration(Duration duration) {
  final days = duration.inDays;
  final hours = duration.inHours % 24;
  final minutes = duration.inMinutes % 60;
  final seconds = duration.inSeconds % 60;

  String result = '';

  if (days > 0) {
    result += '$days days, ';
  }

  result += '$hours hr, $minutes mins, $seconds secs';

  return result;
}

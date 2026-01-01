// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:divine_employee_app/api_provider/job_application_provider.dart';
import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/scan_qr_code.dart';
import 'package:flutter/material.dart';
import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/job_cancelation_screen.dart';
import 'package:provider/provider.dart';

import '../../../../api_provider/fetch_all_chats_api_provider.dart';
import '../../../../core/common widgets/resueable_tabbar_button.dart';
import '../../../../api_provider/clock_in_api_provider.dart';

// ignore: must_be_immutable
class JobDetailTabBarWidget extends StatelessWidget {
  final String jobId;
  final String clientId;
  final String managerId;
  final String managerName;
  final String whichKindOfJob;
  var senderId = SessionHandlingViewModel().getUser();

  var provider;

  JobDetailTabBarWidget({
    Key? key,
    required this.whichKindOfJob,
    required this.jobId,
    required this.managerId,
    required this.managerName,
    required this.clientId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ClockInApiProvider>(context);
    var jobApplicationProvider = Provider.of<JobApplicationProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width / 1,
      height: MediaQuery.of(context).size.height / 16,
      decoration: ShapeDecoration(
        color: AppConstants.kcwhiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: AppConstants.kShadows,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ReuseableTabbarButton(
              onpress: () {
                Navigator.push(
                    context,
                    SlideTransitionPage(
                        page: JobCancelationScreen(
                      jobId: jobId,
                    )));
              },
              text: 'Cancel',
              borderColor: AppConstants.kcgreyColor,
              bgColor: AppConstants.kcwhiteColor,
              textStyle: AppConstants.kTextStyleMediumBoldBlack),
          whichKindOfJob == 'Assigned'
              ? ReuseableTabbarButton(
                  onpress: () async {
                    AllChatsProvider().findAndCreateChat(
                        await SessionHandlingViewModel().getMyId() ?? '',
                        managerId,
                        jobId,
                        managerName,
                        context);
                  },
                  text: 'Chat',
                  borderColor: AppConstants.kcgreyColor,
                  bgColor: AppConstants.kcprimaryColor,
                  textStyle: AppConstants.kTextStyleMediumBoldWhite)
              : SizedBox.shrink(),
          whichKindOfJob == 'Assigned'
              ? provider.isLoading
                  ? CircularProgressIndicator()
                  : ReuseableTabbarButton(
                      onpress: () async {
                        // clockIn(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScanQrCode(
                                    cilentId: clientId,
                                    JobId: jobId,
                                    isClockIn: true,
                                  )),
                        );
                      },
                      text: 'Clock In',
                      borderColor: AppConstants.kcgreyColor,
                      bgColor: AppConstants.kcprimaryColor,
                      textStyle: AppConstants.kTextStyleMediumBoldWhite)
              : Consumer<JobApplicationProvider>(
                  builder: (BuildContext context, JobApplicationProvider value,
                      Widget? child) {
                    return jobApplicationProvider.isLoading
                        ? Container(
                            child: CircularProgressIndicator(),
                          )
                        : ReuseableTabbarButton(
                            borderColor: AppConstants.kcgreyColor,
                            text: 'Apply Now',
                            textStyle: AppConstants.kTextStyleSmallBoldGreen,
                            bgColor: AppConstants.kcgreenbgColor,
                            onpress: () async {
                              await jobApplicationProvider
                                  .submitJobApplication(jobId);
                              _showResultDialog(context,
                                  jobApplicationProvider.jobApplicationFuture);
                            },
                          );
                  },
                ),
        ],
      ),
    );
  }

  // clockIn(BuildContext context) async {
  //   // Check if already loading to prevent multiple requests
  //   if (!provider.isLoading) {
  //     try {
  //       provider.resetLoading(); // Reset loading state
  //       final result = await provider.submitClockInRequest(jobId);

  //       if (result['success']) {
  //         // If successful, navigate to the next screen
  //         final SharedPreferences sp = await SharedPreferences.getInstance();
  //         var i = await sp.setString('currentJobId', jobId);
  //         print(' job id : ${i} which was stored in FFat clock in');
  //         print(' job id : ${jobId} which was set to at clock in');

  //         Navigator.push(
  //             context,
  //             SlideTransitionPage(
  //               page: DuringJobScreen(),
  //             ));
  //         Utils.showFlushbar('Clock-In request Successful', context);
  //       } else {
  //         // Handle the case where the clock-in request was not successful
  //         // You might want to show an error message to the user
  //         Utils.showFlushbar(
  //             'Clock-In request failed: ${result['message']}', context);
  //         print('Clock-In request failed: ${result['message']}');
  //       }
  //     } finally {
  //       provider.resetLoading(); // Reset loading state after the request
  //     }
  //   }
  // }

  void _showResultDialog(
      BuildContext context, Future<Map<String, dynamic>> future) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<Map<String, dynamic>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AlertDialog(
                title: Text('Submitting...'),
                content: CircularProgressIndicator(),
              );
            } else {
              // Display the result dialog based on the response
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

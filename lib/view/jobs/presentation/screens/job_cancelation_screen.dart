
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/api_provider/job_cancelation_request_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common widgets/reuseable_sccafold_screen.dart';

class JobCancelationScreen extends StatelessWidget {
  final String jobId;

  JobCancelationScreen({
    required this.jobId,
    super.key,
  });

  final TextEditingController titleTextEditingController =
      TextEditingController();

  final TextEditingController reasonTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final jobCancelationRequestProvider =
        Provider.of<JobCancelationRequestProvider>(context);

    return ReuseableScaffoldScreen(
      appBarTitle: 'Job Cancelation',
      content: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: Container(
                  padding: EdgeInsets.all(18),
                  decoration: ShapeDecoration(
                      color: AppConstants.kcwhiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: AppConstants.kShadows),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Leave Title',
                        style: AppConstants.kTextStyleMediumBoldBlack,
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Container(
                        // width: MediaQuery.of(context).size.width / 1.2,
                        // height: MediaQuery.of(context).size.height / 17,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFF334155)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: TextFormField(
                          controller: titleTextEditingController,
                          decoration: InputDecoration(
                            hintText: "Enter title",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      // document details
                      Divider(
                        color: Colors.transparent,
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      //uplaod file
                      Text(
                        'Reasons',
                        style: AppConstants.kTextStyleMediumBoldBlack,
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFF334155)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                        child: TextFormField(
                          controller: reasonTextEditingController,
                          textAlign: TextAlign.start,
                          maxLength: 430,
                          maxLines: 5,

                          decoration: InputDecoration(
                              hintText: 'Write Something...',
                              border: InputBorder.none),
                          keyboardType: TextInputType.text,
                          //obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the Description!';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {},
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      SizedBox(),
                      FutureBuilder<Map<String, dynamic>>(
                        future:
                            Provider.of<JobCancelationRequestProvider>(context)
                                .jobCancelationRequestFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              Provider.of<JobCancelationRequestProvider>(
                                      context)
                                  .isLoading) {
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                child: CircularProgressIndicator(),
                              ),
                            ); // Show loading indicator
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 38, vertical: 18),
                              child: ReuseableGradientButton(
                                  title: 'Submit Application',
                                  onpress: () async {
                                    if (titleTextEditingController
                                        .text.isEmpty) {
                                      Utils.showFlushbar(
                                          'Please Enter Title', context);
                                    } else if (reasonTextEditingController
                                        .text.isEmpty) {
                                      Utils.showFlushbar(
                                          'Please Enter Reason', context);
                                    } else {
                                      Utils.dismissKeyboard(context);
                                      await jobCancelationRequestProvider
                                          .submitJobCancelationRequest(
                                        jobId,
                                        titleTextEditingController.text
                                            .toString(),
                                        reasonTextEditingController.text
                                            .toString(),
                                      );
                                      // Show the result dialog after the submission is complete
                                      _showResultDialog(
                                          context,
                                          jobCancelationRequestProvider
                                              .jobCancelationRequestFuture);
                                    }
                                  }),
                            );
                          }
                        },
                      ),
                    ],
                  ))),
        ],
      ),
    );
  }

  void _showResultDialog(
      BuildContext context, Future<Map<String, dynamic>> future) {
    showDialog(
      // barrierDismissible: false,
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

// void _showCustomAlertDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: AppConstants.kcwhiteColor,
//         content: ResueableAlertDialogContent(
//           iconDone: true,
//           title: '',
//           subtitle:
//               'Your assigned job for [Client\'s Name] on [Date] is cancelled. Thanks for your understanding.',
//           // onCancel: () {
//           //   Navigator.of(context).pop(); // Close the dialog
//           // },
//           rightButtonTitle: 'Close',

//           leftButtonTitle: '',
//           onConfirm: () {
//             Navigator.pop(context);
//             Navigator.push(context, SlideTransitionPage(page: AppDashboard()));
//           },
//         ),
//       );
//     },
//   );
// }

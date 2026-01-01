import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/common%20widgets/resueable_alert_dialog_content.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/view/auth/presentation/screens/app_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common widgets/reuseable_sccafold_screen.dart';
import '../../../../api_provider/feed_back_api_provider.dart';

class FeedBackScreen extends StatelessWidget {
  FeedBackScreen({super.key});

  final bool isChecked = false;
  final String selectedOption = 'Send to';
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController additionalFeedbackTextController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
      appBarTitle: 'Feedback',
      content: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Container(
              decoration: ShapeDecoration(
                  color: AppConstants.kcwhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: AppConstants.kShadows),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: AppConstants.kTextStyleMediumBoldBlack,
                            ),
                            Container(
                              // height: MediaQuery.of(context).size.height / 16,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: ShapeDecoration(
                                color: AppConstants.kcwhiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                shadows: AppConstants.kShadows,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Center(
                                  child: TextFormField(
                                    controller: nameTextController,
                                    decoration: InputDecoration(
                                      hintText: "Enter Your Name",
                                      hintStyle:
                                          AppConstants.kTextStyleSmallBoldGrey,
                                      border: InputBorder.none,
                                      //  prefixIcon: Icon(
                                      //    Icons.person,
                                      //  ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Staff Name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone Number',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Container(
                                  // height: MediaQuery.of(context).size.height / 16,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  decoration: ShapeDecoration(
                                    color: AppConstants.kcwhiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    shadows: AppConstants.kShadows,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Center(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: phoneTextController,
                                        decoration: InputDecoration(
                                          hintText: "+61 123 123 123",
                                          hintStyle: AppConstants
                                              .kTextStyleSmallBoldGrey,
                                          border: InputBorder.none,
                                          //  prefixIcon: Icon(
                                          //    Icons.person,
                                          //  ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: AppConstants.kTextStyleMediumBoldGrey,
                        ),
                        Container(
                          // height: MediaQuery.of(context).size.height / 16,
                          // width: MediaQuery.of(context).size.width / 2.5,
                          decoration: ShapeDecoration(
                            color: AppConstants.kcwhiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            shadows: AppConstants.kShadows,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: TextFormField(
                                controller: emailTextController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "example@gmail.com",
                                  hintStyle:
                                      AppConstants.kTextStyleSmallBoldGrey,
                                  border: InputBorder.none,
                                  //  prefixIcon: Icon(
                                  //    Icons.person,
                                  //  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Additional Feedback',
                          style: AppConstants.kTextStyleMediumBoldGrey,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 7,
                          // height: 94,

                          // width: MediaQuery.of(context).size.width / 3,
                          decoration: ShapeDecoration(
                            color: AppConstants.kcwhiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            shadows: AppConstants.kShadows,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              controller: additionalFeedbackTextController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText:
                                    "If you have any additional feedback, please type it in here...",
                                hintStyle: AppConstants.kTextStyleSmallBoldGrey,
                                border: InputBorder.none,
                                //  prefixIcon: Icon(
                                //    Icons.person,
                                //  ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Consumer<FeedbackApiProvider>(
                      builder: (context, feedbackProvider, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            feedbackProvider.isLoading == true
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  )
                                : ReuseableGradientButton(
                                    title: 'Submit Feedback',
                                    onpress: () async {
                                      // Set loading to true when the button is pressed
                                      await feedbackProvider.submitFeedback(
                                        nameTextController.text,
                                        emailTextController.text,
                                        phoneTextController.text,
                                        additionalFeedbackTextController.text,
                                      );

                                      // Handle the result after feedback submission
                                      Map<String, dynamic> result =
                                          await feedbackProvider
                                              .feedbackRequestFuture;

                                      if (result['success']) {
                                        // If successful, handle the result
                                        print(result['message']);
                                        _showCustomAlertDialog(context);

                                        // Navigate to the next screen or show a success message
                                      } else {
                                        // Handle the error
                                        Utils.showFlushbar(
                                            result['message'], context);
                                        print(result['message']);
                                        // Show an error message or take appropriate action
                                      }
                                    },
                                  ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _showCustomAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppConstants.kcwhiteColor,
        content: ResueableAlertDialogContent(
          iconDone: true,
          title: 'Feedback Submitted!',
          subtitle:
              'Thank you for sharing your feedback. Your input matters and helps us improve.',
          // onCancel: () {
          //   Navigator.of(context).pop(); // Close the dialog
          // },
          rightButtonTitle: 'Done',
          leftButtonTitle: '',
          onConfirm: () {
            Navigator.pop(context);
            Navigator.push(context, SlideTransitionPage(page: AppDashboard()));
          },
        ),
      );
    },
  );
}

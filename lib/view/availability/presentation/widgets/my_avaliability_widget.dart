import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:flutter/material.dart';

import '../../../../core/common widgets/reuseable_gradient_button.dart';
import '../../../../core/common widgets/reuseable_gradient_small_button.dart';
import '../../../../core/constants/app_constants.dart';
import '../screens/create_availability_screen.dart';

// ignore: must_be_immutable
class MyAvalabilityWidget extends StatelessWidget {
  bool isAvalable = true;

  MyAvalabilityWidget({
    required this.isAvalable,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            ReuseableGradientSmallButton(
              title: 'Create New',
              onpress: () {
                Navigator.push(context, SlideTransitionPage(page: CreateAvailabilityScreen()));
              },
            ),
          ],
        ),
      ),
      Expanded(
        child: isAvalable
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(9),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: ShapeDecoration(
                            color: AppConstants.kcwhiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            shadows: AppConstants.kShadows),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('From'),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: ShapeDecoration(
                                      color: AppConstants.kcwhiteColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      shadows: AppConstants.kShadows),
                                  child: Text('16 Sep, Wed'),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('To'),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: ShapeDecoration(
                                      color: AppConstants.kcwhiteColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      shadows: AppConstants.kShadows),
                                  child: Text('23 Sep, Wed'),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(9),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Tuesday 17 Sep',
                                      style:
                                          AppConstants.kTextStyleSmallBoldGrey,
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1,
                                    padding: EdgeInsets.all(8),
                                    decoration: ShapeDecoration(
                                      color: AppConstants.kcwhiteColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      shadows: AppConstants.kShadows,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: 3,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                child: RichText(
                                                  textAlign: TextAlign
                                                      .start, // Center-align the text
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      // First segment with one style
                                                      TextSpan(
                                                          text:
                                                              'Shift ', // Add a newline character to move "World!" to the second line
                                                          style: AppConstants
                                                              .kTextStyleMediumBoldGrey),
                                                      TextSpan(
                                                          text:
                                                              '${index + 1}   ', // Add a newline character to move "World!" to the second line
                                                          style: AppConstants
                                                              .kTextStyleMediumBoldGrey),
                                                      TextSpan(
                                                          text:
                                                              '02 : 00 AM', // Add a newline character to move "World!" to the second line
                                                          style: AppConstants
                                                              .kTextStyleMediumBoldBlack),
                                                      TextSpan(
                                                          text:
                                                              ' - ', // Add a newline character to move "World!" to the second line
                                                          style: AppConstants
                                                              .kTextStyleMediumBoldBlack),
                                                      TextSpan(
                                                          text:
                                                              '04 : 00 PM', // Add a newline character to move "World!" to the second line
                                                          style: AppConstants
                                                              .kTextStyleMediumBoldBlack),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                        Divider(),
                                        Row(
                                          children: [
                                            Text(
                                              'Add More Shifts',
                                              style: AppConstants
                                                  .kTextStyleSmallBoldBlack,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Icon(
                                                Icons.post_add_sharp,
                                                color:
                                                    AppConstants.kcprimaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center, // Center-align the text
                      text: TextSpan(
                        children: <TextSpan>[
                          // First segment with one style
                          TextSpan(
                              text:
                                  'You can request your schedule,\nand upon approval,', // Add a newline character to move "World!" to the second line
                              style: AppConstants.kTextStyleMediumBoldGrey),

                          // Second segment with a different style
                          TextSpan(
                              text: 'it will update in the Schedule section.',
                              style: AppConstants.kTextStyleMediumBoldGrey),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ReuseableGradientButton(
                            title: 'Request',
                            onpress: () {
                              Navigator.push(context,
                                  SlideTransitionPage(page: CreateAvailabilityScreen()));
                            }),
                      ],
                    ),
                  ),
                ],
              ),
      )
    ]);
  }
}

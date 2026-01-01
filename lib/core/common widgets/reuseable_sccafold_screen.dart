import 'dart:io';

import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/view/alerts/presentation/screens/all_alerts_screen.dart';
import 'package:divine_employee_app/view/auth/presentation/state/bottom_app_bar_provider.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/job_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReuseableScaffoldScreen extends StatelessWidget {
  final String appBarTitle;
  final bool paddingNotNeed;
  final Widget? circularAvatar;
  final Widget content;
  final Function? onLeadingPressed;
  final bool notification_icon;

  final isThereCircularAvatar;
  final resizeToAvoidBottomInset;

  ReuseableScaffoldScreen({
    required this.appBarTitle,
    this.circularAvatar,
    this.paddingNotNeed = false,
    required this.content,
    this.onLeadingPressed,
    this.isThereCircularAvatar = false,
    this.resizeToAvoidBottomInset = false,
    this.notification_icon =
        true, // Default value is true for scrollable content
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: AppConstants.kcprimaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (onLeadingPressed != null) {
              onLeadingPressed!();
            } else if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
                // If there's no screen behind, you can close the app
              final currentTabProvider =
                  Provider.of<BottomNavigationBarProvider>(context,
                      listen: false);
              if (currentTabProvider.currentTab == 2) {
                showCloseConfirmationDialog(context);
              } else {
                currentTabProvider.setCurrentScreen(JobHomeScreen());
                currentTabProvider.setCurrentTab(2);
              }
            }
          },
          icon: Icon(Icons.arrow_back_ios),
          color: AppConstants.kcwhiteColor,
        ),
        forceMaterialTransparency: true,
        backgroundColor: AppConstants.kcprimaryColor,

        elevation: 0.0,
        title: Text(appBarTitle, style: AppConstants.kTextStyleLargreBoldWhite),
        centerTitle: true,
        actions: <Widget>[
          // if (appOnActionPressed != null)
          if (notification_icon != false)
            IconButton(
              icon: Icon(Icons.notifications_active),
              onPressed: () {
                Navigator.push(
                    context, SlideTransitionPage(page: AllAlertsScreen()));
              },
              color: AppConstants.kcwhiteColor,
            ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          Utils.dismissKeyboard(context);
        },
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 5.5,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                gradient: AppConstants.kgradientScreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (circularAvatar != null) circularAvatar!,
                  ],
                ),
              ),
            ),
            // SizedBox(height: 40.0),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.maxFinite,
                height: isThereCircularAvatar
                    ? MediaQuery.of(context).size.height / 1.3
                    : MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: AppConstants.kcgreyColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(46.0),
                    topRight: Radius.circular(46.0),
                  ),
                ),
                child: Padding(
                    padding: paddingNotNeed == true
                        ? EdgeInsets.symmetric(vertical: 16)
                        : const EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 8),
                    child: content),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  Future<bool?> showCloseConfirmationDialog(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exit'),
          content: Text('Are you sure you want to exist.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User does not want to exit
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: Text('Exit'),
            ),
          ],
        );
      },
    );
  }

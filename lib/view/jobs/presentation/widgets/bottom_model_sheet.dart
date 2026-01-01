import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/all_jobs_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/assigned_jobs_screen.dart';
import '../screens/available_jobs_screen.dart';
import '../screens/completed_jobs_screen.dart';

Future<dynamic> showBottomModalSheetForJobs(BuildContext context) {
  return showModalBottomSheet(
    showDragHandle: true,
    backgroundColor: AppConstants.kcprimaryColor,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: AppConstants.kcwhiteColor,
        // .withOpacity(0.9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: SvgPicture.asset(
                AppConstants.jobcompltedIconPath,
                // ignore: deprecated_member_use
                color: AppConstants.kcprimaryColor,
              ),
              title: Text(
                'All Jobs',
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, SlideTransitionPage(page: AllJobsScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: SvgPicture.asset(
                AppConstants.jobcompltedIconPath,
                // ignore: deprecated_member_use
                color: AppConstants.kcprimaryColor,
              ),
              title: Text(
                'Completed Jobs',
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, SlideTransitionPage(page: CompletedJobsScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: SvgPicture.asset(
                AppConstants.jobavailableIconPath,
                // ignore: deprecated_member_use
                color: AppConstants.kcprimaryColor,
              ),
              title: Text(
                'Available Jobs',
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, SlideTransitionPage(page: AvailableJobScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: SvgPicture.asset(
                AppConstants.jobassignedIconPath,
                // ignore: deprecated_member_use
                color: AppConstants.kcprimaryColor,
              ),
              title: Text('Assigned Jobs'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, SlideTransitionPage(page: AssignedJobScreen()));
              },
            ),
            Divider(),
          ],
        ),
      );
    },
  );
}

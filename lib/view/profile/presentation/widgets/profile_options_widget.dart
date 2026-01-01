import 'package:divine_employee_app/core/utils/routes/routes_name.dart';
import 'package:divine_employee_app/view/profile/delete_employe.dart';
import 'package:divine_employee_app/view/roster/roster_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../api_provider/profile_update_api_provider.dart';
import '../../../../config/routes/page_transition.dart';
import '../../../../core/common widgets/reuseable_gradient_small_button.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../main.dart';
import '../../../../api_provider/session_handling_view_model.dart';
import '../../../availability/presentation/screens/availability_dashboard.dart';
import '../../../documents/presentation/screens/documents_dashboard.dart';
import '../../../earnings/presentation/screens/earnings_dashboard.dart';
import '../../../incidents/presentation/screens/reported_incidents_screen.dart';
import '../../../jobs/presentation/screens/my_jobs_screen.dart';
import '../../../leave_requests/presentation/screens/leave_request_dashboard.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/feedback_screen.dart';

class ProfileOptionsWidget extends StatelessWidget {
  const ProfileOptionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userprefrences = Provider.of<SessionHandlingViewModel>(context);

    return Container(
      margin: EdgeInsets.only(top: 80),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: AppConstants.kcgreyColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(29), topRight: Radius.circular(29))),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 13,
            ),

            ReuseableGradientSmallButton(
              title: 'Edit Profile',
              onpress: () {
                Navigator.push(
                    context, SlideTransitionPage(page: EditProfileScreen()));
              },
            ),

            // options

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          SlideTransitionPage(page: DocumentsDashboard()));
                    },
                    title: Text(
                      'My Documents',
                      style: AppConstants.kTextStyleMediumBoldBlack,
                    ),
                    leading: SvgPicture.asset(AppConstants.documentIconPath),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          SlideTransitionPage(page: EarningsDashboard()));
                    },
                    title: Text(
                      'My Earnings',
                      style: AppConstants.kTextStyleMediumBoldBlack,
                    ),
                    leading: Icon(Icons.wallet_outlined),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          SlideTransitionPage(page: AvailabilityDashboard()));
                    },
                    title: Text(
                      'Avialability',
                      style: AppConstants.kTextStyleMediumBoldBlack,
                    ),
                    leading: Icon(Icons.calendar_today_outlined),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          SlideTransitionPage(page: LeaveRequestsDashboard()));
                    },
                    title: Text(
                      'Leave Request',
                      style: AppConstants.kTextStyleMediumBoldBlack,
                    ),
                    leading: Icon(Icons.edit_document),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    title: Text(
                      'Feed Back',
                      style: AppConstants.kTextStyleMediumBoldBlack,
                    ),
                    leading: Icon(Icons.feedback_outlined),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                          context, SlideTransitionPage(page: FeedBackScreen()));
                    },
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context, SlideTransitionPage(page: MyJobsScreen()));
                    },
                    title: Text(
                      'My Jobs',
                      style: AppConstants.kTextStyleMediumBoldBlack,
                    ),
                    leading: SvgPicture.asset(AppConstants.myjobsIconPath),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    title: Text(
                      'Reported Incidents',
                      style: AppConstants.kTextStyleMediumBoldBlack,
                    ),
                    leading: Icon(Icons.report_gmailerrorred),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(context,
                          SlideTransitionPage(page: ReportedIncidentsScreen()));
                    },
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          SlideTransitionPage(page: RosterDashboard()));
                    },
                    title: Text(
                      'Roster',
                      style: AppConstants.kTextStyleMediumBoldBlack,
                    ),
                    leading: Icon(Icons.schedule),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                   ListTile(
                    onTap: () {
                      Navigator.push(context,
                          SlideTransitionPage(page: DeleteAccountScreen()));
                    },
                    title: Text(
                      'Delete',
                      style: AppConstants.kTextStyleMediumBoldBlack,
                    ),
                    leading: Icon(Icons.delete_outline_outlined),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () async {
                      await ProfileUpdateApiProvider().updateProfilee(Fcm: '');
                      userprefrences.removeUser();
                      navigatorKey.currentState!
                          .popUntil((route) => route.isFirst);
                      Navigator.pushReplacementNamed(context, RoutesName.login);
                    },
                    title: Text(
                      'Logout',
                      style: AppConstants.kTextStyleMediumBoldBlack,
                    ),
                    leading: Icon(Icons.logout_outlined),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

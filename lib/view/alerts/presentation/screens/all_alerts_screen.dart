import 'package:divine_employee_app/api_provider/get_all_notification_provider.dart';
import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/availability/presentation/screens/availability_dashboard.dart';
import 'package:divine_employee_app/view/documents/presentation/screens/documents_dashboard.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/assigned_jobs_screen.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/completed_jobs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../availability/presentation/screens/requested_availbility_details_screen.dart';

class AllAlertsScreen extends StatefulWidget {
  const AllAlertsScreen({Key? key}) : super(key: key);

  @override
  State<AllAlertsScreen> createState() => _AllAlertsScreenState();
}

class _AllAlertsScreenState extends State<AllAlertsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<GetAllNotificationProvider>(context, listen: false)
          .fetchAllNotifications();
    });
  }

  Future<void> _refreshNotifications() async {
    await Provider.of<GetAllNotificationProvider>(context, listen: false)
        .fetchAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
      notification_icon: false,
      appBarTitle: 'Alerts',
      content: Consumer<GetAllNotificationProvider>(
        builder: (BuildContext context,
            GetAllNotificationProvider generalProvider, Widget? child) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: generalProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : generalProvider.notifications.isEmpty
                    ? Center(child: Text('No notifications available.'))
                    : RefreshIndicator(
                        onRefresh: _refreshNotifications,
                        child: ListView.builder(
                          itemCount: generalProvider.notifications.length,
                          itemBuilder: (context, index) {
                            // final notification =
                            //     generalProvider.notifications[index];
                            final reversedIndex =
                                generalProvider.notifications.length -
                                    1 -
                                    index;
                            final notification =
                                generalProvider.notifications[reversedIndex];
                            return InkWell(
                              onTap: () async {
                                getMeToScreen(notification.type);
                                await generalProvider
                                    .updateNotificationStatus(notification.id);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: ShapeDecoration(
                                    color: AppConstants.kcwhiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(notification.title),
                                    subtitle: Text(notification.body),
                                    leading: notification.isRead == false
                                        ? Icon(
                                            Icons.circle,
                                            color: AppConstants.kcprimaryColor,
                                          )
                                        : SizedBox(),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(formatDateTime(
                                            notification.createdAt)),
                                        Text(
                                            formatDate(notification.createdAt)),
                                      ],
                                    ),
                                    titleTextStyle:
                                        AppConstants.kTextStyleMediumBoldBlack,
                                    subtitleTextStyle:
                                        AppConstants.kTextStyleSmallBoldGrey,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          );
        },
      ),
    );
  }

  String formatDate(DateTime date) {
    // Format the date manually (without intl)
    return '${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}';
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  getMeToScreen(String type) {
    if (type == 'availibilty_request') {
    } else if (type == 'incident') {
    } else if (type == 'job_cancel') {
    } else if (type == 'job_submitted') {
    } else if (type == 'job_apply') {
    } else if (type == 'Task_approved') {
      Navigator.push(context, SlideTransitionPage(page: CompletedJobsScreen()));
    } else if (type == 'Task_unapproved') {
      Navigator.push(
          context,
          SlideTransitionPage(
              page: CompletedJobsScreen(
            animateTo: 1,
          )));
    } else if (type == 'Task_employee') {
      Navigator.push(context, SlideTransitionPage(page: AssignedJobScreen()));
    } else if (type == 'leave_status') {
    } else if (type == 'leave_delete') {
    } else if (type == 'availibilty_request_accept') {
      Navigator.push(
          context, SlideTransitionPage(page: AvailabilityDashboard()));
    } else if (type == 'availibilty_request_reject') {
      Navigator.push(
          context, SlideTransitionPage(page: AvailabilityDashboard()));
    } else if (type == 'Documnet_approved') {
      Navigator.push(context, SlideTransitionPage(page: DocumentsDashboard()));
    } else if (type == 'Documnet_rejected') {
      Navigator.push(
          context,
          SlideTransitionPage(
              page: DocumentsDashboard(
            animateTo: 1,
          )));
    } else {}
  }
}

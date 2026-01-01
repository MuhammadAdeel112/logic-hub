import 'package:divine_employee_app/core/common%20widgets/resueable_error_screen.dart';
import 'package:divine_employee_app/core/common%20widgets/resueable_search_widget.dart';
import 'package:divine_employee_app/api_provider/data_provider_for_employee_profile.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/view/availability/presentation/screens/requested_availbility_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../api_provider/search_provider.dart';
import '../../../../config/routes/page_transition.dart';
import '../../../../core/constants/app_constants.dart';
import '../screens/my_job_details_screen.dart';
import '../../../../core/data/response/status.dart';

class MyUnApprovedJobWidget extends StatefulWidget {
  const MyUnApprovedJobWidget({Key? key}) : super(key: key);

  @override
  State<MyUnApprovedJobWidget> createState() => _MyUnApprovedJobWidgetState();
}

class _MyUnApprovedJobWidgetState extends State<MyUnApprovedJobWidget> {
  Future<void> _refreshData() async {
    Provider.of<AssignedJobsProvider>(context, listen: false).clearAssignedJobs();
    Provider.of<AssignedJobsProvider>(context, listen: false).fetchAssignedJobs();
  }

  @override
  Widget build(BuildContext context) {
    final assignedJobsProvider = Provider.of<AssignedJobsProvider>(context);
    final assignedJobs = assignedJobsProvider.assignedJobs?.job;

    final jobSearchProvider = Provider.of<JobSearchProvider>(context);
    final initialJobList = assignedJobs
        ?.where((job) => job.approvalStatus == 'unapproved')
        .toList();

    return Consumer<JobSearchProvider>(
      builder: (context, searchProvider, child) {
        switch (assignedJobsProvider.apiResponse.status) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());

          case Status.COMPLETED:
            if (initialJobList == null || initialJobList.isEmpty) {
              return const ResueAbleErrorScreen(
                errorMsg:
                'No Un-Approved job yet. Once any of your completed jobs get rejected, they will appear here.',
              );
            }

            final filteredJobList = searchProvider.searchQuery.isEmpty
                ? initialJobList.reversed.toList()
                : initialJobList.reversed
                .where((job) => job.title
                .toLowerCase()
                .contains(searchProvider.searchQuery.toLowerCase()))
                .toList();

            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 9.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 58.0),
                        child: ListView.builder(
                          itemCount: filteredJobList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final jobItem = filteredJobList[index];
                            final String jobTitle = jobItem.title;
                            final String date =
                                '${jobItem.startTime.day}/${jobItem.startTime.month}/${jobItem.startTime.year}';

                            // ✅ FIX: use single Client object
                            final String workerName =
                            "${jobItem.client.firstName} ${jobItem.client.lastName}".trim();

                            final String time = formatDateTime(jobItem.startTime);
                            final String totalTasks = jobItem.task.length.toString();
                            final String isPaid = jobItem.approvalStatus;
                            final Duration totalHours =
                            jobItem.endTime.difference(jobItem.startTime);
                            final int totalhours = totalHours.inHours;
                            final int totalminutes = totalHours.inMinutes % 60;

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  SlideTransitionPage(
                                    page: MyJobDetailsScreen(
                                      job: jobItem,
                                      isPaid: isPaid,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  decoration: ShapeDecoration(
                                    color: AppConstants.kcwhiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    shadows: AppConstants.kShadows,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              jobTitle,
                                              style: AppConstants.kTextStyleMediumBoldBlack,
                                            ),
                                            Text(
                                              date,
                                              style: AppConstants.kTextStyleMediumBoldGrey,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              workerName,
                                              style: AppConstants.kTextStyleMediumBoldGrey,
                                            ),
                                            Text(
                                              time,
                                              style: AppConstants.kTextStyleMediumBoldGrey,
                                            ),
                                          ],
                                        ),
                                        const Divider(color: Colors.transparent),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Total Tasks: $totalTasks',
                                              style: AppConstants.kTextStyleSmallBoldBlack,
                                            ),
                                            Text(
                                              'Total Duration: $totalhours:$totalminutes',
                                              style: AppConstants.kTextStyleSmallBoldBlack,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  isPaid == 'approved' ? 'Paid' : 'Un-Paid',
                                                  style: AppConstants.kTextStyleMediumBoldBlack,
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(left: 4.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppConstants.kcprimaryColor,
                                                      borderRadius: BorderRadius.circular(9),
                                                    ),
                                                    padding: const EdgeInsets.all(4),
                                                    child: isPaid == 'approved'
                                                        ? Icon(
                                                      Icons.check_circle,
                                                      size: 15,
                                                      color: AppConstants.kcwhiteColor,
                                                    )
                                                        : Image.asset(
                                                      AppConstants.AlertIconPath,
                                                      height: 15,
                                                      color: AppConstants.kcwhiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );

          case Status.ERROR:
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          assignedJobsProvider.apiResponse.message ?? 'Error',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ReuseableGradientButton(
                          width: MediaQuery.of(context).size.width / 4,
                          title: 'Tap to Refresh',
                          onpress: _refreshData,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );

          default:
            return Container();
        }
      },
    );
  }
}

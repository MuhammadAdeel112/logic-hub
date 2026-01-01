import 'package:divine_employee_app/api_provider/search_provider.dart';
import 'package:divine_employee_app/core/common%20widgets/resueable_error_screen.dart';
import 'package:divine_employee_app/core/common%20widgets/resueable_search_widget.dart';
import 'package:divine_employee_app/api_provider/data_provider_for_employee_profile.dart';
import 'package:divine_employee_app/view/availability/presentation/screens/requested_availbility_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../config/routes/page_transition.dart';
import '../../../../core/common widgets/reuseable_gradient_button.dart';
import '../../../../core/constants/app_constants.dart';
import '../screens/my_job_details_screen.dart';
import '../../../../core/data/response/status.dart';

class MyUnCompletedJobWidget extends StatefulWidget {
  const MyUnCompletedJobWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MyUnCompletedJobWidget> createState() => _MyUnCompletedJobWidgetState();
}

class _MyUnCompletedJobWidgetState extends State<MyUnCompletedJobWidget> {
  Future<void> _refreshData() async {
    Provider.of<AssignedJobsProvider>(context, listen: false)
        .clearAssignedJobs();
    Provider.of<AssignedJobsProvider>(context, listen: false)
        .fetchAssignedJobs();
  }

  @override
  Widget build(BuildContext context) {
    final assignedJobsProvider = Provider.of<AssignedJobsProvider>(context);
    final assignedJobs = assignedJobsProvider.assignedJobs?.job;

    // Get the JobSearchProvider instance
    final jobSearchProvider = Provider.of<JobSearchProvider>(context);
    final initialJobList =
        assignedJobs?.where((job) => job.status == 'pending'&& job.approvalStatus=='pending').toList();

    return Consumer<JobSearchProvider>(
      builder: (context, searchProvider, child) {
        switch (assignedJobsProvider.apiResponse.status) {
          case Status.LOADING:
            return Center(child: CircularProgressIndicator());
          case Status.COMPLETED:
            if (initialJobList == null || initialJobList.isEmpty) {
              return ResueAbleErrorScreen(
                errorMsg: 'No Pending Job',
              );
            }

            // Filter jobs based on search query
            final filteredJobList = searchProvider.searchQuery.isEmpty
                ? initialJobList.reversed.toList()
                : initialJobList
                 .reversed   .where((job) => job.title.toLowerCase().contains(
                          searchProvider.searchQuery.toLowerCase(),
                        ))
                    .toList();

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 9.0,
                  ),
                  child: ResueableSearchWidget(
                    searchController: jobSearchProvider.searchController,
                    onChanged: (query) {
                      jobSearchProvider.updateSearch(query);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 58.0, right: 2),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await _refreshData();
                    },
                    child: ListView.builder(
                      itemCount: filteredJobList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final String jobTitle = filteredJobList[index].title;
                        final String date = filteredJobList[index]
                                .startTime
                                .day
                                .toString() +
                            '/' +
                            filteredJobList[index].startTime.month.toString() +
                            '/' +
                            filteredJobList[index].startTime.year.toString();
                        final String description =
                            filteredJobList[index].description;

                        final String time =
                            formatDateTime(filteredJobList[index].startTime);
                        final String totalTasks =
                            filteredJobList[index].task.length.toString();
                        Duration duration = filteredJobList[index]
                            .endTime
                            .difference(filteredJobList[index].startTime);
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              SlideTransitionPage(
                                page: MyJobDetailsScreen(
                                  job: filteredJobList[index],
                                  isPaid: 'unPaid',
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
                                          style: AppConstants
                                              .kTextStyleMediumBoldBlack,
                                        ),
                                        Text(
                                          date,
                                          style: AppConstants
                                              .kTextStyleSmallRegularBlack,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.9),
                                          child: Text(
                                            description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppConstants
                                                .kTextStyleMediumBoldGrey,
                                          ),
                                        ),
                                        Text(
                                          time,
                                          style: AppConstants
                                              .kTextStyleSmallRegularBlack,
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // SizedBox(),
                                        Text(
                                          'Total Tasks: $totalTasks',
                                          style: AppConstants
                                              .kTextStyleSmallRegularBlack,
                                        ),
                                        Text(
                                          'Total Hours: ${duration.inHours} hr :${duration.inMinutes % 60} min',
                                          style: AppConstants
                                              .kTextStyleSmallRegularBlack,
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
                ),
              ],
            );
          case Status.ERROR:
            return RefreshIndicator(
              onRefresh: () async {
                await _refreshData();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height /
                      1.2, // Adjust the height as needed
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        assignedJobsProvider.apiResponse.message ?? 'Error',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16), // Adjust the spacing as needed
                      ReuseableGradientButton(
                        width: MediaQuery.of(context).size.width / 4,
                        title: 'Tap to Refresh',
                        onpress: () async {
                          await _refreshData();
                        },
                      ),
                    ],
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

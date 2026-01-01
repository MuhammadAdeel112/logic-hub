import 'package:divine_employee_app/api_provider/data_provider_for_employee_profile.dart';
import 'package:divine_employee_app/api_provider/search_provider.dart';
import 'package:divine_employee_app/core/common%20widgets/resueable_error_screen.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/core/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/common widgets/resueable_search_widget.dart';
import '../../../../core/common widgets/reuseable_sccafold_screen.dart';
import '../../../../models/assigned_jobs_model.dart';
import '../../../availability/presentation/screens/requested_availbility_details_screen.dart';
import '../widgets/assigned_job_widget.dart';

class AssignedJobScreen extends StatefulWidget {
  AssignedJobScreen({super.key});

  @override
  State<AssignedJobScreen> createState() => _AssignedJobScreenState();
}

class _AssignedJobScreenState extends State<AssignedJobScreen> {
  Future<void> _refreshData() async {
    Provider.of<AssignedJobsProvider>(context, listen: false).clearAssignedJobs();
    Provider.of<AssignedJobsProvider>(context, listen: false).fetchAssignedJobs();
  }

  @override
  Widget build(BuildContext context) {
    final assignedJobsProvider = Provider.of<AssignedJobsProvider>(context);
    final assignedJobs = assignedJobsProvider.assignedJobs?.job ?? <Job>[];
    final jobSearchProvider = Provider.of<JobSearchProvider>(context);

    return ReuseableScaffoldScreen(
      appBarTitle: 'Assigned Jobs',
      content: Consumer<JobSearchProvider>(
        builder: (context, searchProvider, child) {
          switch (assignedJobsProvider.apiResponse.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());

            case Status.COMPLETED:
              if (assignedJobs.isEmpty) {
                return ResueAbleErrorScreen(
                  errorMsg:
                  'You are not Assigned any job. You will be notified once you are. Thanks',
                );
              }

              final initialJobList =
              assignedJobs.where((job) => job.status == 'pending').toList();

              final filteredJobList = searchProvider.searchQuery.isEmpty
                  ? initialJobList.reversed.toList()
                  : initialJobList.reversed
                  .where((job) => (job.title ?? '')
                  .toLowerCase()
                  .contains(searchProvider.searchQuery.toLowerCase()))
                  .toList();

              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 9.0),
                    child: ResueableSearchWidget(
                      searchController: jobSearchProvider.searchController,
                      onChanged: (query) {
                        jobSearchProvider.updateSearch(query);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: RefreshIndicator(
                      onRefresh: _refreshData,
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredJobList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Job job = filteredJobList[index];

                          // Manager info (list)
                          final managerList = job.manager;
                          final Manager? manager =
                          managerList.isNotEmpty ? managerList.first : null;

                          final String managerName =
                              manager?.name ?? 'No manager available';
                          final String managerPhone =
                              manager?.phone ?? 'No phone available';
                          final String managerId = manager?.id ?? '';

                          // Client info (single object)
                          final Client? client = job.client;

                          final String clientName = ([
                            client?.firstName ?? '',
                            client?.middleName ?? '',
                            client?.lastName ?? ''
                          ].join(' '))
                              .trim()
                              .isNotEmpty
                              ? [
                            client?.firstName ?? '',
                            client?.middleName ?? '',
                            client?.lastName ?? ''
                          ].join(' ').trim()
                              : 'No client available';

                          final String clientNo = client?.mobile ?? '';
                          final String clientId = client?.id ?? '';
                          final String clientImage = client?.profileImage ?? '';

                          final String locationString =
                              job.address?.formattedAddress ?? 'No Address';

                          final DateTime startTime = job.startTime ?? DateTime.now();
                          final DateTime endTime = job.endTime ?? startTime;

                          return AssiginedJobWidget(
                            noOfJobsLenght: filteredJobList.length,
                            title: job.title ?? 'No Title',
                            date: startTime,
                            startTime: formatDateTime(startTime),
                            endTime: formatDateTime(endTime),
                            taskDescription: job.description ?? '',
                            location: locationString,
                            phoneNumber: clientNo,
                            distance: "null",
                            shiftType: job.shift ?? '',
                            allowances: job.allowances ?? 0,
                            tasksForAssignedJobs: job.task ?? <Task>[],
                            tasksForAvailableJobs: [],
                            shiftManagerName: managerName,
                            shiftManagerNo: managerPhone,
                            clientName: clientName,
                            clientNo: clientNo,
                            clientImage: clientImage,
                            clientInfoForAssignedJobs: job,
                            JobId: job.id ?? '',
                            duration: endTime.difference(startTime),
                            clientId: clientId,
                            shiftManagerId: managerId,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );

            case Status.ERROR:
              return RefreshIndicator(
                onRefresh: _refreshData,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.2,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          assignedJobsProvider.apiResponse.message ?? 'Error',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        ReuseableGradientButton(
                          width: MediaQuery.of(context).size.width / 4,
                          title: 'Tap to Refresh',
                          onpress: _refreshData,
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
      ),
    );
  }
}

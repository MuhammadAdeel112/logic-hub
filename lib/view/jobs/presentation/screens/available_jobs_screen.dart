import 'package:divine_employee_app/api_provider/data_provider_for_employee_profile.dart';
import 'package:divine_employee_app/api_provider/search_provider.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common widgets/resueable_search_widget.dart';
import '../../../../core/common widgets/reuseable_sccafold_screen.dart';
import '../../../../core/data/response/status.dart';
import '../widgets/available_job_widget.dart';

class AvailableJobScreen extends StatefulWidget {
  AvailableJobScreen({super.key});

  @override
  State<AvailableJobScreen> createState() => _AvailableJobScreenState();
}

class _AvailableJobScreenState extends State<AvailableJobScreen> {
  Future<void> _refreshData() async {
    Provider.of<AvailableJobsProvider>(context, listen: false)
        .clearAvailableJobs();
    Provider.of<AvailableJobsProvider>(context, listen: false)
        .fetchAvailableJobs();
  }

  @override
  Widget build(BuildContext context) {
    final assignedJobsProvider = Provider.of<AvailableJobsProvider>(context);
    final assignedJobs = assignedJobsProvider.availableJobs?.jobs;

    // Get the JobSearchProvider instance
    final jobSearchProvider = Provider.of<JobSearchProvider>(context);

    return ReuseableScaffoldScreen(
      appBarTitle: 'Avialable Jobs',
      content: Consumer<JobSearchProvider>(
        builder: (context, searchProvider, child) {
          // Check the API response state
          switch (assignedJobsProvider.apiResponse.status) {
            case Status.LOADING:
              return Center(
                  child: CircularProgressIndicator()); // or a loading widget
            case Status.COMPLETED:
              if (assignedJobs == null || assignedJobs.isEmpty) {
                return Center(
                  child: Text(
                    'There are currently no jobs ',
                  ),
                );
              }

              final filteredJobList = searchProvider.searchQuery.isEmpty
                  ? assignedJobs.reversed.toList()
                  : assignedJobs.reversed
                      .where((job) => job.title.toLowerCase().contains(
                            searchProvider.searchQuery.toLowerCase(),
                          ))
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
                      onRefresh: () async {
                        await _refreshData();
                      },
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredJobList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AvailableJobWidget(
                            jobData: filteredJobList[index],
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
              return Container(); // You can return an empty container or a default widget here
          }
        },
      ),
    );
  }
}

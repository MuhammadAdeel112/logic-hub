import 'package:card_swiper/card_swiper.dart';
import 'package:divine_employee_app/api_provider/profile_update_api_provider.dart';
import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/view/auth/presentation/screens/profile_under_review.dart';
import 'package:divine_employee_app/view/auth/presentation/screens/session_expire_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:divine_employee_app/core/common widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/data/response/status.dart';
import 'package:divine_employee_app/view/jobs/presentation/widgets/available_job_widget.dart';
import '../../../../api_provider/data_provider_for_employee_profile.dart';
import '../../../../core/common widgets/reuseable_shimmer_loading.dart';
import '../../../../models/assigned_jobs_model.dart';
import '../../../availability/presentation/screens/requested_availbility_details_screen.dart';
import '../widgets/assigned_job_widget.dart';
import '../widgets/total_hours_widget.dart';

class JobHomeScreen extends StatefulWidget {
  const JobHomeScreen({super.key});

  @override
  State<JobHomeScreen> createState() => _JobHomeScreenState();
}

class _JobHomeScreenState extends State<JobHomeScreen> {
  late AvailableJobsProvider _availableJobsProvider;
  late AssignedJobsProvider _assignedJobsProvider;
  late DataProviderForEmployeeProfile _dataProviderForEmployeeProfile;

  @override
  void initState() {
    super.initState();
    _dataProviderForEmployeeProfile =
        Provider.of<DataProviderForEmployeeProfile>(context, listen: false);
    _assignedJobsProvider =
        Provider.of<AssignedJobsProvider>(context, listen: false);
    _availableJobsProvider =
        Provider.of<AvailableJobsProvider>(context, listen: false);

    Future.delayed(Duration.zero, () {
      _dataProviderForEmployeeProfile.fetchEmployeeProfile();
      _assignedJobsProvider.fetchAssignedJobs();
      _availableJobsProvider.fetchAvailableJobs();
    });
  }

  checksession() async {
    final employee = _dataProviderForEmployeeProfile.employeeProfile?.employee;
    if (employee == null) return;

    if (employee.isNew == true) {
      await ProfileUpdateApiProvider().updateProfilee(Fcm: '');
      Navigator.pushReplacement(
          context, SlideTransitionPage(page: ProfileUnderReviewScreen()));
    } else if (employee.isDelete == true) {
      await ProfileUpdateApiProvider().updateProfilee(Fcm: '');
      await SessionHandlingViewModel().removeUser();
      Navigator.pushReplacement(
          context, SlideTransitionPage(page: SessionExpireScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double containerHeight = screenSize.height * 0.30;
    final double containerWidth = screenSize.width * 0.90;

    return ReuseableScaffoldScreen(
      paddingNotNeed: true,
      appBarTitle: 'Divine Care',
      content: RefreshIndicator(
        onRefresh: () async {
          _dataProviderForEmployeeProfile.clearEmployeeProfile();
          _assignedJobsProvider.clearAssignedJobs();
          _availableJobsProvider.clearAvailableJobs();
          _dataProviderForEmployeeProfile.fetchEmployeeProfile();
          _assignedJobsProvider.fetchAssignedJobs();
          _availableJobsProvider.fetchAvailableJobs();
        },
        child: ListView(
          children: [
            // ---------------- Employee Hours ----------------
            ChangeNotifierProvider.value(
              value: _dataProviderForEmployeeProfile,
              child: Consumer<DataProviderForEmployeeProfile>(
                builder: (context, employeeProfileProvider, child) {
                  switch (employeeProfileProvider.apiResponse.status) {
                    case Status.LOADING:
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ReuseAbleShimmerLoading(),
                        ),
                      );
                    case Status.ERROR:
                      return SizedBox(
                        height: screenSize.height / 2.5,
                        child: Center(
                          child: Text(employeeProfileProvider.apiResponse.message ?? 'Error'),
                        ),
                      );
                    case Status.COMPLETED:
                      Future.microtask(() => checksession());
                      final employee = employeeProfileProvider.employeeProfile?.employee;
                      if (employee == null) return Container();
                      double ratio = employee.currentworkinghours / employee.allowedworkinghours;
                      double remaining = double.parse((employee.allowedworkinghours - employee.currentworkinghours).toStringAsFixed(2));

                      return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                        child: TotalHoursWidget(
                          containerHeight: containerHeight,
                          containerWidth: containerWidth,
                          progress: ratio,
                          totalHr: employee.allowedworkinghours,
                          remainingHr: remaining,
                          completedHr: employee.currentworkinghours,
                        ),
                      );

                    default:
                      return Container();
                  }
                },
              ),
            ),

            // ---------------- Assigned Jobs ----------------
            ChangeNotifierProvider.value(
              value: _assignedJobsProvider,
              child: Consumer<AssignedJobsProvider>(
                builder: (context, jobsProvider, child) {
                  switch (jobsProvider.apiResponse.status) {
                    case Status.LOADING:
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ReuseAbleShimmerLoading(),
                        ),
                      );
                    case Status.ERROR:
                      return Container();
                    case Status.COMPLETED:
                      final filteredJobs = jobsProvider.assignedJobs?.job
                          .where((job) => job.status == 'pending')
                          .toList() ?? [];
                      if (filteredJobs.isEmpty) {
                        return _emptyBox(containerHeight, containerWidth, "No Assigned Jobs");
                      }

                      return SizedBox(
                        height: containerHeight,
                        child: Swiper(
                          viewportFraction: 0.85,
                          scale: 0.9,
                          itemCount: filteredJobs.length,
                          itemBuilder: (context, index) {
                            final job = filteredJobs[index];
                            return Column(
                              children: [
                                Text("Assigned Jobs", style: AppConstants.kTextStyleMediumBoldBlack),
                                _buildAssignedJobWidget(job),
                              ],
                            );
                          },
                        ),
                      );

                    default:
                      return Container();
                  }
                },
              ),
            ),

            const SizedBox(height: 16),

            // ---------------- Available Jobs ----------------
            ChangeNotifierProvider.value(
              value: _availableJobsProvider,
              child: Consumer<AvailableJobsProvider>(
                builder: (context, jobsProvider, child) {
                  switch (jobsProvider.apiResponse.status) {
                    case Status.LOADING:
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ReuseAbleShimmerLoading(),
                        ),
                      );
                    case Status.ERROR:
                      return Container();
                    case Status.COMPLETED:
                      final availableJobs = jobsProvider.availableJobs?.jobs ?? [];
                      if (availableJobs.isEmpty) {
                        return _emptyBox(containerHeight, containerWidth, "No Available Jobs");
                      }

                      return SizedBox(
                        height: containerHeight,
                        child: Swiper(
                          viewportFraction: 0.85,
                          scale: 0.9,
                          itemCount: availableJobs.length,
                          itemBuilder: (context, index) {
                            final job = availableJobs[index];
                            return Column(
                              children: [
                                Text("Available Jobs", style: AppConstants.kTextStyleMediumBoldBlack),
                                AvailableJobWidget(jobData: job),
                              ],
                            );
                          },
                        ),
                      );

                    default:
                      return Container();
                  }
                },
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ---------------- Empty Box ----------------
  Widget _emptyBox(double h, double w, String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      height: h,
      width: w,
      decoration: ShapeDecoration(
        color: AppConstants.kcwhiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadows: AppConstants.kShadows,
      ),
      child: Center(
        child: Text(title, style: AppConstants.kTextStyleMediumBoldGrey),
      ),
    );
  }

  // ---------------- Assigned Job Widget ----------------
  Widget _buildAssignedJobWidget(Job job) {
    final client = job.client; // ✅ single object now

    return AssiginedJobWidget(
      noOfJobsLenght: 1,
      title: job.title,
      date: job.startTime,
      startTime: formatDateTime(job.startTime),
      endTime: formatDateTime(job.endTime),
      taskDescription: job.description,
      location: job.address.formattedAddress,
      phoneNumber: client.mobile,
      distance: "null",
      shiftType: job.shift,
      allowances: job.allowances,
      shiftManagerName: job.manager.isNotEmpty ? job.manager[0].name : "",
      shiftManagerNo: job.manager.isNotEmpty ? job.manager[0].phone : "",
      clientName: "${client.firstName} ${client.lastName}".trim(),
      clientNo: client.mobile,
      clientImage: client.profileImage,
      clientInfoForAssignedJobs: job,
      tasksForAssignedJobs: job.task,
      tasksForAvailableJobs: [],
      JobId: job.id,
      duration: job.endTime.difference(job.startTime),
      clientId: client.id,
      shiftManagerId: job.manager.isNotEmpty ? job.manager[0].id : "",
    );
  }
}

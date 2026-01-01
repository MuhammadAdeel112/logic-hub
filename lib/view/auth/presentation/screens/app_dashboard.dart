import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/chats/presentation/screens/chat_dashboard.dart';
import 'package:divine_employee_app/view/incidents/presentation/screens/generate_incident_without_current_job_screen.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/job_home_screen.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/completed_jobs_screen.dart';
import 'package:divine_employee_app/view/jobs/presentation/widgets/bottom_model_sheet.dart';
import 'package:divine_employee_app/view/profile/presentation/screens/profile_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../state/bottom_app_bar_provider.dart';

class AppDashboard extends StatefulWidget {
  const AppDashboard({super.key});

  @override
  State<AppDashboard> createState() => _AppDashboardState();
}

class _AppDashboardState extends State<AppDashboard> {
  final List<Widget> screens = [
    CompletedJobsScreen(),
    GenerateIncidentWithoutCurrentJobScreen(),
    JobHomeScreen(),
    ChatDashboard(),
    ProfileDasboard(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = JobHomeScreen();

  @override
  Widget build(BuildContext context) {
    final currentTabProvider =
        Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      //  floatingActionButtonMargin: EdgeInsets.only(bottom: 60.0), // Adjust the margin as needed

      resizeToAvoidBottomInset: false,
      body: PageStorage(
        bucket: bucket,
        child: currentTabProvider.currentScreen,
      ),

      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 0), // Adjust the margin as needed
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  // width: 8,
                  width: MediaQuery.of(context).size.width / 50,
                  color: AppConstants.kcwhiteColor),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Container(
            decoration: ShapeDecoration(
              color: AppConstants.kcprimaryColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: MediaQuery.of(context).size.width / 50,
                    color: AppConstants.kcbluebgColorr),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: FloatingActionButton(
              backgroundColor: AppConstants.kcsecondaryColor,
              foregroundColor: AppConstants.kcwhiteColor,
              child: Icon(Icons.dashboard),
              onPressed: () {
                currentTabProvider.setCurrentScreen(JobHomeScreen());
                currentTabProvider.setCurrentTab(2);
              },
              shape: CircleBorder(),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height / 12.5,
        color: AppConstants.kcprimaryColor,
        // shape: CircularNotchedRectangle(),
        // notchMargin: 5,
        child: Container(
          // height: 770,
          // color: Colors.red,
          // width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    // minWidth: 40,

                    minWidth: MediaQuery.of(context).size.width / 7,
                    onPressed: () {
                      showBottomModalSheetForJobs(context);
                      currentTabProvider.setCurrentTab(0);
                    },
                    child: FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppConstants.jobIconPath,
                            // ignore: deprecated_member_use
                            color: currentTabProvider.currentTab == 0
                                ? AppConstants.kcsecondaryColor
                                : AppConstants.kcwhiteColor,
                          ),
                          Text(
                            'Jobs',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Actor',
                              fontWeight: FontWeight.w400,
                              color: currentTabProvider.currentTab == 0
                                  ? AppConstants.kcsecondaryColor
                                  : AppConstants.kcwhiteColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    // minWidth: 40,
                    minWidth: MediaQuery.of(context).size.width / 7,

                    onPressed: () {
                      currentTabProvider.setCurrentScreen(
                          GenerateIncidentWithoutCurrentJobScreen());
                      currentTabProvider.setCurrentTab(1);
                    },
                    child: FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.assignment_add,
                            color: currentTabProvider.currentTab == 1
                                ? AppConstants.kcsecondaryColor
                                : AppConstants.kcwhiteColor,
                          ),
                          // SvgPicture.asset(
                          //   AppConstants.chatIconPath,
                          //   color: currentTab == 1
                          //       ? AppConstants.kcsecondaryColor
                          //       : AppConstants.kcwhiteColor,
                          // ),
                          Text(
                            'Incidents',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Actor',
                              fontWeight: FontWeight.w400,
                              color: currentTabProvider.currentTab == 1
                                  ? AppConstants.kcsecondaryColor
                                  : AppConstants.kcwhiteColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    // minWidth: 40,
                    minWidth: MediaQuery.of(context).size.width / 7,

                    onPressed: () {
                      currentTabProvider.setCurrentScreen(ChatDashboard());
                      currentTabProvider.setCurrentTab(3);
                    },
                    child: FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppConstants.chatIconPath,
                            // ignore: deprecated_member_use
                            color: currentTabProvider.currentTab == 3
                                ? AppConstants.kcsecondaryColor
                                : AppConstants.kcwhiteColor,
                          ),
                          Text(
                            'Chat',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Actor',
                              fontWeight: FontWeight.w400,
                              color: currentTabProvider.currentTab == 3
                                  ? AppConstants.kcsecondaryColor
                                  : AppConstants.kcwhiteColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    // minWidth: 40,
                    minWidth: MediaQuery.of(context).size.width / 7,
                    onPressed: () {
                      currentTabProvider.setCurrentScreen(ProfileDasboard());
                      currentTabProvider.setCurrentTab(4);
                    },
                    child: FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppConstants.profileIconPath,
                            // ignore: deprecated_member_use
                            color: currentTabProvider.currentTab == 4
                                ? AppConstants.kcsecondaryColor
                                : AppConstants.kcwhiteColor,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Actor',
                              fontWeight: FontWeight.w400,
                              color: currentTabProvider.currentTab == 4
                                  ? AppConstants.kcsecondaryColor
                                  : AppConstants.kcwhiteColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

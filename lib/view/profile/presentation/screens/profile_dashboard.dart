import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/auth/presentation/state/bottom_app_bar_provider.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/job_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/profile_options_widget.dart';
import '../widgets/profile_picture_widget.dart';

class ProfileDasboard extends StatelessWidget {
  const ProfileDasboard({super.key});

  @override
  Widget build(BuildContext context) {
    // final employeeProfile =
    //     Provider.of<DataProviderForEmployeeProfile>(context).employeeProfile;
    // final imageLink = employeeProfile?.employee.imageUrl;
    return Scaffold(
      backgroundColor: AppConstants.kcprimaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              final currentTabProvider =
                  Provider.of<BottomNavigationBarProvider>(context,
                      listen: false);
              currentTabProvider.setCurrentScreen(JobHomeScreen());
              currentTabProvider.setCurrentTab(2);
            }
          },
          icon: Icon(Icons.arrow_back_ios),
          color: AppConstants.kcwhiteColor,
        ),
        forceMaterialTransparency: true,
        // backgroundColor: AppConstants.kcprimaryColor,

        elevation: 0.0,
        title: Text('Profile', style: AppConstants.kTextStyleLargreBoldWhite),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 6,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: AppConstants.kgradientScreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          ProfileOptionsWidget(),
          ProfilePictureWidget(),
        ],
      ),
    );
  }
}

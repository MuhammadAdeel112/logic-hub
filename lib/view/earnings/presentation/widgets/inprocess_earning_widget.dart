import 'package:divine_employee_app/api_provider/data_provider_for_employee_profile.dart';
import 'package:divine_employee_app/core/common%20widgets/resueable_error_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InProcessEarningWidget extends StatelessWidget {
  // var earnings;
  // var available_hours;
  // var allowed_hours;
  // var duration;
  InProcessEarningWidget({
    // required this.earnings,
    // required this.available_hours,
    // required this.allowed_hours,
    // required this.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final earningsProvider =
        Provider.of<DataProviderForEmployeeProfile>(context, listen: false);
    final employeeProfile = earningsProvider.employeeProfile;

    if (employeeProfile == null) {
      // Handle the case where employeeProfile is null
      // You may want to return a loading indicator or display an error message
      return ResueAbleErrorScreen(errorMsg: 'No Data Available',);
    }

    final earnings = employeeProfile.employee.totalPayment;
    final duration = employeeProfile.employee.totalPayment;
    final allowed_hours = employeeProfile.employee.allowedworkinghours;
    final available_hours = employeeProfile.employee.allowedworkinghours -
        employeeProfile.employee.currentworkinghours;

    return Column(
      children: [
        Text(
          duration.toString(),
          style: AppConstants.kTextStyleMediumBoldGrey,
        ),
        Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: ShapeDecoration(
                    color: AppConstants.kcwhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: AppConstants.kShadows),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Earnings'),
                      subtitle: Text('\$$earnings'),
                      leading: Container(
                          decoration: ShapeDecoration(
                            // color: Colors.amber,
                            gradient: AppConstants.kgradientScreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.attach_money_sharp,
                              color: AppConstants.kcwhiteColor,
                            ),
                          )),
                      titleTextStyle: AppConstants.kTextStyleMediumBoldBlack,
                      subtitleTextStyle: AppConstants.kTextStyleSmallBoldBlack,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.0), // Adjust the indent as needed
                      child: Divider(
                        color: Colors.grey, // Customize the divider color
                      ),
                    ),
                    ListTile(
                      title: Text('Available Hours'),
                      subtitle: Text('$available_hours'),
                      leading: Container(
                          decoration: ShapeDecoration(
                            // color: Colors.amber,
                            gradient: AppConstants.kgradientScreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.access_time,
                              color: AppConstants.kcwhiteColor,
                            ),
                          )),
                      titleTextStyle: AppConstants.kTextStyleMediumBoldBlack,
                      subtitleTextStyle: AppConstants.kTextStyleSmallBoldBlack,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.0), // Adjust the indent as needed
                      child: Divider(
                        color: Colors.grey, // Customize the divider color
                      ),
                    ),
                    ListTile(
                      title: Text('Allowed Hours'),
                      subtitle: Text('$allowed_hours'),
                      leading: Container(
                          decoration: ShapeDecoration(
                            // color: Colors.amber,
                            gradient: AppConstants.kgradientScreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.event_note_outlined,
                              color: AppConstants.kcwhiteColor,
                            ),
                          )),
                      titleTextStyle: AppConstants.kTextStyleMediumBoldBlack,
                      subtitleTextStyle: AppConstants.kTextStyleSmallBoldBlack,
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

// ignore_for_file: unused_local_variable

import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/utils/routes/routes_name.dart';
import 'package:divine_employee_app/view/auth/presentation/screens/app_dashboard.dart';
import 'package:divine_employee_app/view/auth/presentation/screens/login_screen.dart';
import 'package:divine_employee_app/view/auth/presentation/screens/splash_screen.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/during_job_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RoutesName.splash:
        return SlideTransitionPage(page: SplashScreen());
      case RoutesName.login:
        return SlideTransitionPage(page: LoginScreen());
      case RoutesName.app_dashboard:
        return SlideTransitionPage(page: AppDashboard());
      case RoutesName.during_job_screen:
        return SlideTransitionPage(page: DuringJobScreen());
      default:
        return MaterialPageRoute(builder: (BuildContext) {
          return ReuseableScaffoldScreen(
              appBarTitle: 'Error',
              content: Center(
                child: Text('No Page Route Defined'),
              ));
        });
    }
  }
}

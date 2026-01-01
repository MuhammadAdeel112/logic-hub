import 'package:divine_employee_app/core/utils/routes/routes_name.dart';
import 'package:divine_employee_app/models/session_handling_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api_provider/session_handling_view_model.dart';

class SplashServices {
  Future<SessionHandlingModel> getUserDate() =>
      SessionHandlingViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? jobid = sp.getString('currentJobId');
    getUserDate().then((value) async {
      if (kDebugMode) {
        print(':::Token: ' + value.token.toString());
      }

      if (value.token.toString() == 'null' || value.token.toString() == '') {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        await Future.delayed(Duration(seconds: 3));
        if (jobid == null || jobid == '') {
          Navigator.pushReplacementNamed(context, RoutesName.app_dashboard);
        } else {
          Navigator.pushReplacementNamed(context, RoutesName.during_job_screen);
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

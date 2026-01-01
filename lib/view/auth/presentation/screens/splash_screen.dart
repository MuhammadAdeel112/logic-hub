import 'package:divine_employee_app/api_provider/notification_services.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../state/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    notificationServices.requestNotificationPermission();
    notificationServices
        .getDeviceToken()
        .then((value) => { if(kDebugMode)print('::: device FCM token: $value')});
    notificationServices.setupInteractMessage(context);
    notificationServices.firebaseInit(context);
    super.initState();
    splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.6, // Adjust as needed
          heightFactor: 0.6, // Adjust as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppConstants.appLogoBgPath,
                fit: BoxFit.contain,
              ),
              // Add other splash screen content here
            ],
          ),
        ),
      ),
    );
  }
}

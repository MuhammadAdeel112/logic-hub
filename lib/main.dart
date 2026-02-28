import 'dart:io';

import 'package:divine_employee_app/api_provider/claim_extra_api_provider.dart';
import 'package:divine_employee_app/api_provider/fetch_all_chats_api_provider.dart';
import 'package:divine_employee_app/api_provider/get_all_notification_provider.dart';
import 'package:divine_employee_app/api_provider/get_invoices_api_provider.dart';
import 'package:divine_employee_app/api_provider/job_application_provider.dart';
import 'package:divine_employee_app/api_provider/job_update_provider.dart';
import 'package:divine_employee_app/api_provider/registration_api_provider.dart';
import 'package:divine_employee_app/api_provider/search_provider.dart';
import 'package:divine_employee_app/api_provider/upload_doc_api_provider.dart';
import 'package:divine_employee_app/core/utils/routes/routes.dart';
import 'package:divine_employee_app/core/utils/routes/routes_name.dart';
import 'package:divine_employee_app/api_provider/availability_api_provider.dart';
import 'package:divine_employee_app/api_provider/clock_in_api_provider.dart';
import 'package:divine_employee_app/api_provider/data_provider_for_employee_profile.dart';
import 'package:divine_employee_app/api_provider/job_cancelation_request_provider.dart';
import 'package:divine_employee_app/api_provider/job_provider.dart';
import 'package:divine_employee_app/api_provider/profile_update_api_provider.dart';
import 'package:divine_employee_app/api_provider/task_update_api_provider.dart';
import 'package:divine_employee_app/firebase_options.dart';
import 'package:divine_employee_app/view/availability/presentation/provider/avilability_notifier.dart';
import 'package:divine_employee_app/view/chats/presentation/provider/chat_state.dart';
import 'package:divine_employee_app/view/incidents/presentation/provider/select_date_time_provider_for_incident.dart';
import 'package:divine_employee_app/view/jobs/presentation/provider/assigned_task_provider.dart';
import 'package:divine_employee_app/view/jobs/presentation/provider/timer_model.dart';
import 'package:divine_employee_app/view/leave_requests/presentation/provider/date_range_provider.dart';
import 'package:divine_employee_app/view/leave_requests/presentation/provider/select_leave_type_provider.dart';
import 'package:divine_employee_app/api_provider/auth_viewmodel.dart';
import 'package:divine_employee_app/view/profile/provider/edit_image_provider.dart';
import 'package:divine_employee_app/view/registration/state/dob_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'view/auth/presentation/state/bottom_app_bar_provider.dart';
import 'api_provider/clock_out_api_provider.dart';
import 'api_provider/feed_back_api_provider.dart';
import 'api_provider/get_incident_provider.dart';
import 'api_provider/incident_report_provider.dart';
import 'api_provider/leave_request_provider.dart';
import 'view/availability/presentation/provider/create_availability_provider_for_local.dart';
import 'view/documents/presentation/provider/expiry_date_provider.dart';
import 'api_provider/session_handling_view_model.dart';
import 'view/documents/presentation/screens/upload_file_screen.dart';
import 'view/incidents/presentation/provider/select_incident_provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  if (Platform.isAndroid) {
    print("Running on Android");
  } else if (Platform.isIOS) {
    print("Running on iOS");
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // TimerModel timerModel = TimerModel();
  // await timerModel.loadTimerState();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateAvailabilityProviderForLocal(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExpiryDateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectLeaveTypeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => JobProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SessionHandlingViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => LeaveRequestProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => JobCancelationRequestProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => selectDateTimeForIncidentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => IncidentReportProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClockInApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClockOutApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AssignedJobTaskProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TaskUpdateApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedbackApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedbackApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetIncidentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataProviderForEmployeeProfile(),
        ),
        ChangeNotifierProvider(
          create: (context) => AssignedJobsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AvailableJobsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AvailabilityApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileUpdateApiProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => TimerModel(),
        // ),
        ChangeNotifierProvider(
          create: (context) => DocumentSearchProvider([]),
        ),
        ChangeNotifierProvider(
          create: (context) => JobSearchProvider(
              initialList: [], searchController: TextEditingController()),
        ),
        ChangeNotifierProvider(
          create: (context) => JobApplicationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileImageProviderClass(),
        ),
        ChangeNotifierProvider(
          create: (context) => IncidentImageProviderClass(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClaimExtraApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClaimExtraImageProviderClass(),
        ),
        ChangeNotifierProvider(
          create: (context) => UploadDocumentApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectedPDFPath(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectIncidentTypeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ActionTakenByStaffProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AvailabilityNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetAllNotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatState(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllChatsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetInvoiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WorkProvider()..loadFromSharedPreferences(),
        ),
        ChangeNotifierProvider(
          create: (context) => UpdateJobApiProvider(),
        ),
        ChangeNotifierProvider(create: (context) => RegistrationApiProvider()),
        ChangeNotifierProvider(create: (context) => UserDateOfBirth()),
        ChangeNotifierProvider(create: (context) => DateRangeProvider()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Divine Support',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppConstants.kcprimaryColor,
          ),
          useMaterial3: true,
          primarySwatch: AppConstants.kcMaterialColor,
          timePickerTheme: TimePickerThemeData(
            backgroundColor: Colors.white,
            entryModeIconColor: Colors.black,
            dialHandColor: AppConstants.kcprimaryColor,
            // dayPeriodColor: AppConstantsColor.kcprimaryColor
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppConstants.kcMaterialColor, // Set the cursor color
            selectionColor: AppConstants.kcprimaryColor
                .withOpacity(0.5), // Set the text selection color
            selectionHandleColor: AppConstants
                .kcMaterialColor, // Set the text selection handle color
          ),
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
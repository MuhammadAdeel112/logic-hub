import 'package:flutter/material.dart';

class AppConstants {
  static final appLogoBgPath = 'assets/icons/app_logo_bg.png';
  static final chatIconPath = 'assets/svg/chat.svg';
  static final CancelIconPath = 'assets/svg/cancel.svg';
  static final profileIconPath = 'assets/svg/profile.svg';
  static final jobIconPath = 'assets/svg/jobs.svg';
  static final jobcompltedIconPath = 'assets/svg/completed_jobs.svg';
  static final jobassignedIconPath = 'assets/svg/assigned_jobs.svg';
  static final jobavailableIconPath = 'assets/svg/available_jobs.svg';
  static final distanceIconPath = 'assets/svg/distance.svg';
  static final clockIconPath = 'assets/svg/clock.svg';
  static final documentIconPath = 'assets/svg/document.svg';
  static final myjobsIconPath = 'assets/svg/my_jobs.svg';
  static final PaymentPendingIconPath = 'assets/svg/payment_pending.svg';
  static final AlertIconPath = 'assets/icons/alert.png';
  static final userIconPath = 'assets/icons/user.png';

  static final LaodingAnimationPath = 'assets/animations/loading.json';

  static final kcMaterialColor = Colors.green;
  static final Color kcprimaryColor = Color(0xFF197699);
  static final Color kcsecondaryColor = Color(0xFF78BE25);
  static final Color kcgreyColor = Color(0xFFE4E4E4);
  static final Color kcwhiteColor = Color(0xFFFFFFFF);
  static final Color kcredbgColor = Color(0xFFE9B6B6);
  static final Color kcgreenbgColor = Color(0xFFD3F3C6);
  static final Color kcbluebgColorr = Color(0xFFA8C0FF);
  static final Color kcblackColor = Color.fromARGB(255, 0, 0, 0);

  static ShapeDecoration KContainerStyleForTextFormField = ShapeDecoration(
    color: Colors.white, // Use your desired color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    shadows: kShadows,
  );

  static final kgradientScreen = LinearGradient(
    begin: Alignment(-0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFF197699), Color(0xFF71B340)],
  );

  static final kgradientButton = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [Color(0xFF197699), Color(0xFF71B340)],
  );
  static const double smallFontSize = 12.0;
  static const double mediumFontSize = 14.0;
  static const double largeFontSize = 18.0;
  static const double extraLargeFontSize = 24.0;

  static const TextStyle kTextAppBar = TextStyle(
    color: Colors.white,
    fontSize: largeFontSize,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headlineTextStyleBlack = TextStyle(
    color: Colors.black,
    fontSize: extraLargeFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle kTextStyleLargreBoldWhite = TextStyle(
    color: Colors.white,
    fontSize: largeFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle kTextStyleLargreBoldblack = TextStyle(
    color: Colors.black,
    fontSize: largeFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle kTextStyleMediumBoldGrey = TextStyle(
    color: Colors.black,
    fontSize: mediumFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle kTextStyleMediumRegularGrey = TextStyle(
    color: Colors.black,
    fontSize: mediumFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );
  static const TextStyle kTextStyleMediumRegularWhite = TextStyle(
    color: Colors.white,
    fontSize: mediumFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle kTextStyleMediumRegularBlack = TextStyle(
    color: Colors.black,
    fontSize: mediumFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle kTextStyleSmallBoldGrey = TextStyle(
    color: Colors.black,
    fontSize: smallFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle kTextStyleSmallBoldRed = TextStyle(
    color: Color(0xFFDC1414),
    fontSize: smallFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle kTextStyleSmallBoldGreen = TextStyle(
    color: Color(0xFF30AF22),
    fontSize: smallFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );
  static const TextStyle kTextStyleSmallBoldprimary = TextStyle(
    color: Color(0xFF197699),
    fontSize: smallFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle kTextStyleMediumBoldBlack = TextStyle(
    color: Colors.black,
    fontSize: mediumFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );
  static TextStyle kTextStyleMediumBoldPrimary = TextStyle(
    color: AppConstants.kcprimaryColor,
    fontSize: mediumFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle kTextStyleMediumBoldWhite = TextStyle(
    color: Colors.white,
    fontSize: mediumFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle kTextStyleSmallBoldBlack = TextStyle(
    color: Colors.black,
    fontSize: smallFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle kTextStyleSmallRegularBlackoverflowcontrol = TextStyle(
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
    fontSize: smallFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle kTextStyleSmallRegularBlack = TextStyle(
    color: Colors.black,
    fontSize: smallFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle ktextDropDownStyle = TextStyle(
    color: Color(0xFF333333),
    fontSize: mediumFontSize,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle kTextStyleSmallRegularBlackDecription = TextStyle(
    overflow: TextOverflow.ellipsis,
    color: Colors.black,
    fontSize: smallFontSize,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle kTextStyleSmallRegularBlackTaskDescription = TextStyle(
    color: Color(0xFF4D4D4D),
    fontSize: smallFontSize,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    height: 1.60,
    letterSpacing: 0.20,
  );

  static List<BoxShadow> kShadows = [
    BoxShadow(
      color: Color(0x3F000000),
      blurRadius: 4,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
  ];
}

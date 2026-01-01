import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ReuseAbleLoadingAnimationWidget extends StatelessWidget {
  const ReuseAbleLoadingAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset(
        AppConstants.LaodingAnimationPath,
        fit: BoxFit.contain,
        width: 100,
      ),
    );
  }
}

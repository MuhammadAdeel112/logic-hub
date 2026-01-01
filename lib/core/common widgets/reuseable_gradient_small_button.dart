
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ReuseableGradientSmallButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  const ReuseableGradientSmallButton({
    required this.title,
    required this.onpress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 3 ),
        // width: MediaQuery.of(context).size.width / 4,
        // height: MediaQuery.of(context).size.height / 17,
        decoration: ShapeDecoration(
            gradient: AppConstants.kgradientButton,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            shadows: AppConstants.kShadows),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: AppConstants.kTextStyleMediumBoldWhite,
          ),
        )),
      ),
    );
  }
}

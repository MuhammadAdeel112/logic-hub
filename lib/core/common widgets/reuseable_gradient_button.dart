import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ReuseableGradientButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  
  final width;

  ReuseableGradientButton({
    super.key,
    required this.title,
    required this.onpress,
     this.width
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        width:width,
        height: MediaQuery.of(context).size.height / 17,
        decoration: ShapeDecoration(
          shadows: AppConstants.kShadows,
          gradient: AppConstants.kgradientButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text(
                        title,
                        style: AppConstants.kTextStyleMediumBoldWhite,
                      ),
              ),
            )),
      ),
    );
  }
}



class ReuseableCancelButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  
  final width;

  ReuseableCancelButton({
    super.key,
    required this.title,
    required this.onpress,
     this.width
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        width:width,
        height: MediaQuery.of(context).size.height / 17,
        decoration: ShapeDecoration(
          shadows: AppConstants.kShadows,
          // gradient: AppConstants.kgradientButton,
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text(
                        title,
                        style: AppConstants.kTextStyleMediumBoldWhite,
                      ),
              ),
            )),
      ),
    );
  }
}


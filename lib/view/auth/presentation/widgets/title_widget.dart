import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 46.0,
          ),
          child: Center(
            child: Text('DIVINE SOFTWARE',
                style: AppConstants.headlineTextStyleBlack),
          ),
        ),
        Text(
          "Support Care",
          style: AppConstants.kTextStyleMediumBoldGrey,
        ),
      ],
    );
  }
}

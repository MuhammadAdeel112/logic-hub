import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/models/assigned_jobs_model.dart';
import 'package:flutter/material.dart';

class DetailsOfShiftManagerInJobReportWidget extends StatelessWidget {
  final Job job;

  const DetailsOfShiftManagerInJobReportWidget({
    required this.job,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(
            'Shift Manager Details',
            style: AppConstants.kTextStyleMediumBoldBlack,
          ),
          Container(
            decoration: ShapeDecoration(
                color: AppConstants.kcwhiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: AppConstants.kShadows),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.manager[0].name,
                  style: AppConstants.kTextStyleMediumBoldBlack,
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Contact: ',
                          style: AppConstants.kTextStyleSmallBoldBlack),
                      TextSpan(
                          text: job.manager[0].phone,
                          style: AppConstants.kTextStyleSmallRegularBlack),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

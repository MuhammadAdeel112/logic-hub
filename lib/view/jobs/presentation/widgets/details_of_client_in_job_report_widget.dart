import 'package:divine_employee_app/core/common%20widgets/reuseable_circular_avatar.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../../../models/assigned_jobs_model.dart';

class DetailsOfClientInJobReportWidget extends StatelessWidget {
  final Job job;

  const DetailsOfClientInJobReportWidget({
    required this.job,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Client client = job.client; // ✅ single object

    final String clientName =
    "${client.firstName} ${client.lastName}".trim(); // null-safe
    final String clientMobile = client.mobile;
    final String clientImage = client.profileImage ?? "";
    final String clientLocation = job.address.formattedAddress;

    return Column(
      children: [
        Text(
          'Client Details',
          style: AppConstants.kTextStyleMediumBoldBlack,
        ),
        const Divider(color: Colors.transparent),
        Container(
          width: double.infinity,
          decoration: ShapeDecoration(
            color: AppConstants.kcwhiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadows: AppConstants.kShadows,
          ),
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReUseAbleRectangleImageAvatar(
                  image: clientImage, // null-safe
                ),
                const SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clientName,
                      style: AppConstants.kTextStyleMediumBoldBlack,
                    ),
                    const Divider(color: Colors.transparent),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Phone: ',
                            style: AppConstants.kTextStyleSmallBoldBlack,
                          ),
                          TextSpan(
                            text: clientMobile,
                            style: AppConstants.kTextStyleSmallRegularBlack,
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.transparent),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Location: ',
                            style: AppConstants.kTextStyleSmallBoldBlack,
                          ),
                          TextSpan(
                            text: clientLocation,
                            style: AppConstants.kTextStyleSmallRegularBlack,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_small_button.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_view_image_full_screen.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/update_job_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/common widgets/reuseable_sccafold_screen.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../models/assigned_jobs_model.dart';
import '../widgets/details_of_client_in_job_report_widget.dart';
import '../widgets/details_of_job_in_jobreport_widget.dart';
import '../widgets/detials_of_shift_manager_in_job_report_widget.dart';

class MyJobDetailsScreen extends StatefulWidget {
  final String isPaid;
  final Job job;

  const MyJobDetailsScreen({required this.job, required this.isPaid, super.key});

  @override
  State<MyJobDetailsScreen> createState() => _MyJobDetailsScreenState();
}

class _MyJobDetailsScreenState extends State<MyJobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
      appBarTitle: 'Details',
      content: SingleChildScrollView(
        child: Column(
          children: [
            DetailsOfClientInJobReportWidget(job: widget.job),
            DetailsOfShiftManagerInJobReportWidget(job: widget.job),
            DetailsOfJobInJobReportWidget(job: widget.job),

            // ---------------- Claim Extra ----------------
            if (widget.isPaid == 'approved' || widget.isPaid == 'unapproved')
              ClaimExtraWidget(
                extraDistance: widget.job.extraDistance?.toString() ?? '0',
                extraAmount: widget.job.extraAmount ?? '0',
                extraHours: widget.job.extraHours?.toString() ?? '0',
                imagePath: widget.job.imageUrl ?? '',
              ),

            // ---------------- Manager Remarks ----------------
            if (widget.isPaid == 'approved' || widget.isPaid == 'unapproved')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: AppConstants.kcwhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadows: AppConstants.kShadows,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manager Remarks',
                        style: AppConstants.kTextStyleMediumBoldBlack,
                      ),
                      Text(
                        widget.job.managerRemarks?.isNotEmpty == true
                            ? widget.job.managerRemarks!
                            : 'No remarks available',
                        style: AppConstants.kTextStyleSmallRegularBlack,
                      ),
                    ],
                  ),
                ),
              ),

            // ---------------- Update Button ----------------
            if (widget.isPaid == 'unapproved')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReuseableGradientSmallButton(
                  title: 'Update',
                  onpress: () {
                    Navigator.push(
                      context,
                      SlideTransitionPage(
                        page: UpdateJobScreen(
                          extraDistance:
                          widget.job.extraDistance?.toString() ?? '0',
                          jobNotes: widget.job.jobNotes ?? '',
                          extraAmount: widget.job.extraAmount ?? '0',
                          extraTime: widget.job.extraHours?.toString() ?? '0',
                          jobId: widget.job.id,
                          job: widget.job,
                          onUpdateSuccess: (String updatedExtraAmount,
                              String distanceTraveled) {
                            setState(() {
                              widget.job.extraAmount = updatedExtraAmount;
                              widget.job.extraDistance =
                                  int.tryParse(distanceTraveled) ?? 0;
                              widget.job.jobNotes ??= '';
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ClaimExtraWidget extends StatelessWidget {
  final String extraAmount;
  final String extraDistance;
  final String extraHours;
  final String imagePath;

  const ClaimExtraWidget({
    Key? key,
    required this.extraAmount,
    required this.extraDistance,
    required this.extraHours,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ---------------- Extra Info ----------------
          Container(
            constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Extra Claimed',
                  style: AppConstants.kTextStyleMediumBoldBlack,
                ),
                if (extraAmount.isNotEmpty)
                  Text(
                    'Extra Amount: $extraAmount',
                    style: AppConstants.kTextStyleSmallRegularBlack,
                  ),
                if (extraDistance.isNotEmpty)
                  Text(
                    'Extra Distance: $extraDistance',
                    style: AppConstants.kTextStyleSmallRegularBlack,
                  ),
                if (extraHours.isNotEmpty)
                  Text(
                    'Extra Hours: $extraHours',
                    style: AppConstants.kTextStyleSmallRegularBlack,
                  ),
              ],
            ),
          ),

          // ---------------- Image ----------------
          if (imagePath.isNotEmpty)
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ReuseableViewImageFullScreen(imageUrl: imagePath),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 9,
                decoration: ShapeDecoration(
                  color: AppConstants.kcwhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadows: AppConstants.kShadows,
                ),
                padding: const EdgeInsets.all(16),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

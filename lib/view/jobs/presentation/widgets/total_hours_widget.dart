import 'package:divine_employee_app/core/common%20widgets/reuseable_gap_widget.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class TotalHoursWidget extends StatelessWidget {
  final totalHr;
  final completedHr;
  final remainingHr;
  const TotalHoursWidget(
      {super.key,
      required this.containerHeight,
      required this.containerWidth,
      required this.progress,
      required this.totalHr,
      required this.completedHr,
      required this.remainingHr});

  final double containerHeight;
  final double containerWidth;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Total Allocated Hours
        Container(
          padding: const EdgeInsets.all(8.0),
          // height: containerHeight,
          // width: containerWidth,
          decoration: ShapeDecoration(
              color: AppConstants.kcwhiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: AppConstants.kShadows),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Allocated Hours',
                style: AppConstants.kTextStyleMediumBoldBlack,
              ),
              ReuseableGapWidget(),
              Text(
                'Per Week',
                style: AppConstants.kTextStyleMediumBoldGrey,
              ),
              ReuseableGapWidget(),
              SimpleAnimationProgressBar(
                  width: MediaQuery.of(context).size.width / 1,
                  height: MediaQuery.of(context).size.height / 50,
                  backgroundColor: AppConstants.kcgreyColor,
                  foregroundColor: Colors.transparent,
                  ratio: progress,
                  direction: Axis.horizontal,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(seconds: 3),
                  borderRadius: BorderRadius.circular(10),
                  gradientColor: AppConstants.kgradientButton),
              ReuseableGapWidget(),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total',
                              style: AppConstants.kTextStyleMediumBoldBlack),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$totalHr hr',
                              style: AppConstants.kTextStyleMediumBoldBlack),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Completed',
                              style: AppConstants.kTextStyleMediumBoldBlack),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$completedHr hr',
                              style: AppConstants.kTextStyleMediumBoldBlack),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Remaining',
                              style: AppConstants.kTextStyleMediumBoldBlack),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$remainingHr hr',
                              style: AppConstants.kTextStyleMediumBoldBlack),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

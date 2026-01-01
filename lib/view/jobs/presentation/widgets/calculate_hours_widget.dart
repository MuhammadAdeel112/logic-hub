import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/jobs/presentation/provider/timer_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'job_detail_tab_bar_with_timer_widget.dart';

class CalculateHoursWidget extends StatelessWidget {
  const CalculateHoursWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final timerModel = Provider.of<TimerModel>(context);

    return Container(
      // width: MediaQuery.of(context).size.width / 1,
      // height: MediaQuery.of(context).size.height / 16,
      decoration: ShapeDecoration(
        color: AppConstants.kcwhiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: AppConstants.kShadows,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Total Hours',
              // style: AppConstants.kTextStyleLargreBoldblack,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<WorkProvider>(
                  builder: (context, workProvider, child) {
                    final totalDuration = workProvider.getDuration();
                    return Container(
                      decoration: ShapeDecoration(
                        color: AppConstants.kcwhiteColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: AppConstants.kcgreyColor,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Text(
                        '${formatDuration(totalDuration)}',
                        style: AppConstants.kTextStyleMediumBoldBlack,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

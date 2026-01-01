import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResueableAlertDialogContent extends StatelessWidget {
  final bool iconDone;
  final String title;
  final String subtitle;
  final String rightButtonTitle;
  final String leftButtonTitle;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  ResueableAlertDialogContent({
    required this.rightButtonTitle,
    required this.leftButtonTitle,
    this.iconDone = true,
    required this.title,
    required this.subtitle,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        iconDone == true
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: ShapeDecoration(
                      color: AppConstants.kcprimaryColor,
                      // gradient: AppConstants.kgradientScreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Icon(
                      Icons.done,
                      size: 40,
                      color: AppConstants.kcwhiteColor,
                    )),
              )
            : SvgPicture.asset(AppConstants.CancelIconPath),
        title == ''
            ? SizedBox()
            : Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
        Divider(
          color: Colors.transparent,
        ),
        Text(subtitle),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: onCancel != null
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.center,
          children: <Widget>[
            if (onCancel != null)
              ReuseableCancelButton(
                  width: MediaQuery.of(context).size.width / 4,
                  title: leftButtonTitle,
                  onpress: () {
                    onCancel!();
                  }),
            if (onConfirm != null)
              ReuseableGradientButton(
                  width: MediaQuery.of(context).size.width / 4,
                  title: rightButtonTitle,
                  onpress: () {
                    onConfirm!();
                  })
          ],
        ),
      ],
    );
  }
}

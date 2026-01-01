import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:flutter/material.dart';

class EnterEmailWidget extends StatelessWidget {
  const EnterEmailWidget({
    super.key,
    required TextEditingController userEmailController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    this.title = "Email",
    this.hint = "Your Email",
  }) : _userEmailController = userEmailController;

  final TextEditingController _userEmailController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //title
          Padding(
            padding: EdgeInsets.only(top: 36, bottom: 8),
            child: Text(title, style: AppConstants.kTextStyleMediumBoldBlack),
          ),
          //container
          Padding(
            padding: EdgeInsets.only(
              bottom: 26,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.25,
              height: MediaQuery.of(context).size.height / 17,
              decoration: ShapeDecoration(
                  color: AppConstants.kcwhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadows: AppConstants.kShadows),
              child: Center(
                child: TextFormField(
                  controller: _userEmailController,
                  focusNode: emailFocusNode,
                  onFieldSubmitted: (value) => Utils.fietdFocusChange(
                      context, emailFocusNode, passwordFocusNode),
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

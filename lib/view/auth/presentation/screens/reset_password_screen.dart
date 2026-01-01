import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/view/auth/presentation/widgets/reset_button_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/enter_email_widget.dart';
import '../widgets/enter_password_widget.dart';
import '../widgets/sigin_button_widget.dart';
import '../widgets/title_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  ValueNotifier _obscurePAsswordText = ValueNotifier(true);
  FocusNode tokenFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kcprimaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              showCloseConfirmationDialog(context);
            }
          },
          icon: Icon(Icons.arrow_back_ios),
          color: AppConstants.kcwhiteColor,
        ),
        forceMaterialTransparency: true,
        backgroundColor: AppConstants.kcprimaryColor,

        elevation: 0.0,
        // title:
        //     Text('', style: AppConstants.kTextStyleLargreBoldWhite),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5.5,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: AppConstants.kgradientScreen,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Image.asset(
                      AppConstants.appLogoBgPath,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 1.3,
              decoration: BoxDecoration(
                color: AppConstants.kcgreyColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(46.0),
                  topRight: Radius.circular(46.0),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Utils.dismissKeyboard(context);
                },
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Column(
                      children: [
                        //Title
                        TitleWidget(),
                        //User Email
                        EnterEmailWidget(
                          title: "Token",
                            hint: "Enter Token",
                            userEmailController: _userEmailController,
                            emailFocusNode: tokenFocusNode,
                            passwordFocusNode: newPasswordFocusNode),
                        EnterPasswordWidget(
                          title: "New Password",
                            obscurePAsswordText: _obscurePAsswordText,
                            userPasswordController: _newPasswordController,
                            passwordFocusNode: newPasswordFocusNode),
                        // Login Button
                        ResetButtonWidget(
                          tokenController: _userEmailController,
                          userPasswordController: _newPasswordController,
                          // auth: authViewModel,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _userEmailController.dispose();
    _newPasswordController.dispose();
    _obscurePAsswordText.dispose();
    tokenFocusNode.dispose();
    newPasswordFocusNode.dispose();
  }
}

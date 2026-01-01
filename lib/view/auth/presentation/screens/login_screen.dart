import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:flutter/material.dart';
import '../widgets/enter_email_widget.dart';
import '../widgets/enter_password_widget.dart';
import '../widgets/sigin_button_widget.dart';
import '../widgets/title_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  ValueNotifier _obscurePAsswordText = ValueNotifier(true);
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
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
                            userEmailController: _userEmailController,
                            emailFocusNode: emailFocusNode,
                            passwordFocusNode: passwordFocusNode),
                        EnterPasswordWidget(
                            obscurePAsswordText: _obscurePAsswordText,
                            userPasswordController: _userPasswordController,
                            passwordFocusNode: passwordFocusNode),
                        // Login Button
                        SignInButtonWidget(
                          userEmailController: _userEmailController,
                          userPasswordController: _userPasswordController,
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
    _userPasswordController.dispose();
    _obscurePAsswordText.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }
}

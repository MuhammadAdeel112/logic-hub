import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_loading_animation.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/view/auth/presentation/screens/forgot_password_screen.dart';
import 'package:divine_employee_app/view/registration/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../api_provider/auth_viewmodel.dart';

class SignInButtonWidget extends StatelessWidget {
  const SignInButtonWidget({
    super.key,
    required TextEditingController userEmailController,
    required TextEditingController userPasswordController,
    // required this.auth,
  })  : _userEmailController = userEmailController,
        _userPasswordController = userPasswordController;

  final TextEditingController _userEmailController;
  final TextEditingController _userPasswordController;
  // final AuthViewModel auth;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 46, left: 46, bottom: 16),
            child: InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forget Password?',
                      style: AppConstants.kTextStyleMediumBoldBlack),
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                bottom: 16,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.25,
                height: MediaQuery.of(context).size.height / 17,
                child: authViewModel.loading
                    ? ReuseAbleLoadingAnimationWidget()
                    : ReuseableGradientButton(
                        title: "Sign In",
                        onpress: () {
                          if (_userEmailController.text.isEmpty) {
                            Utils.showFlushbar('Please Enter Email', context);
                          } else if (_userPasswordController.text.isEmpty) {
                            Utils.showFlushbar(
                                'Please Enter Password', context);
                          } else {
                            Utils.dismissKeyboard(context);
                            Map data = {
                              'email': _userEmailController.text.toString(),
                              'password':
                                  _userPasswordController.text.toString(),
                            };
                            authViewModel.LoginApi(data, context);
                          }
                        }),
              )),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationScreen(),
                  ));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 46, left: 46, bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont Have an account?',
                      style: AppConstants.kTextStyleMediumBoldBlack),
                  Text('  Create here',
                      style: AppConstants.kTextStyleMediumBoldPrimary),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_loading_animation.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/view/registration/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../api_provider/auth_viewmodel.dart';

class ForgotButtonWidget extends StatelessWidget {
  const ForgotButtonWidget({
    super.key,
    required TextEditingController userEmailController,
    // required this.auth,
  })  : _userEmailController = userEmailController;

  final TextEditingController _userEmailController;
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
              padding: EdgeInsets.only(
                bottom: 46,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.25,
                height: MediaQuery.of(context).size.height / 17,
                child: authViewModel.loading
                    ? ReuseAbleLoadingAnimationWidget()
                    : ReuseableGradientButton(
                    title: "Submit",
                    onpress: () {
                      if (_userEmailController.text.isEmpty) {
                        Utils.showFlushbar('Please Enter Email', context);
                      }else {
                        Utils.dismissKeyboard(context);
                        Map data = {
                          'email': _userEmailController.text.toString(),
                        };
                        authViewModel.ForgotApi(data, context);
                      }
                    }),
              )),
        ],
      ),
    );
  }
}

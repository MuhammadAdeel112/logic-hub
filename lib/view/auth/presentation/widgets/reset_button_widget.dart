import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_loading_animation.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/view/auth/presentation/screens/forgot_password_screen.dart';
import 'package:divine_employee_app/view/registration/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../api_provider/auth_viewmodel.dart';

class ResetButtonWidget extends StatelessWidget {
  const ResetButtonWidget({
    super.key,
    required TextEditingController tokenController,
    required TextEditingController userPasswordController,
    // required this.auth,
  })  : _tokenController = tokenController,
        _userPasswordController = userPasswordController;

  final TextEditingController _tokenController;
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
              padding: EdgeInsets.only(
                bottom: 46,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.25,
                height: MediaQuery.of(context).size.height / 17,
                child: authViewModel.loading
                    ? ReuseAbleLoadingAnimationWidget()
                    : ReuseableGradientButton(
                    title: "Reset",
                    onpress: () {
                      if (_tokenController.text.isEmpty) {
                        Utils.showFlushbar('Please Enter Token', context);
                      } else if (_userPasswordController.text.isEmpty) {
                        Utils.showFlushbar(
                            'Please Enter New Password', context);
                      } else {
                        Utils.dismissKeyboard(context);
                        Map data = {
                          // 'token': _tokenController.text.toString(),
                          'newPassword':
                          _userPasswordController.text.toString(),
                        };
                        authViewModel.ResetApi(data, context, _tokenController.text.toString());
                      }
                    }),
              )),
        ],
      ),
    );
  }
}

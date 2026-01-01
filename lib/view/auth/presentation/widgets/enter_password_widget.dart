
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class EnterPasswordWidget extends StatelessWidget {
  const EnterPasswordWidget({
    super.key,
    required ValueNotifier obscurePAsswordText,
    required TextEditingController userPasswordController,
    required this.passwordFocusNode,
    this.title = "Password"
  })  : _obscurePAsswordText = obscurePAsswordText,
        _userPasswordController = userPasswordController;

  final ValueNotifier _obscurePAsswordText;
  final TextEditingController _userPasswordController;
  final FocusNode passwordFocusNode;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _obscurePAsswordText,
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //title
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(title,
                      style: AppConstants.kTextStyleMediumBoldBlack),
                ),
                //contianer
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
                        controller: _userPasswordController,
                        focusNode: passwordFocusNode,
                        // onFieldSubmitted: (value) => Utils.fietdFocusChange(context, passwordFocusNode, ),
                        obscureText: _obscurePAsswordText.value,
                        decoration: InputDecoration(
                            hintText: "••••••••",
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.key_outlined,
                            ),
                            suffixIcon: InkWell(
                                onTap: () {
                                  _obscurePAsswordText.value =
                                      !_obscurePAsswordText.value;
                                },
                                child: Icon(_obscurePAsswordText.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

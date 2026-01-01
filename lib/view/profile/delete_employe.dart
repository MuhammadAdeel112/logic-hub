
import 'package:divine_employee_app/api_provider/profile_update_api_provider.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
      notification_icon: false,
      appBarTitle: 'Delete',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: Icon(
              Icons.warning,
              color: Colors.red,
            ),
            title: Text(
              'If you delete this account:',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            tileColor: Colors.red,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('● The Account will be delete from all of your devices.'),
                Text('● Your message history will be erased.'),
                Text('● Your Documents will be deleted.'),
                Text('● Your job histroy will be removed'),
              ],
            ),
          ),
          Divider(
            color: Colors.transparent,
          ),
          Text(
              'To delete your account, please enter your email and password to confrim its really you.'),
          Divider(
            color: Colors.transparent,
          ),
          Divider(
            color: Colors.transparent,
          ),
          Divider(
            color: Colors.transparent,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0, left: 4),
                child: Text(
                  'Email',
                  style: AppConstants.kTextStyleMediumRegularBlack,
                ),
              ),
              Container(
                decoration:
                    AppConstants.KContainerStyleForTextFormField,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Jhon",
                        hintStyle:
                            AppConstants.kTextStyleSmallBoldGrey,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Divider(
            color: Colors.transparent,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0, left: 4),
                child: Text(
                  'Password',
                  style: AppConstants.kTextStyleMediumRegularBlack,
                ),
              ),
              Container(
                decoration:
                    AppConstants.KContainerStyleForTextFormField,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "*******",
                        hintStyle:
                            AppConstants.kTextStyleSmallBoldGrey,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0, left: 4),
                child: Text(
                  'Re-Enter Password',
                  style: AppConstants.kTextStyleMediumRegularBlack,
                ),
              ),
              Container(
                decoration:
                    AppConstants.KContainerStyleForTextFormField,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: TextFormField(
                      controller: _passwordController1,
                      decoration: InputDecoration(
                        hintText: "*******",
                        hintStyle:
                            AppConstants.kTextStyleSmallBoldGrey,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Divider(
            color: Colors.transparent,
          ),
          Consumer<ProfileUpdateApiProvider>(
            builder: (BuildContext context, ProfileUpdateApiProvider value,
                Widget? child) {
              return value.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ReuseableCancelButton(
                      title: 'Delete Account',
                      onpress: () async {
                            bool confirm = await showDeleteAccountDialog(context);
                             if (confirm) {
      if (_passwordController.text !=
                            _passwordController1.text) {
                          Utils.showFlushbar('Password doesnot match', context);
                        } else if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          Map<String, dynamic> payload = {
                            "email": _emailController.text,
                            "password": _passwordController.text,
                          };
                         
                              await value.deleteAccountForEmployee(payload, context);
                         
                        } else {
                        Utils.showFlushbar  ('All fields are required', context);
                        }
  
                        // if (_passwordController.text !=
                        //     _passwordController1.text) {
                        //   Utils.showFlushbar('Password doesnot match', context);
                        // } else if (_emailController.text.isNotEmpty &&
                        //     _passwordController.text.isNotEmpty) {
                        //   Map<String, dynamic> payload = {
                        //     "email": _emailController.text,
                        //     "password": _passwordController.text,
                        //   };
                         
                        //       await value.deleteAccountForEmployee(payload, context);
                         
                        // } else {
                        // Utils.showFlushbar  ('All fields are required', context);
                        // }
                      };
                    });
            },
          ),
        ],
      ),
    );
  }
  // Function to show the dialog and return the user's choice (confirm or cancel)
Future<bool> showDeleteAccountDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Delete Account"),
        content: Text("Are you sure you want to delete your account?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context, false), // Return false if Cancel is pressed
          ),
          TextButton(
            child: Text("Delete"),
            onPressed: () => Navigator.pop(context, true), // Return true if Delete is pressed
          ),
        ],
      );
    },
  );
}
}

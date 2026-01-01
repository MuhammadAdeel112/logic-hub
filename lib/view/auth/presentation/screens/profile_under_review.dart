import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:flutter/material.dart';

class ProfileUnderReviewScreen extends StatefulWidget {
  const ProfileUnderReviewScreen({super.key});

  @override
  State<ProfileUnderReviewScreen> createState() => _ProfileUnderReviewScreenState();
}

class _ProfileUnderReviewScreenState extends State<ProfileUnderReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
      onLeadingPressed: (){
        print('object');
      },
      notification_icon: false,
      appBarTitle: 'Dismissed!',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Unfortunately, your employment has been terminated by the manager. \nPlease contact HR for further details.'),
          ),
          // Divider(
          //   color: Colors.transparent,
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //       'For security reasons, you need to log in again.'),
          // ),
          // Divider(
          //   color: Colors.transparent,
          // ),
          // ReuseableGradientButton(
          //     width: MediaQuery.of(context).size.width / 4,
          //     title: 'Login',
          //     onpress: () {})
        ],
      ),
    );
  }
}

import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/availability/presentation/screens/requested_availbility_details_screen.dart';
import 'package:flutter/material.dart';
class ChatMessageWidget extends StatelessWidget {
  final bool isSent;
  final String text;
  final DateTime time;
  final String sender;
  final messageId;

  ChatMessageWidget(
      {required this.isSent,
      required this.text,
      required this.time,
      required this.sender,
       this.messageId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment:
            isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (sender.isNotEmpty || sender != '')
            Text(sender, // Display the sender's name/identifier
                style: AppConstants.kTextStyleMediumBoldBlack),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              // color: Color(0xFF68AD49),
              color: isSent
                  ? AppConstants.kcprimaryColor
                  : AppConstants.kcwhiteColor, // Adjust colors as needed

              shape: RoundedRectangleBorder(
                borderRadius: isSent
                    ? BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16))
                    : BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 200.0,
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isSent ? Colors.white : Colors.black,
                ),
                maxLines: null,
              ),
            ),
          ),
          Row(
            mainAxisAlignment:
                isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: <Widget>[
              Text(
                formatDateTime(time),
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




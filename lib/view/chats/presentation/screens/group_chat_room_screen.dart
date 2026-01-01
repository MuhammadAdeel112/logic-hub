// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// import 'package:divine_employee_app/core/constants/app_constants.dart';

// import '../../../../core/common widgets/reuseable_sccafold_screen.dart';

// class GroupChatRoomScreen extends StatefulWidget {
//   final groupName;
//   const GroupChatRoomScreen({
//     Key? key,
//     required this.groupName,
//   }) : super(key: key);
//   @override
//   _GroupChatRoomScreenScreenState createState() =>
//       _GroupChatRoomScreenScreenState();
// }

// class _GroupChatRoomScreenScreenState extends State<GroupChatRoomScreen> {
//   final TextEditingController _textController = TextEditingController();
//   final List<GroupChatMessageWidget> _messages = <GroupChatMessageWidget>[];

//   void _handleSubmitted(String text) {
//     _textController.clear();
//     GroupChatMessageWidget message = GroupChatMessageWidget(
//       sender: 'Bilal',
//       isSent: false,
//       text: text,
//       time: '10: 23 Pm',
//     );
//     setState(() {
//       _messages.insert(0, message);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ReuseableScaffoldScreen(
//       resizeToAvoidBottomInset: true,
//       appBarTitle: widget.groupName,
//       content: Column(
//         children: <Widget>[
//           Flexible(
//             child: ListView.builder(
//               reverse: true,
//               itemCount: _messages.length,
//               itemBuilder: (context, index) => _messages[index],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//             clipBehavior: Clip.antiAlias,
//             decoration: BoxDecoration(color: Colors.white),
//             child: _buildTextComposer(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextComposer() {
//     return IconTheme(
//       data: IconThemeData(color: Theme.of(context).canvasColor),
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Flexible(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//                 decoration: ShapeDecoration(
//                   color: Color(0xFFF7F7FC),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4)),
//                 ),
//                 child: TextField(
//                   controller: _textController,
//                   onSubmitted: _handleSubmitted,
//                   decoration: InputDecoration.collapsed(
//                     hintText: 'Send a message',
//                   ),
//                 ),
//               ),
//             ),
//             IconButton(
//               padding: EdgeInsets.only(left: 12),
//               icon: Icon(
//                 Icons.send,
//                 color: AppConstants.kcprimaryColor,
//               ),
//               onPressed: () => _handleSubmitted(_textController.text),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class GroupChatMessageWidget extends StatelessWidget {
//   final bool isSent;
//   final String text;
//   final String time;
//   final String sender; // Add sender information

//   GroupChatMessageWidget({
//     required this.isSent,
//     required this.text,
//     required this.time,
//     required this.sender,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10.0),
//       child: Column(
//         crossAxisAlignment:
//             isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(sender, // Display the sender's name/identifier
//               style: AppConstants.kTextStyleMediumBoldBlack),
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: ShapeDecoration(
//               // color: Color(0xFF68AD49),
//               color: isSent
//                   ? AppConstants.kcprimaryColor
//                   : AppConstants.kcwhiteColor, // Adjust colors as needed

//               shape: RoundedRectangleBorder(
//                 borderRadius: isSent
//                     ? BorderRadius.only(
//                         topLeft: Radius.circular(16),
//                         topRight: Radius.circular(16),
//                         bottomLeft: Radius.circular(16))
//                     : BorderRadius.only(
//                         topLeft: Radius.circular(16),
//                         topRight: Radius.circular(16),
//                         bottomRight: Radius.circular(16),
//                       ),
//               ),
//             ),
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxWidth: 200.0,
//               ),
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   color: isSent ? Colors.white : Colors.black,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: null,
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment:
//                 isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 time,
//                 style: TextStyle(
//                   fontSize: 12.0,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/chat_state.dart';

class GroupChatRoomScreen extends StatefulWidget {
  final name;
  final chatId;

  const GroupChatRoomScreen(
      {super.key, required this.chatId, required this.name});
  @override
  _GroupChatRoomScreenScreenState createState() =>
      _GroupChatRoomScreenScreenState();
}

class _GroupChatRoomScreenScreenState extends State<GroupChatRoomScreen> {
  final TextEditingController _textController = TextEditingController();
  late ChatState _chatState;
  ScrollController _scrollController = ScrollController();

  var my_id;
  @override
  void initState() {
    getID();
    _chatState = Provider.of<ChatState>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _chatState.connect(my_id, _scrollController);
      _chatState.fetchChatRoom(widget.chatId, false).then((value) {
        // Set the initial scroll position to the maximum extent
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
      });
    });
    super.initState();
  }

  getID() async {
    my_id = await SessionHandlingViewModel().getMyId();
  }

  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
      notification_icon: true,
      resizeToAvoidBottomInset: true,
      appBarTitle: widget.name,
      content: ChangeNotifierProvider.value(
        value: _chatState,
        child: Consumer<ChatState>(
          builder:
              (BuildContext context, ChatState providerValue, Widget? child) {
            return Column(
              children: <Widget>[
                Flexible(
                    child: ListView.builder(
                  controller: _scrollController,
                  itemCount: providerValue.groupMeassage.length,
                  itemBuilder: (context, index) =>
                      Container(child: providerValue.groupMeassage[index]),
                )),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.white),
                  child: IconTheme(
                    data: IconThemeData(color: Theme.of(context).canvasColor),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              decoration: ShapeDecoration(
                                color: Color(0xFFF7F7FC),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              child: TextField(
                                controller: _textController,
                                onSubmitted: (value) {
                                  Map notificationPayload = {
                                    'title': 'New Message',
                                    'body': _textController.text,
                                    'type': widget.chatId
                                  };
                                  providerValue.sendMessage(
                                      _textController.text,
                                      my_id,
                                      widget.chatId,
                                      '',
                                      _scrollController,
                                      notificationPayload,
                                      false);
                                  _textController.clear();
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    _scrollController.jumpTo(_scrollController
                                        .position.maxScrollExtent);
                                  });
                                },
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Send a message',
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              padding: EdgeInsets.only(left: 12),
                              icon: Icon(
                                Icons.send,
                                color: AppConstants.kcprimaryColor,
                              ),
                              onPressed: () {
                                Map notificationPayload = {
                                  'title': 'New Message',
                                  'body': _textController.text,
                                  'type': widget.chatId
                                };
                                providerValue.sendMessage(
                                    _textController.text,
                                    my_id,
                                    '',
                                    widget.chatId,
                                    _scrollController,
                                    notificationPayload,
                                    false);
                                _textController.clear();

                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  _scrollController.jumpTo(_scrollController
                                      .position.maxScrollExtent);
                                });
                              }
                              //  _handleSubmitted(_textController.text),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _chatState.disposeConnection();
    _chatState.clearMessageList();
    super.dispose();
  }
}

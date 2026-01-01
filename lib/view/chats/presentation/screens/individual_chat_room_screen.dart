import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/chats/presentation/provider/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndividualChatRoomScreen extends StatefulWidget {
  final recevierId;
  final JobId;
  final name;
  final chatId;
  IndividualChatRoomScreen({
    required this.name,
    required this.recevierId,
    required this.JobId,
    this.chatId,
  });
  @override
  _IndividualChatRoomScreenState createState() =>
      _IndividualChatRoomScreenState();
}

class _IndividualChatRoomScreenState extends State<IndividualChatRoomScreen> {
  final TextEditingController _textController = TextEditingController();
  // final List<ChatMessageWidget> _messages = <ChatMessageWidget>[];
  late ChatState _chatState;
  ScrollController _scrollController = ScrollController();

  var my_id;
  @override
  void initState() {
    getID();
    _chatState = Provider.of<ChatState>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _chatState.connect(my_id, _scrollController);
      _chatState.fetchChatRoom(widget.chatId, true).then((value) {
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
    print('my id ::: ${await SessionHandlingViewModel().getMyId()}');
  }

  // void _handleSubmitted(String text) {
  //   _textController.clear();
  //   ChatMessageWidget message = ChatMessageWidget(
  //     isSent: true,
  //     text: text,
  //     time: '10: 23 Pm',
  //   );
  //   setState(() {
  //     // _messages.insert(0, message);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
      resizeToAvoidBottomInset: true,
      appBarTitle: widget.name,
      content: ChangeNotifierProvider.value(
          value: _chatState,
          child: Consumer<ChatState>(builder: (context, providerValue, child) {
            return Column(
              children: [
                Flexible(
                    child: ListView.builder(
                  // Set the initial scroll position to the maximum extent
                  // initialScrollOffset:
                  //     _scrollController.position.maxScrollExtent,
                  controller: _scrollController,
                  itemCount: providerValue.messages.length,
                  itemBuilder: (context, index) =>
                      Container(child: providerValue.messages[index]),
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
                                      widget.recevierId,
                                      widget.chatId,
                                      _scrollController,
                                      notificationPayload,
                                      true);
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
                                  'title': widget.name,
                                  'body': _textController.text,
                                  'type': widget.chatId
                                };
                                providerValue.sendMessage(
                                    _textController.text,
                                    my_id,
                                    widget.recevierId,
                                    widget.chatId,
                                    _scrollController,
                                    notificationPayload,
                                    true);
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
          })),
    );
  }

  @override
  void dispose() {
    _chatState.disposeConnection();
    super.dispose();
  }
}

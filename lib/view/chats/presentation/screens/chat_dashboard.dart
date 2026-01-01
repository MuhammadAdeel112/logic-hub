import 'package:flutter/material.dart';
import '../../../../core/common widgets/reuseable_sccafold_screen.dart';
import 'individual_chat_screen.dart';
import '../widgets/chat_tab_bar_widget.dart';
import 'group_chats_screen.dart';

class ChatDashboard extends StatefulWidget {
  const ChatDashboard({super.key});

  @override
  State<ChatDashboard> createState() => _ChatDashboardState();
}

class _ChatDashboardState extends State<ChatDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
        appBarTitle: 'Chat',
        content: Column(
          children: [
            ChatTabBarWidget(tabController: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [IndividualChatScreen(), GroupChatsScreen()],
              ),
            ),
          ],
        ));
  }
}

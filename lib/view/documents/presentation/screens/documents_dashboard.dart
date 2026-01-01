// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/view/documents/presentation/screens/pending_documents_screen.dart';
import 'package:divine_employee_app/view/documents/presentation/widgets/documents_tabbar_widget.dart';

import 'my_documents_screen.dart';
import 'upload_file_screen.dart';

class DocumentsDashboard extends StatefulWidget {
  final animateTo;
  DocumentsDashboard({
    Key? key,
    this.animateTo,
  }) : super(key: key);

  static void changeTab(int index) {
    _DocumentsDashboardState? state = _dashboardKey.currentState;
    state?.changeTab(index);
  }

  static final GlobalKey<_DocumentsDashboardState> _dashboardKey =
      GlobalKey<_DocumentsDashboardState>();

  @override
  State<DocumentsDashboard> createState() => _DocumentsDashboardState();
}

class _DocumentsDashboardState extends State<DocumentsDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    if (widget.animateTo != null) {
      _tabController.animateTo(widget.animateTo);
    }
    
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void changeTab(int index) {
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
      appBarTitle: 'Documents',
      content: Column(
        children: [
          DocumentsTabBarWidget(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                MyDocumentsScreen(),
                PendingDocumentsScreen(),
                UploadFileScreen(
                  parentTabController: _tabController,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

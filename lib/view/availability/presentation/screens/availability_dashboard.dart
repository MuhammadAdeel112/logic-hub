import 'package:divine_employee_app/view/availability/presentation/screens/create_availability_screen.dart';
import 'package:divine_employee_app/view/availability/presentation/screens/requested_availbility_details_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/common widgets/reuseable_sccafold_screen.dart';
import '../widgets/availability_tabbar_widget.dart';

class AvailabilityDashboard extends StatefulWidget {
  const AvailabilityDashboard({Key? key}) : super(key: key);

  @override
  _AvailabilityDashboardState createState() => _AvailabilityDashboardState();
}

class _AvailabilityDashboardState extends State<AvailabilityDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    // _availabilityDataFuture = GetAvailabilityApi()
    //     .fetchData(employeeData.employeeProfile!.employee.id);
  }

  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
        appBarTitle: 'Divine Care',
        content: Column(
          children: [
            AvailabilityTabBarWidget(tabController: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  RequestedAvailabilityDetailsScreen(),
                  CreateAvailabilityScreen()
                ],
              ),
            ),
          ],
        ));
  }
}

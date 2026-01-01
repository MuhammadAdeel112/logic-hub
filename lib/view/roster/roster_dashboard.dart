import 'package:divine_employee_app/api_provider/get_roster_api_provider.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/models/get_roster_model.dart';
import 'package:divine_employee_app/view/availability/presentation/screens/requested_availbility_details_screen.dart';
import 'package:flutter/material.dart';

class RosterDashboard extends StatefulWidget {
  const RosterDashboard({super.key});

  @override
  State<RosterDashboard> createState() => _RosterDashboardState();
}

String formatDate(DateTime date) {
  // Format the date manually (without intl)
  return '${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}';
}

String _twoDigits(int n) {
  if (n >= 10) return '$n';
  return '0$n';
}

class _RosterDashboardState extends State<RosterDashboard> {
  Future<GetRosterModel>? viewRoster;
  void initState() {
    super.initState();
    var now = DateTime.now();
    var nowDate = DateTime(now.year, now.month, now.day);
    var formattedDate = formatDate(nowDate);
    print('::: now $formattedDate');
    // Start a timer to simulate the passage of time (for example, every second)
    viewRoster = GetRosterApiProvider().fetchRosters(formattedDate);
  }

  // List _filterFeedback(List feedback, String query) {
  //   return feedback
  //       .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  // }

  DateTime date = DateTime.now();

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        viewRoster = GetRosterApiProvider().fetchRosters(formatDate(date));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // var feedbackProvider = Provider.of<SearchProvider>(context);

    return ReuseableScaffoldScreen(
      appBarTitle: 'Roster',
      content: Stack(
        children: [
          ReuseableGradientButton(
            onpress: () => _selectDate(context),
            title: 'Select Date: ${formatDate(date)}',
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: FutureBuilder<GetRosterModel>(
                future: viewRoster,
                builder: (context, AsyncSnapshot<GetRosterModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.data == null) {
                    return Center(
                      child: Text(
                          'Sorry, no roster was found for the ${formatDate(date)}.\n\nPlease choose a date for which a roster has already been created.'),
                    );
                  }

                  // Filter the feedback based on the search query
                  // filteredFeedback = _filterFeedback(
                  //     snapshot.data!.data, _searchController.text);
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.shifts.length,
                          itemBuilder: (context, index) {
                            return _buildShiftItem(
                                snapshot.data!.shifts[index]);
                          },
                        ),
                      ),
                      // Text(roster.employees[0].shifts[0].taskDetail),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  // Widget _buildRosterItem(EmployeeInRoster rosterItem) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 8),
  //     decoration:
  //         AppConstants.KContainerStyleForTextFormField,
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Employee Name: ${rosterItem.employeeName}',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //           ),
  //           SizedBox(height: 8),
  //           Text('Shift Details:'),
  //           Column(
  //             children: rosterItem.shifts.map((shift) {
  //               return _buildShiftItem(shift);
  //             }).toList(),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildShiftItem(ShiftInRoster shift) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 8),
                Text('Time: ${formatDateTime(shift.startTime)}'),
                SizedBox(width: 8),
                Text(' - ${formatDateTime(shift.endTime)}'),
              ],
            ),
            SizedBox(height: 4),
            Text('Task Detail: ${shift.taskDetail}'),
            SizedBox(height: 4),
            Text('Client Name: ${shift.clientName}'),
          ],
        ),
      ),
    );
  }
}

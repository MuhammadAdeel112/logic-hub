import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/view/availability/presentation/screens/availability_dashboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/common widgets/reuseable_gradient_button.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../api_provider/availability_api_provider.dart';
import '../../../../api_provider/data_provider_for_employee_profile.dart';
import '../provider/create_availability_provider_for_local.dart';

class CreateAvailabilityScreen extends StatefulWidget {
  @override
  State<CreateAvailabilityScreen> createState() =>
      _CreateAvailabilityScreenState();
}

class _CreateAvailabilityScreenState extends State<CreateAvailabilityScreen> {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<CreateAvailabilityProviderForLocal>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Please Select Date Range',
                    style: AppConstants.kTextStyleMediumBoldGrey,
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () => _selectDateRange(context),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        width: MediaQuery.of(context).size.width / 1,
                        decoration: ShapeDecoration(
                          color: AppConstants.kcwhiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          shadows: AppConstants.kShadows,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Date: ${_formatDateWithDay(Provider.of<CreateAvailabilityProviderForLocal>(context).selectedStartDate)}',
                                  style: AppConstants.kTextStyleMediumBoldBlack,
                                ),
                                Divider(
                                  color: Colors.transparent,
                                ),
                                Text(
                                  'End Date: ${_formatDateWithDay(Provider.of<CreateAvailabilityProviderForLocal>(context).selectedEndDate)}',
                                  style: AppConstants.kTextStyleMediumBoldBlack,
                                ),
                              ],
                            ),
                            Icon(Icons.calendar_month)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.transparent,
            ),
            Consumer<CreateAvailabilityProviderForLocal>(
              builder: (context, notifier, child) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notifier.availabilities.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Day ${index + 1} - ${_formatDateWithDay(notifier.availabilities[index].date, includeYear: false)}',
                              style: AppConstants.kTextStyleSmallBoldGrey,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1,
                            padding: EdgeInsets.all(8),
                            decoration: ShapeDecoration(
                              color: AppConstants.kcwhiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              shadows: AppConstants.kShadows,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!notifier
                                    .availabilities[index].isAvailableAllDay)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i <
                                              notifier.availabilities[index]
                                                  .shifts.length;
                                          i++)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: 'Shift ',
                                                    style: AppConstants
                                                        .kTextStyleMediumBoldGrey,
                                                  ),
                                                  TextSpan(
                                                    text: '${i + 1}   ',
                                                    style: AppConstants
                                                        .kTextStyleMediumBoldGrey,
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        'Time: ${formatTimeWithAMPM(notifier.availabilities[index].shifts[i].startTime)}',
                                                    // '${notifier.availabilities[index].shifts[i].startTime.hour}:${notifier.availabilities[index].shifts[i].startTime.minute}',
                                                    style: AppConstants
                                                        .kTextStyleSmallBoldBlack,
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' - ${formatTimeWithAMPM(notifier.availabilities[index].shifts[i].endTime)}',
                                                    style: AppConstants
                                                        .kTextStyleSmallBoldBlack,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () => notifier
                                                  .removeShift(index, i),
                                              icon: Icon(Icons.delete),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                InkWell(
                                  onTap: () => _addShift(context, index),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Available All Day'),
                                          Checkbox(
                                            value: notifier
                                                .availabilities[index]
                                                .isAvailableAllDay,
                                            onChanged: (value) {
                                              notifier.toggleAllDay(index);
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Add Shifts',
                                            style: AppConstants
                                                .kTextStyleSmallBoldBlack,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Icon(
                                              Icons.post_add_sharp,
                                              color:
                                                  AppConstants.kcprimaryColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            Divider(
              color: Colors.transparent,
            ),
            if (notifier.availabilities.isEmpty)
              SizedBox()
            else
              Consumer<AvailabilityApiProvider>(
                  builder: (context, provider, child) {
                if (provider.isLoading == true) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ReuseableGradientButton(
                    title: 'Submit Request',
                    onpress: () {
                      _sendAvailability(context);
                      if (kDebugMode) _printData(context);
                    },
                  );
                }
              }),
            Divider(
              color: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendAvailability(BuildContext context) async {
    final notifier =
        Provider.of<CreateAvailabilityProviderForLocal>(context, listen: false);
    final provider =
        Provider.of<AvailabilityApiProvider>(context, listen: false);
    provider.isLoading = true;
    final employee =
        Provider.of<DataProviderForEmployeeProfile>(context, listen: false);
    try {
      // Convert data to the required format
      Map<String, dynamic> apiFormatData =
          notifier.convertToApiFormat(employee.employeeProfile!.employee.id);

      // Send the data to the server using the AvailabilityApiProvider
      AvailabilityApiProvider apiProvider = AvailabilityApiProvider();
      Map<String, dynamic> response = await apiProvider.setAvailability(
        employeeId: apiFormatData['employeeId'],
        startDate: DateTime.parse(apiFormatData['startDate']),
        endDate: DateTime.parse(apiFormatData['endDate']),
        days: List<Map<String, dynamic>>.from(apiFormatData['days']),
        context: context,
      );
      print('object${response}');
      // Handle the response
      if (response['success'] == true) {
        print('Availability set successfully');
        _showResultDialog(context, message: 'Request Submitted successfully');
      } else {
        print('Error setting availability: ${response['message']}');
        Utils.showFlushbar(response['message'], context);
      }
    } catch (e) {
      // Handle error
      print('Error setting availability: $e');
    }
    provider.isLoading = false;
  }

  void _showResultDialog(BuildContext context, {required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: <Widget>[
            ReuseableGradientButton(
              onpress: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.push(context,
                    SlideTransitionPage(page: AvailabilityDashboard()));
              },
              width: MediaQuery.of(context).size.width / 4,
              title: 'Ok',
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTime? pickedStartDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: Provider.of<CreateAvailabilityProviderForLocal>(context,
              listen: false)
          .selectedStartDate,
    );

    if (pickedStartDate != null) {
      final DateTime pickedEndDate = pickedStartDate.add(Duration(days: 6));

      Provider.of<CreateAvailabilityProviderForLocal>(context, listen: false)
          .selectedStartDate = pickedStartDate;
      Provider.of<CreateAvailabilityProviderForLocal>(context, listen: false)
          .selectedEndDate = pickedEndDate;
      Provider.of<CreateAvailabilityProviderForLocal>(context, listen: false)
          .availabilities = Provider.of<CreateAvailabilityProviderForLocal>(
              context,
              listen: false)
          .generateInitialAvailabilities();
    }
  }

  Future<void> _addShift(BuildContext context, int index) async {
    Provider.of<CreateAvailabilityProviderForLocal>(context, listen: false)
        .availabilities[index]
        .isAvailableAllDay = false;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    Provider.of<CreateAvailabilityProviderForLocal>(context, listen: false)
        .notifyListeners();
    TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 0),
    );

    TimeOfDay? endTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 17, minute: 0),
    );

    if (startTime != null && endTime != null) {
      Provider.of<CreateAvailabilityProviderForLocal>(context, listen: false)
          .addShift(
        index,
        Shift(
          startTime: _formatTimeToDateTime(startTime),
          endTime: _formatTimeToDateTime(endTime),
        ),
      );
    }
  }

  DateTime _formatTimeToDateTime(TimeOfDay time) {
    DateTime now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
  }

  String _formatDateWithDay(DateTime date, {bool includeYear = true}) {
    final List<String> weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    String dayOfWeek =
        weekdays[date.weekday - 1]; // Adjust index to start from 0
    String formattedDate =
        '${dayOfWeek}, ${date.day} ${_getMonthAbbreviation(date.month)}';

    if (includeYear) {
      formattedDate += ' ${date.year}';
    }

    return formattedDate;
  }

  String _getMonthAbbreviation(int month) {
    final List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1]; // Adjust index to start from 0
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _printData(BuildContext context) {
    final notifier =
        Provider.of<CreateAvailabilityProviderForLocal>(context, listen: false);
    print('::: ${notifier.availabilities}');
    print('Selected Start Date: ${notifier.selectedStartDate}');
    print('Selected End Date: ${notifier.selectedEndDate}');

    for (int i = 0; i < notifier.availabilities.length; i++) {
      print('Day ${i + 1} - ${_formatDate(notifier.availabilities[i].date)}');

      if (notifier.availabilities[i].isAvailableAllDay) {
        print('  Available All Day');
      } else {
        for (int j = 0; j < notifier.availabilities[i].shifts.length; j++) {
          print(
              '  Shift ${j + 1}: Start Time - ${notifier.availabilities[i].shifts[j].startTime}, End Time - ${notifier.availabilities[i].shifts[j].endTime}');
        }
      }
    }
  }

  String formatTimeWithAMPM(DateTime time) {
    int hour = time.hour;
    String period = (hour < 12) ? 'AM' : 'PM';

    if (hour == 0) {
      hour = 12; // 12 AM should be displayed as 12, not 0
    } else if (hour > 12) {
      hour -= 12; // Convert from 24-hour to 12-hour format
    }

    String formattedTime =
        '$hour:${time.minute.toString().padLeft(2, '0')} $period';
    return formattedTime;
  }
}

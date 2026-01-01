import 'package:divine_employee_app/api_provider/data_provider_for_employee_profile.dart';
import 'package:divine_employee_app/api_provider/get_availability_api.dart';
import 'package:divine_employee_app/view/availability/presentation/provider/avilability_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';

class RequestedAvailabilityDetailsScreen extends StatefulWidget {
  const RequestedAvailabilityDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RequestedAvailabilityDetailsScreen> createState() =>
      _RequestedAvailabilityDetailsScreenState();
}

class _RequestedAvailabilityDetailsScreenState
    extends State<RequestedAvailabilityDetailsScreen> {
  late AvailabilityNotifier _availabilityNotifier;

  @override
  void initState() {
    super.initState();
    _availabilityNotifier =
        Provider.of<AvailabilityNotifier>(context, listen: false);
    final employeeData =
        Provider.of<DataProviderForEmployeeProfile>(context, listen: false);

    if (employeeData.employeeProfile != null) {
      GetAvailabilityApi(_availabilityNotifier)
          .fetchData(employeeData.employeeProfile!.employee.id);
    }
  }

  Future<void> _refreshData() async {
    Provider.of<AvailabilityNotifier>(context, listen: false)
        .resetAvailabilityData();
    _availabilityNotifier =
        Provider.of<AvailabilityNotifier>(context, listen: false);
    final employeeData =
        Provider.of<DataProviderForEmployeeProfile>(context, listen: false);

    if (employeeData.employeeProfile != null) {
      GetAvailabilityApi(_availabilityNotifier)
          .fetchData(employeeData.employeeProfile!.employee.id);
    }
    if (kDebugMode) print(':::id ${employeeData.employeeProfile!.employee.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AvailabilityNotifier>(builder: (context, notifier, _) {
      if (notifier.availabilityData.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
        List<DayAvailability> availabilityData = notifier.availabilityData;
        return RefreshIndicator(
          onRefresh: () async {
            print('Refresh initiated');
            await _refreshData();
          },
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: availabilityData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 5, bottom: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Text(
                            availabilityData[index].day.day.toString() +
                                '/' +
                                availabilityData[index].day.month.toString() +
                                '/' +
                                availabilityData[index].day.year.toString(),
                            style: AppConstants.kTextStyleSmallBoldGrey,
                          ),
                        ],
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
                        // ... (rest of your decoration)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!availabilityData[index].isAvailableAllDay)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0;
                                    i < availabilityData[index].shifts.length;
                                    i++)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
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
                                                text: 'Time: ' +
                                                    formatDateTime(
                                                        availabilityData[index]
                                                            .shifts[i]
                                                            .startTime),
                                                style: AppConstants
                                                    .kTextStyleSmallBoldBlack,
                                              ),
                                              TextSpan(
                                                text: ' - ' +
                                                    formatDateTime(
                                                        availabilityData[index]
                                                            .shifts[i]
                                                            .endTime),
                                                style: AppConstants
                                                    .kTextStyleSmallBoldBlack,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          availabilityData[index].isAvailableAllDay == true
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Available All Day'),
                                        Checkbox(
                                          value: availabilityData[index]
                                              .isAvailableAllDay,
                                          onChanged: (value) {
                                            // Handle checkbox state if needed
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    });
  }
}

String formatDateTime(DateTime dateTime) {
  String period = 'AM';
  int hour = dateTime.hour;
  if (hour >= 12) {
    period = 'PM';
    if (hour > 12) {
      hour -= 12;
    }
  }

  return '${_twoDigits(hour)}:${_twoDigits(dateTime.minute)} $period';
}

String _twoDigits(int n) {
  if (n >= 10) return '$n';
  return '0$n';
}

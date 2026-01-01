import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../provider/date_range_provider.dart';

class DateRangePicker extends StatelessWidget {
  const DateRangePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateRangeProvider>(
      builder: (context, dateRangeProvider, child) {
        final selectedRange = dateRangeProvider.selectedRange;

        return GestureDetector(
          onTap: () async {
            final today = DateTime.now();
            final result = await showDateRangePicker(
              context: context,
              firstDate: today,
              lastDate: DateTime(today.year + 5),
            );

            if (result != null) {
              dateRangeProvider.setDateRange(result);
            } else {
              dateRangeProvider.clearDateRange();
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color(0xFF334155)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedRange != null
                      ? "${DateFormat.yMMMd().format(selectedRange.start)} - ${DateFormat.yMMMd().format(selectedRange.end)}"
                      : "Select",
                    style: AppConstants.ktextDropDownStyle,
                ),
                const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black),
              ],
            ),
          ),
        );
      },
    );
  }
}



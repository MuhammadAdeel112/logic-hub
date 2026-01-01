import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../provider/select_leave_type_provider.dart';

class LeaveRequestDropdownWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectTypeProvider = Provider.of<SelectLeaveTypeProvider>(
      context,
    );
    List<String> items = ['Select', 'free', 'paid'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text('Type', style: AppConstants.kTextStyleMediumBoldBlack),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 26),
          child: Container(
            height: MediaQuery.of(context).size.height / 17,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFF334155)),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Center(
              child: DropdownButton<String>(
                alignment: Alignment.centerRight,
                borderRadius: BorderRadius.circular(29),
                dropdownColor:
                    AppConstants.kcwhiteColor, // Use your desired color
                padding: EdgeInsets.all(8),
                underline: SizedBox(),
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down_sharp),
                value: selectTypeProvider.type, // Current selected item
                onChanged: (String? newValue) {
                  selectTypeProvider.setType(newValue!);
                },
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: AppConstants.ktextDropDownStyle),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

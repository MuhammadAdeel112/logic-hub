import 'package:divine_employee_app/view/incidents/presentation/provider/select_incident_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';

class IncidentTypeDropdownWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectTypeProvider = Provider.of<SelectIncidentTypeProvider>(
      context,
    );
    List<String> items = ['Select',"Police", "Fire", "Ambulance","Other"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            'Type',
            style: AppConstants.kTextStyleMediumBoldGrey,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 26),
          child: Container(
            height: MediaQuery.of(context).size.height / 17,
            width: MediaQuery.of(context).size.width / 2.5,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: ShapeDecoration(
              color: AppConstants.kcwhiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shadows: AppConstants.kShadows,
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

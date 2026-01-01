import 'package:flutter/material.dart';

class ResueableSearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final onChanged;

  ResueableSearchWidget(
      {required this.searchController, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.only(left: 18),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.15,
            ),
            decoration: ShapeDecoration(
              color: Colors.white, // Customize as needed
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(29),
              ),
            ),
            child: TextFormField(
              controller: searchController,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: 'Search',
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

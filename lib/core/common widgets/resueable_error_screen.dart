import 'package:flutter/material.dart';

class ResueAbleErrorScreen extends StatelessWidget {
  final String errorMsg;
  const ResueAbleErrorScreen({super.key, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(errorMsg),
      ),
    );
  }
}

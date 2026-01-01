
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../view/jobs/presentation/widgets/total_hours_widget.dart';

class ReuseAbleShimmerLoading extends StatelessWidget {
  ReuseAbleShimmerLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double containerWidth =
        screenSize.width * 0.95; // 80% of screen width
    final double containerHeight =
        screenSize.height * 0.25; // 40% of screen height

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Placeholder background color
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!, // Lighter base color for other widgets
          highlightColor: Colors.grey[100]!, // Slightly lighter highlight color
          child: TotalHoursWidget(
            containerHeight:
                containerHeight, // Set an approximate height for the shimmer
            containerWidth:
                containerWidth, // Set an approximate width for the shimmer
            progress: 0, // Set an approximate progress for the shimmer
            totalHr: 0,
            remainingHr: 0,
            completedHr: 0,
          ),
        ),
      ),
    );
  }
}

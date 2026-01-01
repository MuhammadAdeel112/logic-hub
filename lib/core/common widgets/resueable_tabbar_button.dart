import 'package:flutter/material.dart';

class ReuseableTabbarButton extends StatelessWidget {
  final text;
  final Color bgColor;
  final Color borderColor;
  final TextStyle textStyle;
  final VoidCallback onpress;
  ReuseableTabbarButton({
    required this.onpress,
    required this.text,
    required this.bgColor,
    required this.textStyle,
    required this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.50,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

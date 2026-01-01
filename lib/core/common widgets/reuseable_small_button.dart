import 'package:flutter/material.dart';

class ReuseableSmallButton extends StatelessWidget {
 final text;
 final Color bgColor;
 final TextStyle textStyle;
  final VoidCallback onpress;
  ReuseableSmallButton({
    required this.onpress,
    required this.text,
    required this.bgColor,
    required this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        // width: 101,
        // height: MediaQuery.of(context).size.height / 33,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
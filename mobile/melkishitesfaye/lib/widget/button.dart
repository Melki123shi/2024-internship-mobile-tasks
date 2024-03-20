import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final String text;
  VoidCallback onTap;

  ButtonWidget({
    super.key,
    required this.onTap,
    required this.width,
    required this.height,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor,
            )),
        width: width,
        height: height,
      ),
    );
  }
}

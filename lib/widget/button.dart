import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final double width;
  final double height;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final String text;

  const ButtonWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.bgColor,
      required this.borderColor,
      required this.textColor,
      required this.text});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style:
              TextStyle(color: widget.textColor, fontWeight: FontWeight.bold),
        ),
        decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.borderColor,
            )),
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}

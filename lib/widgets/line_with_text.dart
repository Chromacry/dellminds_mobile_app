import 'package:flutter/material.dart';

class LineWithText extends StatelessWidget {
  final String text;
  final double thickness;
  final double fontSize;
  final Color lineColor;
  final Color textColor;

  const LineWithText({
    super.key, 
    required this.text,
    this.thickness = 1.0,
    this.fontSize = 16.0,
    this.lineColor = Colors.grey,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: thickness,
              color: lineColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: thickness,
              color: lineColor,
            ),
          ),
        ],
      ),
    );
  }
}
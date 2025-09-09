import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  Color backgroundColor;
  Color textColor;
  Function onclick;
  String buttonName;
  AppButton({
    super.key,
    required this.buttonName,
    required this.onclick,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onclick();
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        height: 50,

        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(fontWeight: FontWeight.w800, color: textColor),
          ),
        ),
      ),
    );
  }
}

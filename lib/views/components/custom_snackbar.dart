import 'package:flutter/material.dart';

class CustomSnackBar {
  String content;
  Color backgroundColor;

  CustomSnackBar({required this.content, required this.backgroundColor});

  SnackBar show() {
    return SnackBar(
      content: Text(content),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 1),
    );
  }
}

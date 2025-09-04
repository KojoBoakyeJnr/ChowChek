import 'package:chowchek/utils/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
// class SnackBar customSnackBar {
//   String content;
//   Color backgroundColor;
//   CustomSnackbar({
//     super.key,
//     required this.content,
//     required this.backgroundColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SnackBar(
//       content: Text(content, style: TextStyle(color: AppColors.primaryWhite)),
//       backgroundColor: backgroundColor,
//       duration: Duration(seconds: 1),
//     );
//   }
// }

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

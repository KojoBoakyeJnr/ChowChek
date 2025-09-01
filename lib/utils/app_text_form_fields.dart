import 'package:chowchek/utils/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextFormFields extends StatefulWidget {
  String hintText;
  TextEditingController controller;
  bool obscureText;
  Icon leading;
  Color fill;
  AppTextFormFields({
    super.key,
    required this.controller,
    this.hintText = "",
    this.obscureText = false,
    this.leading = const Icon(null),
    this.fill = Colors.white,
  });

  @override
  State<AppTextFormFields> createState() => _AppTextFormFieldsState();
}

class _AppTextFormFieldsState extends State<AppTextFormFields> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 60,
      child: TextFormField(
        obscureText: widget.obscureText,
        cursorColor: const Color.fromARGB(255, 144, 177, 234),
        controller: widget.controller,
        style: TextStyle(
          color: AppColors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),

        decoration: InputDecoration(
          prefixIcon: widget.leading,
          enabled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: const Color.fromARGB(255, 144, 177, 234),
            ),
          ),

          filled: true,
          fillColor: widget.fill,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),

          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppColors.primaryAsh, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:flutter/material.dart';

class ResultsEmptyState extends StatelessWidget {
  const ResultsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 350,
        height: 70,
        decoration: BoxDecoration(
          color: AppColors().lightRed,
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: AppColors.primaryRed,
            ),
            AppStrings.notFoundErrorMessage,
          ),
        ),
      ),
    );
  }
}

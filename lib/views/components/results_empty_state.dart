import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:flutter/material.dart';

class ResultsEmptyState extends StatelessWidget {
  const ResultsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors().lightRed,
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Center(
        child: Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: AppColors.primaryRed,
                ),
                AppStrings.notFoundErrorMessage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

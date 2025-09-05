import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_images.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BlacklistedMealTile extends StatelessWidget {
  final String mealName;
  final double totalFat;
  final double saturatedFat;
  final double sugar;
  final double salt;
  final double cholestrol;
  Widget delete;

  BlacklistedMealTile({
    super.key,
    required this.mealName,
    required this.totalFat,
    required this.saturatedFat,
    required this.sugar,
    required this.salt,
    required this.cholestrol,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.primaryRed,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meal Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  mealName,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryWhite,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              //remove widget
              delete,
            ],
          ),
          const SizedBox(height: 12),

          // Nutrient Info Wrap
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _buildNutrientItem(
                AppImages.totalFat,
                '${totalFat.toStringAsFixed(1)}g',
              ),
              _buildNutrientItem(
                AppImages.saturatedFat,
                '${saturatedFat.toStringAsFixed(1)}g',
              ),
              _buildNutrientItem(
                AppImages.sugar,
                '${sugar.toStringAsFixed(1)}g',
              ),
              _buildNutrientItem(
                AppImages.salt,
                '${salt.toStringAsFixed(1)}mg',
              ),
              _buildNutrientItem(
                AppImages.cholestrol,
                '${cholestrol.toStringAsFixed(1)}mg',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientItem(String iconPath, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(iconPath, width: 20, height: 20),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(color: AppColors.primaryWhite, fontSize: 14),
        ),
      ],
    );
  }
}

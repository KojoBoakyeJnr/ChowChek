import 'package:chowchek/utils/app_images.dart';
import 'package:flutter/material.dart';

class BlacklistedMealTile extends StatelessWidget {
  final String mealName;
  final double totalFat;
  final double saturatedFat;
  final double sugar;
  final double salt;
  final double cholestrol;

  const BlacklistedMealTile({
    super.key,
    required this.mealName,
    required this.totalFat,
    required this.saturatedFat,
    required this.sugar,
    required this.salt,
    required this.cholestrol,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 244, 81, 70),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meal Name
          Text(
            mealName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
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
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}

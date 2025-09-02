import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_images.dart';
import 'package:flutter/material.dart';

class NutrientResult extends StatelessWidget {
  const NutrientResult({super.key});

  Widget _nutrientRow({
    required String imagePath,
    required String label,
    required String amount,
    required String percentage,
    Color? pillColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(width: 30, height: 30, child: Image.asset(imagePath)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(amount, style: const TextStyle(fontSize: 15)),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: pillColor ?? Colors.green.shade100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              percentage,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Yam + Chicken",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
            ],
          ),

          const SizedBox(height: 12),
          _nutrientRow(
            imagePath: AppImages.totalFat,
            label: "Total Fat",
            amount: "30g",
            percentage: "80%",
            pillColor: Colors.orange.shade100,
          ),
          _nutrientRow(
            imagePath: AppImages.saturatedFat,
            label: "Saturated Fat",
            amount: "30g",
            percentage: "80%",
            pillColor: Colors.blue.shade100,
          ),
          _nutrientRow(
            imagePath: AppImages.salt,
            label: "Sodium",
            amount: "30g",
            percentage: "80%",
            pillColor: Colors.green.shade100,
          ),
          _nutrientRow(
            imagePath: AppImages.sugar,
            label: "Sugar",
            amount: "30g",
            percentage: "80%",
            pillColor: Colors.brown.shade100,
          ),
          _nutrientRow(
            imagePath: AppImages.cholestrol,
            label: "Cholesterol",
            amount: "30g",
            percentage: "80%",
            pillColor: Colors.red.shade100,
          ),
        ],
      ),
    );
  }
}

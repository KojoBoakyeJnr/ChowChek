import 'package:chowchek/models/blacklist_save_buttons.dart';
import 'package:chowchek/models/nutrient_row.dart';
import 'package:chowchek/providers/nutrient_check_provider.dart';
import 'package:chowchek/providers/saved_meals_provider.dart';
import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NutrientResult extends StatefulWidget {
  const NutrientResult({super.key});

  @override
  State<NutrientResult> createState() => _NutrientResultState();
}

class _NutrientResultState extends State<NutrientResult> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<
      NutrientCheckProvider,
      UserDetailsProvider,
      SavedMealsProvider
    >(
      builder:
          (
            context,
            modelNutrients,
            modelUserDetails,
            modelSavedMeals,
            child,
          ) => Container(
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
                    Expanded(
                      child: Text(
                        modelNutrients.providerMealDetails.combinationName,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          color: AppColors.primaryWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                NutrientRow(
                  imagePath: AppImages.totalFat,
                  label: "Total Fat",
                  amount:
                      "${modelNutrients.providerMealDetails.totalFat.toStringAsFixed(1)}g",

                  percentage:
                      "${((modelNutrients.providerMealDetails.totalFat / (modelUserDetails.nutrientLoggedLimits["Total Fat"] ?? 1)) * 100).toStringAsFixed(1)}%",
                  pillColor: Colors.orange.shade100,
                ),
                NutrientRow(
                  imagePath: AppImages.saturatedFat,
                  label: "Saturated Fat",
                  amount:
                      "${modelNutrients.providerMealDetails.saturatedFat.toStringAsFixed(1)}g",
                  percentage:
                      "${((modelNutrients.providerMealDetails.saturatedFat / (modelUserDetails.nutrientLoggedLimits["Sat. Fat"] ?? 1)) * 100).toStringAsFixed(1)}%",
                  pillColor: Colors.blue.shade100,
                ),
                NutrientRow(
                  imagePath: AppImages.salt,
                  label: "Sodium",
                  amount:
                      "${modelNutrients.providerMealDetails.sodium.toStringAsFixed(1)}mg",
                  percentage:
                      "${((modelNutrients.providerMealDetails.sodium / (modelUserDetails.nutrientLoggedLimits["Sodium"] ?? 1)) * 100).toStringAsFixed(1)}%",
                  pillColor: Colors.green.shade100,
                ),
                NutrientRow(
                  imagePath: AppImages.sugar,
                  label: "Sugar",
                  amount:
                      "${modelNutrients.providerMealDetails.sugar.toStringAsFixed(1)}g",
                  percentage:
                      "${((modelNutrients.providerMealDetails.sugar / (modelUserDetails.nutrientLoggedLimits["Sugar"] ?? 1)) * 100).toStringAsFixed(1)}%",
                  pillColor: Colors.brown.shade100,
                ),
                NutrientRow(
                  imagePath: AppImages.cholestrol,
                  label: "Cholesterol",
                  amount:
                      "${modelNutrients.providerMealDetails.cholestrol.toStringAsFixed(1)}mg",
                  percentage:
                      "${((modelNutrients.providerMealDetails.cholestrol / (modelUserDetails.nutrientLoggedLimits["Cholesterol"] ?? 1)) * 100).toStringAsFixed(1)}%",
                  pillColor: Colors.red.shade100,
                ),

                BlacklistSaveButtons(),
              ],
            ),
          ),
    );
  }
}

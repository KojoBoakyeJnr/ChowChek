import 'package:chowchek/models/blacklist_save_buttons.dart';
import 'package:chowchek/models/nutrient_row.dart';
import 'package:chowchek/providers/nutrient_check_provider.dart';
import 'package:chowchek/providers/saved_meals_provider.dart';
import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_images.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NutrientResult extends StatefulWidget {
  const NutrientResult({super.key});

  @override
  State<NutrientResult> createState() => _NutrientResultState();
}

class _NutrientResultState extends State<NutrientResult> {
  bool showWarning = true;
  String percentString(double value, dynamic limitRaw) {
    final limit = (limitRaw is num) ? limitRaw.toDouble() : 0.0;
    if (limit <= 0.0) return "0.0%";
    final percentage = (value / limit) * 100.0;
    return "${percentage.toStringAsFixed(1)}%";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<
      NutrientCheckProvider,
      UserDetailsProvider,
      SavedMealsProvider
    >(
      builder: (
        context,
        modelNutrients,
        modelUserDetails,
        modelSavedMeals,
        child,
      ) {
        // recorded values (from meal)

        final totalFatValue = modelNutrients.providerMealDetails.totalFat;
        final satFatValue = modelNutrients.providerMealDetails.saturatedFat;
        final sodiumValue = modelNutrients.providerMealDetails.sodium;
        final sugarValue = modelNutrients.providerMealDetails.sugar;
        final cholesterolValue = modelNutrients.providerMealDetails.cholestrol;

        // limits (from user details -> logged)

        final totalFatLimit =
            modelUserDetails.nutrientLoggedLimits[AppStrings.totalfatKey];
        final satFatLimit =
            modelUserDetails.nutrientLoggedLimits[AppStrings.satFatKey];
        final sodiumLimit =
            modelUserDetails.nutrientLoggedLimits[AppStrings.sodiumKey];
        final sugarLimit =
            modelUserDetails.nutrientLoggedLimits[AppStrings.sugarKey];
        final cholesterolLimit =
            modelUserDetails.nutrientLoggedLimits[AppStrings.cholesterolKey];

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
              //----Warning/Feedback-----//
              (showWarning == true)
                  ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 20,
                      left: 10,
                      right: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadiusDirectional.circular(10),
                      ),
                      width: 350,
                      height: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "⚠️ This meal is high in 2 nutrients",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 226, 100, 4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Cholesterol in this meal exceeds your daily limit.",
                            style: TextStyle(
                              fontSize: 10,
                              color: const Color.fromARGB(255, 93, 93, 93),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  : Container(),

              // title
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

              // Total Fat
              NutrientRow(
                imagePath: AppImages.totalFat,
                label: AppStrings.totalfat,
                amount: "${totalFatValue.toStringAsFixed(1)}g",
                percentage: percentString(totalFatValue, totalFatLimit),
                pillColor: Colors.orange.shade100,
              ),

              // Saturated Fat
              NutrientRow(
                imagePath: AppImages.saturatedFat,
                label: AppStrings.satFat,
                amount: "${satFatValue.toStringAsFixed(1)}g",
                percentage: percentString(satFatValue, satFatLimit),
                pillColor: Colors.blue.shade100,
              ),

              // Sodium
              NutrientRow(
                imagePath: AppImages.salt,
                label: AppStrings.sodium,
                amount: "${sodiumValue.toStringAsFixed(1)}mg",
                percentage: percentString(sodiumValue, sodiumLimit),
                pillColor: Colors.green.shade100,
              ),

              // Sugar
              NutrientRow(
                imagePath: AppImages.sugar,
                label: AppStrings.sugar,
                amount: "${sugarValue.toStringAsFixed(1)}g",
                percentage: percentString(sugarValue, sugarLimit),
                pillColor: Colors.brown.shade100,
              ),

              // Cholesterol
              NutrientRow(
                imagePath: AppImages.cholestrol,
                label: AppStrings.cholesterol,
                amount: "${cholesterolValue.toStringAsFixed(1)}mg",
                percentage: percentString(cholesterolValue, cholesterolLimit),
                pillColor: Colors.red.shade100,
              ),

              const BlacklistSaveButtons(),
            ],
          ),
        );
      },
    );
  }
}

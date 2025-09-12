import 'package:chowchek/services/evaluator.dart';
import 'package:chowchek/views/components/blacklist_save_buttons.dart';
import 'package:chowchek/views/components/nutrient_row.dart';
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
        final meal = modelNutrients.providerMealDetails;
        final limit = modelUserDetails.nutrientLoggedLimits;
        final evaluate = Evaluator().evaluate(meal, limit);
        final percentages = evaluate["percentages"] as Map<String, double>;
        final warningTitle = evaluate["warningTitle"] as String;
        final warningDetail = evaluate["warningDetails"] as String;
        final totalFatValue = meal.totalFat;
        final satFatValue = meal.saturatedFat;
        final sodiumValue = meal.sodium;
        final sugarValue = meal.sugar;
        final cholesterolValue = meal.cholestrol;

        return Container(
          decoration: BoxDecoration(
            color: AppColors.primaryGreen,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //----Warning/Feedback-----//
              (warningTitle != "" && warningDetail != "")
                  ? Container(
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: BorderRadiusDirectional.circular(10),
                    ),
                    width: double.infinity,
                    height: 40,
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              warningTitle,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 226, 100, 4),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              warningDetail,
                              style: TextStyle(
                                fontSize: 10,
                                color: const Color.fromARGB(255, 93, 93, 93),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  : Container(child: null),
              const SizedBox(height: 16),
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

              const SizedBox(height: 16),

              // Total Fat
              NutrientRow(
                imagePath: AppImages.totalFat,
                label: AppStrings.totalfat,
                amount: "${totalFatValue.toStringAsFixed(1)}g",
                percentage:
                    "${percentages['totalFatKey']!.toStringAsFixed(1)}%",
                pillColor: Colors.orange.shade100,
              ),

              // Saturated Fat
              NutrientRow(
                imagePath: AppImages.saturatedFat,
                label: AppStrings.satFat,
                amount: "${satFatValue.toStringAsFixed(1)}g",
                percentage: "${percentages['satFatKey']!.toStringAsFixed(1)}%",
                pillColor: Colors.blue.shade100,
              ),

              // Sodium
              NutrientRow(
                imagePath: AppImages.salt,
                label: AppStrings.sodium,
                amount: "${sodiumValue.toStringAsFixed(1)}mg",
                percentage: "${percentages['sodiumKey']!.toStringAsFixed(1)}%",
                pillColor: Colors.green.shade100,
              ),

              // Sugar
              NutrientRow(
                imagePath: AppImages.sugar,
                label: AppStrings.sugar,
                amount: "${sugarValue.toStringAsFixed(1)}g",
                percentage: "${percentages['sugarKey']!.toStringAsFixed(1)}%",
                pillColor: Colors.brown.shade100,
              ),

              // Cholesterol
              NutrientRow(
                imagePath: AppImages.cholestrol,
                label: AppStrings.cholesterol,
                amount: "${cholesterolValue.toStringAsFixed(1)}mg",
                percentage:
                    "${percentages['cholesterolKey']!.toStringAsFixed(1)}%",
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

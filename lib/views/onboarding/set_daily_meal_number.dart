import 'package:chowchek/models/quantity_selector.dart';
import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:chowchek/utils/routes.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetDailyMealNumber extends StatefulWidget {
  const SetDailyMealNumber({super.key});

  @override
  State<SetDailyMealNumber> createState() => _SetDailyMealNumberState();
}

final GlobalKey<QuantitySelectorState> mealNumber =
    GlobalKey<QuantitySelectorState>();

void saveMealNumberToSharedPref() async {
  int avgMealNumber = mealNumber.currentState?.quantity ?? 3;
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setInt(AppStrings.mealNumberKey, avgMealNumber);
}

class _SetDailyMealNumberState extends State<SetDailyMealNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      AppStrings.onAverageHowMany,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(color: AppColors.primaryWhite),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppStrings.dailyAverageExplainer,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 16),
                    QuantitySelector(key: mealNumber),
                  ],
                ),
                SizedBox(height: 16),
                AppButton(
                  buttonName: AppStrings.looksGood,
                  onclick: () {
                    saveMealNumberToSharedPref();
                    Navigator.of(context).pushNamed(AppRoutes.nutrientGoal);
                  },
                  backgroundColor: AppColors.primaryWhite,
                  textColor: AppColors.deepGreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

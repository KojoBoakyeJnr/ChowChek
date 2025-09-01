import 'package:chowchek/models/quantity_selector.dart';
import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';

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
  pref.setInt("mealNumber", avgMealNumber);
}

class _SetDailyMealNumberState extends State<SetDailyMealNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        AppStrings.onAverageHowMany,
                        style: TextStyle(fontSize: 50, height: 1),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        AppStrings.dailyAverageExplainer,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: QuantitySelector(key: mealNumber),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AppButton(
                  buttonName: AppStrings.looksGood,
                  onclick: () {
                    saveMealNumberToSharedPref();
                    Navigator.of(context).pushNamed("nutrientGoal");
                  },
                  backgroundColor: AppColors.primaryWhite,
                  textColor: AppColors.deepGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

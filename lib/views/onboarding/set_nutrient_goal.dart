import 'dart:convert';

import 'package:chowchek/views/components/nutrient_meter.dart';
import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:chowchek/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetNutrientGoal extends StatefulWidget {
  const SetNutrientGoal({super.key});

  @override
  State<SetNutrientGoal> createState() => _SetNutrientGoalState();
}

class _SetNutrientGoalState extends State<SetNutrientGoal> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserDetailsProvider>(context, listen: false).loadAllFromPrefs();
  }

  void addNutrientLimitsToSharedPref() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(
      AppStrings.nutrientLimitKey,
      jsonEncode(
        Provider.of<UserDetailsProvider>(
          // ignore: use_build_context_synchronously
          context,
          listen: false,
        ).nutrientLoggedLimits,
      ),
    );
  }

  void setLoginStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(AppStrings.loginKey, true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(
      builder:
          (context, model, child) => Scaffold(
            backgroundColor: AppColors.primaryWhite,
            appBar: AppBar(backgroundColor: AppColors.primaryWhite),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          "${AppStrings.hello}  ${model.userName}",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: 16),
                        Text(
                          textAlign: TextAlign.center,
                          AppStrings.setDailyNutrientsLimit,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 16),
                        NutrientMeter(),
                        SizedBox(height: 16),
                        Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                          AppStrings.customizeYourDaily,
                        ),
                      ],
                    ),

                    AppButton(
                      buttonName: AppStrings.finish,
                      onclick: () {
                        Navigator.of(context).pushNamed(AppRoutes.homePage);
                        addNutrientLimitsToSharedPref();
                        setLoginStatus();
                      },
                      backgroundColor: AppColors.primaryGreen,
                      textColor: AppColors.primaryWhite,
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

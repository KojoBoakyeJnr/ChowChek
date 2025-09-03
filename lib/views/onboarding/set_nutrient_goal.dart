import 'dart:convert';

import 'package:chowchek/models/nutrient_meter.dart';
import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
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
      "nutrientLimits",
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
    pref.setBool("isLoggedIn", true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(
      builder:
          (context, model, child) => Scaffold(
            backgroundColor: AppColors.primaryWhite,
            appBar: AppBar(backgroundColor: AppColors.primaryWhite),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,

                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: "Aeonik",
                                  fontSize: 50,
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(text: "Howdy?👋\n"),
                                  TextSpan(
                                    text: model.userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                            AppStrings.customizeYourDaily,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppStrings.setDailyNutrientsLimit,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                  ),
                                ),
                              ),
                              NutrientMeter(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppButton(
                    buttonName: AppStrings.finish,
                    onclick: () {
                      Navigator.of(context).pushNamed("homePage");
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
    );
  }
}

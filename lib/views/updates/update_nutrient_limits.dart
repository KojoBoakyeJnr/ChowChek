import 'package:chowchek/utils/routes.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:chowchek/views/components/nutrient_meter.dart';
import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateNutrientLimits extends StatefulWidget {
  const UpdateNutrientLimits({super.key});

  @override
  State<UpdateNutrientLimits> createState() => _UpdateNutrientLimitsState();
}

class _UpdateNutrientLimitsState extends State<UpdateNutrientLimits> {
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

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(
      builder:
          (context, model, child) => Scaffold(
            backgroundColor: AppColors.primaryWhite,
            appBar: AppBar(backgroundColor: AppColors.primaryWhite),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Flexible(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    AppStrings.updateDailyNutrientsLimit,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        NutrientMeter(),
                      ],
                    ),

                    AppButton(
                      buttonName: AppStrings.update,
                      onclick: () {
                        Navigator.of(context).pushNamed(AppRoutes.homePage);
                        addNutrientLimitsToSharedPref();
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

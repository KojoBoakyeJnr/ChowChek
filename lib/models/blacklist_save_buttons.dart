import 'dart:convert';

import 'package:chowchek/models/custom_snackbar.dart';
import 'package:chowchek/providers/blacklisted_meals_provider.dart';
import 'package:chowchek/providers/nutrient_check_provider.dart';
import 'package:chowchek/providers/saved_meals_provider.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlacklistSaveButtons extends StatelessWidget {
  const BlacklistSaveButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NutrientCheckProvider>(
      builder:
          (context, modelNutrients, child) => Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(
                          content: "meal has been blacklisted",
                          backgroundColor: Colors.red,
                        ).show(),
                      );
                      Provider.of<BlacklistedMealsProvider>(
                        context,
                        listen: false,
                      ).blacklistedMeals.add(
                        modelNutrients.providerMealDetails.toMap(),
                      );

                      final blacklistedList =
                          Provider.of<BlacklistedMealsProvider>(
                            // ignore: use_build_context_synchronously
                            context,
                            listen: false,
                          ).blacklistedMeals;

                      final SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setString(
                        "blacklistedMeals",
                        jsonEncode(blacklistedList),
                      );
                    },
                    icon: Text("❌", style: TextStyle(fontSize: 20)),

                    tooltip: "Blacklist meal",
                  ),
                ),
              ),
              Container(
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar(
                        content: "added to saved meals",
                        backgroundColor: AppColors.primaryGreen,
                      ).show(),
                    );
                    Provider.of<SavedMealsProvider>(context, listen: false)
                        .savedMeals
                        .add(modelNutrients.providerMealDetails.toMap());

                    final SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    final savedList =
                        Provider.of<SavedMealsProvider>(
                          context,
                          listen: false,
                        ).savedMeals;

                    await pref.setString("savedMeals", jsonEncode(savedList));
                  },
                  icon: Text("💚", style: TextStyle(fontSize: 20)),
                  tooltip: "Save meal",
                ),
              ),
            ],
          ),
    );
  }
}

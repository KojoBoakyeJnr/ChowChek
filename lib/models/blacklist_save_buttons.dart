import 'dart:convert';

import 'package:chowchek/main.dart';
import 'package:chowchek/providers/blacklisted_meals_provider.dart';
import 'package:chowchek/providers/nutrient_check_provider.dart';
import 'package:chowchek/providers/saved_meals_provider.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/views/main/home_page.dart';
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
                      Provider.of<BlacklistedMealsProvider>(
                        context,
                        listen: false,
                      ).blacklistedMeals.add(
                        modelNutrients.providerMealDetails.toMap(),
                      );

                      final SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      final blacklistedList =
                          Provider.of<BlacklistedMealsProvider>(
                            context,
                            listen: false,
                          ).blacklistedMeals;

                      await pref.setString(
                        "blacklistedMeals",
                        jsonEncode(blacklistedList),
                      );
                      homePageKey.currentState?.changePage(2);
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

                    homePageKey.currentState?.changePage(1);
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

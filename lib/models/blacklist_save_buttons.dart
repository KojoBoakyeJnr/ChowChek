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
                      //add meal to blacklisted list
                      Provider.of<BlacklistedMealsProvider>(
                        context,
                        listen: false,
                      ).addMealToBlacklisted(
                        modelNutrients.providerMealDetails.toMap(),
                      );

                      //add current state of saved list to another temporal list to encode
                      final blacklistedList =
                          Provider.of<BlacklistedMealsProvider>(
                            context,
                            listen: false,
                          ).blacklistedMeals;

                      //instantiate shared pref
                      final SharedPreferences pref =
                          await SharedPreferences.getInstance();

                      //add decoded current state stringified to pref
                      pref.setString(
                        "blacklistedMeals",
                        jsonEncode(blacklistedList),
                      );

                      //display snack bar
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(
                          content: "meal has been blacklisted",
                          backgroundColor: Colors.red,
                        ).show(),
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
                    //add meal to saved list
                    Provider.of<SavedMealsProvider>(
                      context,
                      listen: false,
                    ).addMealToSaved(
                      modelNutrients.providerMealDetails.toMap(),
                    );

                    //add current state of saved list to another temporal list to encode
                    final savedList =
                        Provider.of<SavedMealsProvider>(
                          context,
                          listen: false,
                        ).savedMeals;

                    //instantiate shared pref
                    final SharedPreferences pref =
                        await SharedPreferences.getInstance();

                    //add decoded current state stringified to pref
                    pref.setString("savedMeals", jsonEncode(savedList));

                    //display snack bar
                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar(
                        content: "added to saved meals",
                        backgroundColor: AppColors.primaryGreen,
                      ).show(),
                    );
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

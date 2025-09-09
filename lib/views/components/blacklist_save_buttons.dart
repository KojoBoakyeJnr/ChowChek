import 'dart:convert';
import 'package:chowchek/views/components/custom_snackbar.dart';
import 'package:chowchek/providers/blacklisted_meals_provider.dart';
import 'package:chowchek/providers/nutrient_check_provider.dart';
import 'package:chowchek/providers/saved_meals_provider.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlacklistSaveButtons extends StatefulWidget {
  const BlacklistSaveButtons({super.key});
  @override
  State<BlacklistSaveButtons> createState() => _BlacklistSaveButtonsState();
}

class _BlacklistSaveButtonsState extends State<BlacklistSaveButtons> {
  void blacklistMeal(context) async {
    //add meal to blacklisted list
    Provider.of<BlacklistedMealsProvider>(
      context,
      listen: false,
    ).addMealToBlacklisted(
      Provider.of<NutrientCheckProvider>(
        context,
        listen: false,
      ).providerMealDetails.toMap(),
    );
    //add current state of saved list to another temporal list to encode
    final blacklistedList =
        Provider.of<BlacklistedMealsProvider>(
          context,
          listen: false,
        ).blacklistedMeals;

    //instantiate shared pref
    final SharedPreferences pref = await SharedPreferences.getInstance();

    //add decoded current state (stringified) to pref
    await pref.setString(
      AppStrings.blacklistedMealsKey,
      jsonEncode(blacklistedList),
    );

    //display snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(
        content: AppStrings.mealBlacklistedMessage,
        backgroundColor: AppColors.primaryRed,
      ).show(),
    );
  }

  void saveMeal(context) async {
    //add meal to saved list
    Provider.of<SavedMealsProvider>(context, listen: false).addMealToSaved(
      Provider.of<NutrientCheckProvider>(
        context,
        listen: false,
      ).providerMealDetails.toMap(),
    );

    //add current state of saved list to another temporal list to encode
    final savedList =
        Provider.of<SavedMealsProvider>(context, listen: false).savedMeals;

    //instantiate shared pref
    final SharedPreferences pref = await SharedPreferences.getInstance();

    //add decoded current state stringified to pref
    await pref.setString(AppStrings.savedMealsKey, jsonEncode(savedList));

    //display snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(
        content: AppStrings.mealSavedMessage,
        backgroundColor: AppColors.primaryGreen,
      ).show(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ChildButton(
          onButtonPressed: () => blacklistMeal(context),
          icon: AppStrings.blacklistIcon,
          tooltipMessage: AppStrings.blacklistMealTooltip,
        ),
        ChildButton(
          onButtonPressed: () => saveMeal(context),
          icon: AppStrings.saveIcon,
          tooltipMessage: AppStrings.saveMealTooltip,
        ),
      ],
    );
  }
}

class ChildButton extends StatelessWidget {
  final VoidCallback? onButtonPressed;
  final String icon;
  final String tooltipMessage;
  const ChildButton({
    super.key,
    required this.onButtonPressed,
    required this.icon,
    required this.tooltipMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 50,
        decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          onPressed: onButtonPressed,
          icon: Text(icon, style: const TextStyle(fontSize: 20)),
          tooltip: tooltipMessage,
        ),
      ),
    );
  }
}

import 'package:chowchek/views/components/remove_confirmation.dart';
import 'package:chowchek/views/components/saved_meal_tile.dart';
import 'package:chowchek/providers/saved_meals_provider.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});
  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SavedMealsProvider>(
      builder:
          (context, model, child) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: ListView.builder(
                itemCount: model.savedMeals.length,
                itemBuilder: (context, int index) {
                  return SavedMealTile(
                    remove: IconButton(
                      onPressed: () {
                        RemoveConfirmation(
                          index: index,
                          remove: () {
                            Provider.of<SavedMealsProvider>(
                              context,
                              listen: false,
                            ).removeMealFromSaved(index);
                          },
                        ).show(context);
                      },
                      icon: Icon(Icons.delete, color: AppColors.primaryWhite),
                    ),
                    mealName: model.savedMeals[index]["combinationName"],
                    totalFat: model.savedMeals[index]["totalFat"],
                    saturatedFat: model.savedMeals[index]["saturatedFat"],
                    sugar: model.savedMeals[index]["sugar"],
                    salt: model.savedMeals[index]["sodium"],
                    cholestrol: model.savedMeals[index]["cholestrol"],
                  );
                },
              ),
            ),
          ),
    );
  }
}

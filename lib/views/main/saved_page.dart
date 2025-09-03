import 'package:chowchek/models/saved_meal_tile.dart';
import 'package:chowchek/providers/saved_meals_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SavedMealsProvider>(
        context,
        listen: false,
      ).loadSavedMealsFromPrefs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SavedMealsProvider>(
      builder:
          (context, model, child) => SafeArea(
            child: ListView.builder(
              itemCount: model.savedMeals.length,
              itemBuilder: (context, int index) {
                return SavedMealTile(
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
    );
  }
}

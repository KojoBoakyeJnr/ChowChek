import 'package:chowchek/model/meal_log.dart';
import 'package:flutter/material.dart';

class NutrientCheckProvider extends ChangeNotifier {
  MealLog providerMealDetails = MealLog(
    combinationName: "",
    totalFat: 0,
    saturatedFat: 0,
    sugar: 0,
    sodium: 0,
    cholestrol: 0,
  );

  void setMeal(meal) {
    providerMealDetails = meal;
    notifyListeners();
  }

  NutrientCheckProvider();
}

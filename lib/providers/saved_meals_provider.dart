import 'dart:convert';

import 'package:chowchek/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedMealsProvider extends ChangeNotifier {
  SavedMealsProvider() {
    loadSavedMealsFromPrefs();
  }

  Future<void> loadSavedMealsFromPrefs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final savedMealsString = pref.getString(AppStrings.savedMealsKey);
    if (savedMealsString == null) {
      savedMeals = [];
    } else {
      savedMeals = List<Map<String, dynamic>>.from(
        jsonDecode(savedMealsString),
      );
    }
    notifyListeners();
  }

  void addMealToSaved(Map meal) {
    savedMeals.add(meal);
  }

  void removeMealFromSaved(int index) async {
    savedMeals.removeAt(index);
    notifyListeners();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(AppStrings.savedMealsKey, jsonEncode(savedMeals));
  }

  List<Map> savedMeals = [];
}

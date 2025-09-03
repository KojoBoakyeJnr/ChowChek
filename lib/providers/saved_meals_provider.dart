import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedMealsProvider extends ChangeNotifier {
  SavedMealsProvider() {
    loadSavedMealsFromPrefs();
  }

  Future<void> loadSavedMealsFromPrefs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final savedMealsString = pref.getString("savedMeals");
    if (savedMealsString == null) {
      savedMeals = [];
    } else {
      savedMeals = List<Map<String, dynamic>>.from(
        jsonDecode(savedMealsString),
      );
    }
    notifyListeners();
  }

  List<Map> savedMeals = [];
}

import 'dart:convert';
import 'package:chowchek/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlacklistedMealsProvider extends ChangeNotifier {
  BlacklistedMealsProvider() {
    loadBlacklistedMealsFromPrefs();
  }

  Future<void> loadBlacklistedMealsFromPrefs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final blacklistedMealsString = pref.getString(
      AppStrings.blacklistedMealsKey,
    );
    if (blacklistedMealsString == null) {
      blacklistedMeals = [];
    } else {
      blacklistedMeals = List<Map<String, dynamic>>.from(
        jsonDecode(blacklistedMealsString),
      );
    }
    notifyListeners();
  }

  void addMealToBlacklisted(Map meal) {
    blacklistedMeals.add(meal);
  }

  void removeMealFromBlacklisted(int index) async {
    blacklistedMeals.removeAt(index);
    notifyListeners();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(
      AppStrings.blacklistedMealsKey,
      jsonEncode(blacklistedMeals),
    );
  }

  List<Map> blacklistedMeals = [];
}

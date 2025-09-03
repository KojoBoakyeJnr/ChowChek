import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlacklistedMealsProvider extends ChangeNotifier {
  BlacklistedMealsProvider() {
    loadBlacklistedMealsFromPrefs();
  }

  Future<void> loadBlacklistedMealsFromPrefs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final blacklistedMealsString = pref.getString("blacklistedMeals");
    if (blacklistedMealsString == null) {
      blacklistedMeals = [];
    } else {
      blacklistedMeals = List<Map<String, dynamic>>.from(
        jsonDecode(blacklistedMealsString),
      );
    }
    notifyListeners();
  }

  List<Map> blacklistedMeals = [];
}

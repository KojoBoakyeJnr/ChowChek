import 'dart:convert';
import 'package:chowchek/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsProvider extends ChangeNotifier {
  String userName = "";
  int averageMealsPerDay = 1;
  bool isLoggedIn = false;
  Map<String, double> nutrientLoggedLimits = {
    "Total Fat": 140,
    "Sat. Fat": 40,
    "Sodium": 4600,
    "Sugar": 50,
    "Cholesterol": 600,
  };

  UserDetailsProvider() {
    loadAllFromPrefs();
  }
  void loadAllFromPrefs() {
    loadNameFromSharedPref();
    loadMealNumberFromSHaredPref();
    loadLoginStatus();
    loadDailyNutrientsLimit();
  }

  void loadNameFromSharedPref() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString(AppStrings.usernameKey) ?? AppStrings.guest;
    notifyListeners();
  }

  void loadMealNumberFromSHaredPref() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    averageMealsPerDay = pref.getInt(AppStrings.mealNumberKey) ?? 3;
    notifyListeners();
  }

  void loadLoginStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isLoggedIn = pref.getBool(AppStrings.loginKey) ?? false;
    notifyListeners();
  }

  void loadDailyNutrientsLimit() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String nutrientsString = pref.getString(AppStrings.nutrientLimitKey) ?? "";
    Map nutrientsDynamic = jsonDecode(nutrientsString);
    nutrientLoggedLimits = nutrientsDynamic.map(
      (key, value) => MapEntry(key, (value as num).toDouble()),
    );
    notifyListeners();
  }
}

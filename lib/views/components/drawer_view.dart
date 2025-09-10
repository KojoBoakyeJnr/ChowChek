import 'package:chowchek/providers/blacklisted_meals_provider.dart';
import 'package:chowchek/providers/nutrient_check_provider.dart';
import 'package:chowchek/providers/saved_meals_provider.dart';
import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:chowchek/utils/routes.dart';
import 'package:chowchek/views/main/home_page.dart';
import 'package:chowchek/views/main/today_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  void setLoginStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(AppStrings.loginKey, false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        reverse: true,
        children: [
          ListTile(
            onTap: () {
              setLoginStatus();
              Navigator.of(context).pushNamed(AppRoutes.login);
            },
            leading: Icon(Icons.logout, color: AppColors.primaryRed),
            title: Text(
              AppStrings.logout,
              style: TextStyle(color: AppColors.primaryRed),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(AppRoutes.updateNutrientGoal);
            },
            leading: Icon(Icons.update_sharp, color: AppColors.black),
            title: Text(AppStrings.updateNutrientLimits),
          ),
        ],
      ),
    );
  }
}

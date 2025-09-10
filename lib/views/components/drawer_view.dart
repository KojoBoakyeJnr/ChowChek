import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:chowchek/utils/routes.dart';

import 'package:flutter/material.dart';

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

import 'package:chowchek/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  void setLoginStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLoggedIn", false);
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
              Navigator.of(context).pushNamed("login");
            },
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed("updateNutrientGoal");
            },
            leading: Icon(Icons.update_sharp, color: AppColors.black),
            title: Text("Update Nutrient Limit"),
          ),
        ],
      ),
    );
  }
}

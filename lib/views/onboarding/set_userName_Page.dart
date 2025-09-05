import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:chowchek/utils/app_text_form_fields.dart';
import 'package:chowchek/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetUsername extends StatefulWidget {
  const SetUsername({super.key});

  @override
  State<SetUsername> createState() => _SetUsernameState();
}

class _SetUsernameState extends State<SetUsername> {
  final TextEditingController _userNameController = TextEditingController();
  bool hasText = false;

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(() {
      if (_userNameController.text.isNotEmpty) {
        setState(() {
          hasText = true;
        });
      } else {
        setState(() {
          hasText = false;
        });
      }
    });
  }

  void saveNameToSharedPref() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(AppStrings.usernameKey, _userNameController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        AppStrings.whatName,

                        style: TextStyle(
                          fontSize: 50,
                          height: 1,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: AppTextFormFields(
                        controller: _userNameController,
                        leading: Icon(Icons.person_2_outlined),
                        hintText: AppStrings.usernameHintText,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AppButton(
                  buttonName: AppStrings.soundsGreat,
                  onclick: () {
                    saveNameToSharedPref();
                    Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.setAverageDailyMealCount);
                  },
                  backgroundColor:
                      (hasText) ? AppColors.primaryWhite : AppColors.primaryAsh,
                  textColor:
                      (hasText)
                          ? AppColors.primaryGreen
                          : AppColors.primaryWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

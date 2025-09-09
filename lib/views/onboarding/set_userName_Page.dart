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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      AppStrings.whatName,
                      style: TextStyle(
                        color: AppColors.primaryWhite,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 16),
                    AppTextFormFields(
                      controller: _userNameController,
                      leading: Icon(Icons.person_2_outlined),
                      hintText: AppStrings.usernameHintText,
                    ),
                    SizedBox(height: 16),
                    AppButton(
                      buttonName: AppStrings.soundsGreat,
                      onclick: () {
                        saveNameToSharedPref();
                        Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.setAverageDailyMealCount);
                      },
                      backgroundColor:
                          (hasText)
                              ? AppColors.primaryWhite
                              : AppColors.primaryAsh,
                      textColor:
                          (hasText)
                              ? AppColors.primaryGreen
                              : AppColors.primaryWhite,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

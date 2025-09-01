import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(
      builder:
          (context, model, child) => Scaffold(
            backgroundColor: AppColors.primaryGreen,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 200.0, left: 20),
                    child: Text(
                      AppStrings.splashText,
                      style: TextStyle(fontSize: 90, height: 0.9),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: AppButton(
                      textColor: AppColors.primaryWhite,
                      backgroundColor: AppColors.deepGreen,
                      buttonName: AppStrings.getstarted,
                      onclick: () {
                        (model.isLoggedIn)
                            ? Navigator.of(context).pushNamed("homePage")
                            : Navigator.of(context).pushNamed("signUp");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

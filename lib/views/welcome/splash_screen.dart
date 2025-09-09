import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_images.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:chowchek/utils/routes.dart';
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
            backgroundColor: AppColors.primaryWhite,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 100,
                          child: Image.asset(AppImages.logo),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: AppButton(
                          textColor: AppColors.primaryWhite,
                          backgroundColor: AppColors.primaryGreen,
                          buttonName: AppStrings.getstarted,
                          onclick: () {
                            (model.isLoggedIn)
                                ? Navigator.of(
                                  context,
                                ).pushNamed(AppRoutes.homePage)
                                : Navigator.of(
                                  context,
                                ).pushNamed(AppRoutes.signUp);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

import 'package:chowchek/services/auth_service.dart';
import 'package:chowchek/views/components/loading_dialog.dart';
import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:chowchek/utils/app_text_form_fields.dart';
import 'package:chowchek/utils/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthPageSignup extends StatefulWidget {
  const AuthPageSignup({super.key});

  @override
  State<AuthPageSignup> createState() => _AuthPageSignupState();
}

class _AuthPageSignupState extends State<AuthPageSignup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool emailFilled = false;
  bool passwordFilled = false;
  String signUpErrorMessage = "";

  @override
  void initState() {
    super.initState();
    checkStatusOfInputField();
  }

  void checkStatusOfInputField() {
    _emailController.addListener(() {
      setInputFieldFillState(_emailController);
    });

    _passwordController.addListener(() {
      setInputFieldFillState(_passwordController);
    });
  }

  setInputFieldFillState(TextEditingController controller) {
    if (controller == _emailController) {
      setState(() {
        emailFilled = controller.text.isNotEmpty;
      });
    } else {
      setState(() {
        passwordFilled = controller.text.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // Expanded 1 → Top title (same style as Login)
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    AppStrings.signUp,
                    style: const TextStyle(
                      fontSize: 50,
                      color: AppColors.deepGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Expanded 2 → Form
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppTextFormFields(
                        inputType: TextInputType.emailAddress,
                        fill: AppColors.textFieldGray,
                        leading: Icon(Icons.email, color: AppColors.primaryAsh),
                        controller: _emailController,
                        hintText: AppStrings.email,
                      ),
                      const SizedBox(height: 16),
                      AppTextFormFields(
                        inputType: TextInputType.visiblePassword,
                        fill: AppColors.textFieldGray,
                        leading: Icon(
                          Icons.password,
                          color: AppColors.primaryAsh,
                        ),

                        obscureText: true,
                        controller: _passwordController,
                        hintText: AppStrings.password,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            signUpErrorMessage,
                            style: TextStyle(color: AppColors.primaryRed),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppButton(
                        textColor: AppColors.primaryWhite,
                        buttonName: AppStrings.createAccount,
                        onclick:
                            (emailFilled && passwordFilled)
                                ? () async {
                                  LoadingDialog().show(context);
                                  final response = await AuthService()
                                      .createAccount(
                                        _emailController,
                                        _passwordController,
                                      );

                                  setState(() {
                                    signUpErrorMessage = response;
                                  });

                                  LoadingDialog().pop(context);

                                  (response == "Success")
                                      ? Navigator.of(
                                        context,
                                      ).pushNamed(AppRoutes.setUserName)
                                      : null;
                                }
                                : () {
                                  null;
                                },
                        backgroundColor:
                            (emailFilled && passwordFilled)
                                ? AppColors.primaryGreen
                                : AppColors.primaryAsh,
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          text: AppStrings.alreadyHaveAnAccount,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(
                                        context,
                                      ).pushNamed(AppRoutes.login);
                                    },
                              text: AppStrings.login,
                              style: TextStyle(
                                color: AppColors.deepGreen,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Expanded 3 → Bottom tagline (same as Login style)
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.oneStepCloser,
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

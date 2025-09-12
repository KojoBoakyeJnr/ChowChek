import 'package:chowchek/services/auth_service.dart';
import 'package:chowchek/views/components/loading_dialog.dart';
import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:chowchek/utils/app_text_form_fields.dart';
import 'package:chowchek/utils/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPageLogin extends StatefulWidget {
  const AuthPageLogin({super.key});

  @override
  State<AuthPageLogin> createState() => _AuthPageLoginState();
}

class _AuthPageLoginState extends State<AuthPageLogin> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool emailFilled = false;
  bool passwordFilled = false;
  String loginErrorMessage = "";

  void setLoginStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(AppStrings.loginKey, true);
  }

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
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      AppStrings.login,
                      style: TextStyle(
                        fontSize: 50,
                        color: AppColors.deepGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          AppTextFormFields(
                            inputType: TextInputType.emailAddress,
                            fill: AppColors.textFieldGray,
                            leading: Icon(
                              Icons.email,
                              color: AppColors.primaryAsh,
                            ),
                            controller: _emailController,
                            hintText: AppStrings.email,
                          ),
                          SizedBox(height: 16),
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
                          SizedBox(height: 16),
                          SizedBox(
                            child: Row(
                              children: [
                                Text(
                                  loginErrorMessage,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: AppColors.primaryRed),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          AppButton(
                            textColor: AppColors.primaryWhite,
                            buttonName: AppStrings.continueButtontext,
                            onclick:
                                (emailFilled && passwordFilled)
                                    ? () async {
                                      LoadingDialog().show(context);
                                      final response = await AuthService()
                                          .verifyAccount(
                                            _emailController,
                                            _passwordController,
                                          );

                                      LoadingDialog().pop(context);

                                      if (response == "Success") {
                                        Navigator.of(
                                          context,
                                        ).pushNamed(AppRoutes.homePage);
                                        setLoginStatus();
                                      }

                                      setState(() {
                                        loginErrorMessage = response;
                                      });
                                    }
                                    : () {
                                      null;
                                    },
                            backgroundColor:
                                (emailFilled && passwordFilled)
                                    ? AppColors.primaryGreen
                                    : AppColors.primaryAsh,
                          ),
                          SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              text: AppStrings.newToChowChek,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                              ),
                              children: [
                                TextSpan(
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(
                                            context,
                                          ).pushNamed(AppRoutes.signUp);
                                        },
                                  text: AppStrings.registerAnAccount,
                                  style: TextStyle(
                                    color: AppColors.primaryGreen,

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
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppStrings.oneMealAtATime,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ],
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

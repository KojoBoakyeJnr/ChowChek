import 'package:chowchek/models/loading_dialog.dart';
import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:chowchek/utils/app_text_form_fields.dart';
import 'package:chowchek/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      if (_emailController.text.isNotEmpty) {
        setState(() {
          emailFilled = true;
        });
      } else {
        setState(() {
          emailFilled = false;
        });
      }
    });

    _passwordController.addListener(() {
      if (_passwordController.text.isNotEmpty) {
        setState(() {
          passwordFilled = true;
        });
      } else {
        passwordFilled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    AppStrings.login,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 30),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: AppTextFormFields(
                          fill: AppColors.textFieldGray,
                          leading: Icon(
                            Icons.email,
                            color: AppColors.primaryAsh,
                          ),
                          controller: _emailController,
                          hintText: AppStrings.email,
                        ),
                      ),
                      AppTextFormFields(
                        fill: AppColors.textFieldGray,
                        leading: Icon(
                          Icons.password,
                          color: AppColors.primaryAsh,
                        ),
                        obscureText: true,
                        controller: _passwordController,
                        hintText: AppStrings.password,
                      ),
                      SizedBox(
                        width: 350,

                        child: Text(
                          loginErrorMessage,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: AppColors.primaryRed),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AppButton(
                          textColor: AppColors.primaryWhite,
                          buttonName: AppStrings.continueButtontext,
                          onclick:
                              (emailFilled && passwordFilled)
                                  ? () async {
                                    _verifyAccount();
                                    setLoginStatus();
                                  }
                                  : () {
                                    null;
                                  },
                          backgroundColor:
                              (emailFilled && passwordFilled)
                                  ? AppColors.primaryGreen
                                  : AppColors.primaryAsh,
                        ),
                      ),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 250.0, left: 20),
                        child: Text(
                          AppStrings.oneMealAtATime,
                          style: TextStyle(fontSize: 50, height: 0.9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setLoginStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(AppStrings.loginKey, true);
  }

  void _verifyAccount() async {
    try {
      LoadingDialog().show(context);
      final auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed("homePage");
    } on FirebaseAuthException catch (error) {
      String errorMessage;

      switch (error.code) {
        case 'invalid-email':
          errorMessage = AppStrings.invalidEmail;
          break;
        case 'user-disabled':
          errorMessage = AppStrings.userDisabled;
          break;
        case 'user-not-found':
          errorMessage = AppStrings.userNotFound;
          break;
        case 'wrong-password':
          errorMessage = AppStrings.wrongPassword;
          break;
        case 'too-many-requests':
          errorMessage = AppStrings.tooManyRequests;
          break;
        case 'operation-not-allowed':
          errorMessage = AppStrings.operationNotAllowed;
          break;
        case 'network-request-failed':
          errorMessage = AppStrings.networkError;
          break;
        case 'invalid-credential':
          errorMessage = AppStrings.invalidCredential;
          break;
        default:
          errorMessage = AppStrings.loginFailed;
      }

      setState(() {
        loginErrorMessage = errorMessage;
      });
      LoadingDialog().pop(context);
    }
  }
}

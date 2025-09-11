import 'package:chowchek/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthService {
  Future<String> createAccount(
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      return "Success";
    } on FirebaseAuthException catch (error) {
      return someErrorMessage(error.code);
    }
  }

  String someErrorMessage(errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return AppStrings.emailAlreadyInUse;
      case 'invalid-email':
        return AppStrings.invalidEmail;
      case 'weak-password':
        return AppStrings.weakPassword;
      default:
        return AppStrings.generic;
    }
  }
}

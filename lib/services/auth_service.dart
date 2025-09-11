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

  Future<String> verifyAccount(
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
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
      case 'user-disabled':
        return AppStrings.userDisabled;
      case 'user-not-found':
        return AppStrings.userNotFound;
      case 'wrong-password':
        return AppStrings.wrongPassword;
      case 'too-many-requests':
        return AppStrings.tooManyRequests;
      case 'operation-not-allowed':
        return AppStrings.operationNotAllowed;
      case 'network-request-failed':
        return AppStrings.networkError;
      case 'invalid-credential':
        return AppStrings.invalidCredential;
      default:
        return AppStrings.generic;
    }
  }
}

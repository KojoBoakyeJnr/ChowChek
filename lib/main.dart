import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/views/auth/auth_page_login.dart';
import 'package:chowchek/views/auth/auth_page_signup.dart';
import 'package:chowchek/views/main/home_page.dart';
import 'package:chowchek/views/onboarding/set_daily_meal_number.dart';
import 'package:chowchek/views/onboarding/set_nutrient_goal.dart';
import 'package:chowchek/views/onboarding/set_userName_Page.dart';
import 'package:chowchek/views/welcome/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Aeonik"),
      routes: {
        "/": (context) => SplashScreen(),
        "login": (context) => AuthPageLogin(),
        "signUp": (context) => AuthPageSignup(),
        "setUserName": (context) => SetUsername(),
        "setAverageDailyMealCount": (context) => SetDailyMealNumber(),
        "homePage": (context) => HomePage(),
        "nutrientGoal": (context) => SetNutrientGoal(),
      },
    );
  }
}

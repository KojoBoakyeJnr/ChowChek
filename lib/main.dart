import 'package:chowchek/providers/blacklisted_meals_provider.dart';
import 'package:chowchek/providers/nutrient_check_provider.dart';
import 'package:chowchek/providers/saved_meals_provider.dart';
import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/routes.dart';
import 'package:chowchek/views/auth/auth_page_login.dart';
import 'package:chowchek/views/auth/auth_page_signup.dart';
import 'package:chowchek/views/main/home_page.dart';
import 'package:chowchek/views/onboarding/set_daily_meal_number.dart';
import 'package:chowchek/views/onboarding/set_nutrient_goal.dart';
import 'package:chowchek/views/onboarding/set_userName_Page.dart';
import 'package:chowchek/views/updates/update_nutrient_limits.dart';
import 'package:chowchek/views/welcome/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
        ChangeNotifierProvider(create: (_) => NutrientCheckProvider()),
        ChangeNotifierProvider(create: (_) => SavedMealsProvider()),
        ChangeNotifierProvider(create: (_) => BlacklistedMealsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Aeonik"),
      routes: {
        AppRoutes.root: (context) => SplashScreen(),
        AppRoutes.login: (context) => AuthPageLogin(),
        AppRoutes.signUp: (context) => AuthPageSignup(),
        AppRoutes.setUserName: (context) => SetUsername(),
        AppRoutes.setAverageDailyMealCount: (context) => SetDailyMealNumber(),
        AppRoutes.homePage: (context) => HomePage(),
        AppRoutes.nutrientGoal: (context) => SetNutrientGoal(),
        AppRoutes.updateNutrientGoal: (context) => UpdateNutrientLimits(),
      },
    );
  }
}

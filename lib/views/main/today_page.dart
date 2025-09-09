// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:chowchek/endpoints/end_points.dart';
import 'package:chowchek/views/components/custom_snackbar.dart';
import 'package:chowchek/views/components/loading_dialog.dart';
import 'package:chowchek/model/meal_log.dart';
import 'package:chowchek/views/components/nutrient_result_container.dart';
import 'package:chowchek/views/components/results_empty_state.dart';
import 'package:chowchek/providers/nutrient_check_provider.dart';
import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:chowchek/utils/app_text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => TodayPageState();
}

TextEditingController _query = TextEditingController();
bool resultsFound = false;
bool resultsNotFoundBannerOff = true;

final apiKey = dotenv.env['API_KEY'];

class TodayPageState extends State<TodayPage> {
  Future<MealLog> _getAndStoreNutritionData() async {
    List foodName = [];
    double totalFat = 0;
    double saturatedFat = 0;
    double sodium = 0;
    double sugar = 0;
    double cholestrol = 0;

    var response = await fetchNutrientData();

    if (response.statusCode == 400) {
      showServerError();
      return MealLog(
        combinationName: "",
        totalFat: 0.0,
        saturatedFat: 0.0,
        sugar: 0.0,
        sodium: 0.0,
        cholestrol: 0.0,
      );
    }

    List nutritionInfo = jsonDecode(response.body);

    for (var meal in nutritionInfo) {
      foodName.add(meal["name"]);
      totalFat += meal["fat_total_g"] ?? 0;
      saturatedFat += meal["fat_saturated_g"] ?? 0;
      sodium += meal["sodium_mg"] ?? 0;
      sugar += meal["sugar_g"] ?? 0;
      cholestrol += meal["cholesterol_mg"] ?? 0;
    }

    String combinationName = foodName.join(" + ");

    if (nutritionInfo.isEmpty) {
      if (mounted) {
        setState(() {
          resultsFound = false;
          resultsNotFoundBannerOff = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          resultsFound = true;
        });
      }
    }

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          resultsNotFoundBannerOff = true;
        });
      }
    });

    return MealLog(
      combinationName: combinationName,
      totalFat: totalFat,
      saturatedFat: saturatedFat,
      sugar: sugar,
      sodium: sodium,
      cholestrol: cholestrol,
    );
  }

  Future<http.Response> fetchNutrientData() {
    final client = http.Client();
    return client.get(
      Uri.parse("${EndPoints.nutrientsURL}query=${_query.text}"),
      headers: {"X-Api-Key": apiKey ?? ""},
    );
  }

  void showServerError() {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(
        content: AppStrings.serverErrorTryAgainLater,
        backgroundColor: AppColors.primaryRed,
      ).show(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NutrientCheckProvider>(
      builder:
          (context, model, child) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          AppStrings.whatDidYouEat,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: 16),
                        AppTextFormFields(
                          hintText: AppStrings.todayHintText,
                          controller: _query,
                          fill: AppColors.textFieldGray,
                          leading: Icon(Icons.question_mark),
                        ),
                        SizedBox(height: 16),
                        AppButton(
                          buttonName: AppStrings.chekButtonName,
                          onclick: () async {
                            if (_query.text.isNotEmpty) {
                              LoadingDialog().show(context);
                              final meal = await _getAndStoreNutritionData();
                              Provider.of<NutrientCheckProvider>(
                                context,
                                listen: false,
                              ).setMeal(meal);
                              LoadingDialog().pop(context);
                            }
                          },
                          backgroundColor: AppColors.deepGreen,
                          textColor: AppColors.primaryWhite,
                        ),
                        (resultsFound)
                            ? Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 10,
                                right: 10,
                              ),
                              child: NutrientResult(),
                            )
                            : (!resultsFound && !resultsNotFoundBannerOff)
                            ? ResultsEmptyState()
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

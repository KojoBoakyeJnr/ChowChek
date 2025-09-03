// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:chowchek/endpoints/end_points.dart';
import 'package:chowchek/models/loading_dialog.dart';
import 'package:chowchek/models/meal_log.dart';
import 'package:chowchek/models/nutrient_result_container.dart';
import 'package:chowchek/models/results_empty_state.dart';
import 'package:chowchek/providers/nutrient_check_provider.dart';
import 'package:chowchek/utils/app_button.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

TextEditingController _query = TextEditingController();
bool resultsFound = false;
bool resultsNotFoundBannerOff = true;

final apiKey = dotenv.env['API_KEY'];

class _TodayPageState extends State<TodayPage> {
  Future<MealLog> _getAndStoreNutritionData() async {
    List foodName = [];
    double totalFat = 0;
    double saturatedFat = 0;
    double sodium = 0;
    double sugar = 0;
    double cholestrol = 0;
    String mainFoodName = "";

    var response = await fetchNutrientData();

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
    mainFoodName = combinationName;

    if (nutritionInfo.isEmpty) {
      setState(() {
        resultsFound = false;
        resultsNotFoundBannerOff = false;
      });
    } else {
      setState(() {
        resultsFound = true;
      });
    }

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        setState(() {
          resultsNotFoundBannerOff = true;
        });
      });
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

  @override
  Widget build(BuildContext context) {
    return Consumer<NutrientCheckProvider>(
      builder:
          (context, model, child) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "What did you eat today?",

                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 30,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                        AppTextFormFields(
                          hintText: "Beans with plantain and sausage",
                          controller: _query,
                          fill: AppColors.textFieldGray,
                          leading: Icon(Icons.question_mark),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: AppButton(
                            buttonName: "Chek!",
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
                        ),

                        (resultsFound)
                            ? Padding(
                              padding: const EdgeInsets.all(20.0),
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

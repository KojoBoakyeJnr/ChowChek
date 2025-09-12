// ignore_for_file: use_build_context_synchronously
import 'package:chowchek/services/fetch_nutrients_service.dart';
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
import 'package:provider/provider.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => TodayPageState();
}

class TodayPageState extends State<TodayPage> {
  bool resultsFound = false;
  bool resultsNotFoundBannerOff = true;
  final TextEditingController _query = TextEditingController();
  void reset() {
    _query.clear();
    Provider.of<NutrientCheckProvider>(context, listen: false).reset();
    setState(() {
      resultsFound = false;
    });
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  void showServerError() {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(
        content: AppStrings.serverErrorTryAgainLater,
        backgroundColor: AppColors.primaryRed,
      ).show(),
    );
  }

  chekFunction() async {
    LoadingDialog().show(context, AppStrings.gettingMealDets);
    if (_query.text.isNotEmpty) {
      final service = FetchNutrientsService(query: _query.text.trim());

      await service.fetch();

      final status = service.statusCode;
      if (status != 200) {
        showServerError();
      } else {
        final content = service.content;
        MealLog meal = await service.loadNutrientContent();
        pushMealToProvider(meal);
        LoadingDialog().pop(context);
        showResultsFoundOrNotFound(content);
      }
    }
  }

  void showResultsFoundOrNotFound(content) {
    if (content.isEmpty) {
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
    showNotFoundMessageDissappearAfter5sec();
  }

  void showNotFoundMessageDissappearAfter5sec() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          resultsNotFoundBannerOff = true;
        });
      }
    });
  }

  void pushMealToProvider(MealLog meal) {
    Provider.of<NutrientCheckProvider>(context, listen: false).setMeal(meal);
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
                          inputType: TextInputType.text,
                          hintText: AppStrings.todayHintText,
                          controller: _query,
                          fill: AppColors.textFieldGray,
                          leading: Icon(Icons.question_mark),
                        ),
                        SizedBox(height: 16),
                        AppButton(
                          buttonName: AppStrings.chekButtonName,
                          onclick: () => chekFunction(),
                          backgroundColor: AppColors.deepGreen,
                          textColor: AppColors.primaryWhite,
                        ),
                        SizedBox(height: 16),
                        (resultsFound)
                            ? NutrientResult()
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

import 'package:chowchek/models/nutrient_tile.dart';
import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_images.dart';
import 'package:chowchek/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NutrientMeter extends StatefulWidget {
  const NutrientMeter({super.key});

  @override
  State<NutrientMeter> createState() => _NutrientMeterState();
}

class _NutrientMeterState extends State<NutrientMeter> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> nutrientSpecs = getNutrientSpecs(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryGreen,
      ),
      height: 400,
      width: 380,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView.builder(
            itemCount: nutrientSpecs.length,
            itemBuilder: (context, index) {
              return NutrientTile(
                defaultValue: nutrientSpecs[index]["defaultValue"],
                activeColor: nutrientSpecs[index]["activeColor"],
                divisions: nutrientSpecs[index]["divisions"],
                imagePath: nutrientSpecs[index]["imagePath"],
                max: nutrientSpecs[index]["max"],
                min: nutrientSpecs[index]["min"],
                name: nutrientSpecs[index]["name"],
                unit: nutrientSpecs[index]["unit"],
              );
            },
          ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> getNutrientSpecs(BuildContext context) {
  return [
    {
      "defaultValue":
          (Provider.of<UserDetailsProvider>(
            context,
          ).nutrientLoggedLimits[AppStrings.totalfatKey]) ??
          140.0,
      "activeColor": AppColors.amber,
      "divisions": 10,
      "imagePath": AppImages.totalFat,
      "max": 210.0,
      "min": 0.0,
      "name": AppStrings.totalfat,
      "unit": AppStrings.gramsUnit,
    },
    {
      "defaultValue":
          (Provider.of<UserDetailsProvider>(
            context,
          ).nutrientLoggedLimits[AppStrings.satFatKey]) ??
          40.0,
      "activeColor": AppColors.blue,
      "divisions": 10,
      "imagePath": AppImages.saturatedFat,
      "max": 60.0,
      "min": 0.0,
      "name": AppStrings.satFat,
      "unit": AppStrings.gramsUnit,
    },
    {
      "defaultValue":
          (Provider.of<UserDetailsProvider>(
            context,
          ).nutrientLoggedLimits[AppStrings.sodiumKey]) ??
          4600.0,
      "activeColor": AppColors.black,
      "divisions": 10,
      "imagePath": AppImages.salt,
      "max": 6900.0,
      "min": 0.0,
      "name": AppStrings.sodium,
      "unit": AppStrings.milligramsUnit,
    },
    {
      "defaultValue":
          (Provider.of<UserDetailsProvider>(
            context,
          ).nutrientLoggedLimits[AppStrings.sugarKey]) ??
          50.0,
      "activeColor": AppColors.brown,
      "divisions": 10,
      "imagePath": AppImages.sugar,
      "max": 75.0,
      "min": 0.0,
      "name": AppStrings.sugar,
      "unit": AppStrings.gramsUnit,
    },
    {
      "defaultValue":
          (Provider.of<UserDetailsProvider>(
            context,
          ).nutrientLoggedLimits[AppStrings.cholesterolKey]) ??
          600.0,
      "activeColor": AppColors.primaryRed,
      "divisions": 10,
      "imagePath": AppImages.cholestrol,
      "max": 900.0,
      "min": 0.0,
      "name": AppStrings.cholesterol,
      "unit": AppStrings.milligramsUnit,
    },
  ];
}

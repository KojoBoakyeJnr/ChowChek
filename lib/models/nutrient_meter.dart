import 'package:chowchek/models/nutrient_tile.dart';
import 'package:chowchek/providers/user_details_provider.dart';
import 'package:chowchek/utils/app_colors.dart';
import 'package:chowchek/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NutrientMeter extends StatefulWidget {
  const NutrientMeter({super.key});

  @override
  State<NutrientMeter> createState() => _NutrientMeterState();
}

var rating = 10.0;

class _NutrientMeterState extends State<NutrientMeter> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryGreen,
      ),
      height: 400,
      width: 380,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NutrientTile(
            defaultValue:
                (Provider.of<UserDetailsProvider>(
                  context,
                ).nutrientLoggedLimits["Total Fat"]) ??
                140,
            activeColor: Colors.amber,
            divisions: 10,
            imagePath: AppImages.totalFat,
            max: 210,
            min: 0,
            name: "Total Fat",
            unit: "g",
          ),
          NutrientTile(
            defaultValue:
                (Provider.of<UserDetailsProvider>(
                  context,
                ).nutrientLoggedLimits["Sat. Fat"]) ??
                40,
            activeColor: Colors.blue,
            divisions: 10,
            imagePath: AppImages.saturatedFat,
            max: 60,
            min: 0,
            name: "Sat. Fat",
            unit: "g",
          ),
          NutrientTile(
            defaultValue:
                (Provider.of<UserDetailsProvider>(
                  context,
                ).nutrientLoggedLimits["Sodium"]) ??
                4600,
            activeColor: Colors.black,
            divisions: 10,
            imagePath: AppImages.salt,
            max: 6900,
            min: 0,
            name: "Sodium",
            unit: "mg",
          ),
          NutrientTile(
            defaultValue:
                (Provider.of<UserDetailsProvider>(
                  context,
                ).nutrientLoggedLimits["Sugar"]) ??
                50,
            activeColor: Colors.brown,
            divisions: 10,
            imagePath: AppImages.sugar,
            max: 75,
            min: 0,
            name: "Sugar",
            unit: "g",
          ),
          NutrientTile(
            defaultValue:
                (Provider.of<UserDetailsProvider>(
                  context,
                ).nutrientLoggedLimits["Cholesterol"]) ??
                600,
            activeColor: Colors.red,
            divisions: 10,
            imagePath: AppImages.cholestrol,
            max: 900,
            min: 0,
            name: "Cholesterol",
            unit: "mg",
          ),
        ],
      ),
    );
  }
}

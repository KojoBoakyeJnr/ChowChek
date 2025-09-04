import 'package:chowchek/models/blacklisted_meal_tile.dart';
import 'package:chowchek/providers/blacklisted_meals_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlacklistPage extends StatefulWidget {
  const BlacklistPage({super.key});

  @override
  State<BlacklistPage> createState() => _BlacklistPageState();
}

class _BlacklistPageState extends State<BlacklistPage> {
  @override
  void initState() {
    super.initState();
    () async {
      await Provider.of<BlacklistedMealsProvider>(
        context,
      ).loadBlacklistedMealsFromPrefs();
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlacklistedMealsProvider>(
      builder:
          (context, model, child) => SafeArea(
            child: ListView.builder(
              itemCount: model.blacklistedMeals.length,
              itemBuilder: (context, int index) {
                return BlacklistedMealTile(
                  mealName: model.blacklistedMeals[index]["combinationName"],
                  totalFat: model.blacklistedMeals[index]["totalFat"],
                  saturatedFat: model.blacklistedMeals[index]["saturatedFat"],
                  sugar: model.blacklistedMeals[index]["sugar"],
                  salt: model.blacklistedMeals[index]["sodium"],
                  cholestrol: model.blacklistedMeals[index]["cholestrol"],
                );
              },
            ),
          ),
    );
  }
}

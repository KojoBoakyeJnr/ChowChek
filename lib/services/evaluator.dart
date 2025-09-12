import 'package:chowchek/model/meal_log.dart';

class Evaluator {
  Map<String, dynamic> evaluate(
    MealLog mealDetails,
    Map<String, double> nutrientLimits,
  ) {
    double percent(numerator, denominator) => (numerator / denominator) * 100;

    Map<String, double> nutrientPercentages = {};
    List<String> exceededNutrients = [];
    String warningTitle = "";
    String warningDetails = "";

    final totalFatPercentage = percent(
      mealDetails.totalFat,
      nutrientLimits["Total Fat"],
    );
    final satFatPercentage = percent(
      mealDetails.saturatedFat,
      nutrientLimits["Sat. Fat"],
    );
    final sodiumPercentage = percent(
      mealDetails.sodium,
      nutrientLimits["Sodium"],
    );
    final sugarPercentage = percent(mealDetails.sugar, nutrientLimits["Sugar"]);
    final cholesterolPercentage = percent(
      mealDetails.cholestrol,
      nutrientLimits["Cholesterol"],
    );

    nutrientPercentages = {
      "totalFatKey": totalFatPercentage,
      "satFatKey": satFatPercentage,
      "sodiumKey": sodiumPercentage,
      "sugarKey": sugarPercentage,
      "cholesterolKey": cholesterolPercentage,
    };

    if (mealDetails.totalFat > nutrientLimits["Total Fat"]!) {
      exceededNutrients.add("Total Fat");
    }
    if (mealDetails.saturatedFat > nutrientLimits["Sat. Fat"]!) {
      exceededNutrients.add("Saturated Fat");
    }
    if (mealDetails.sodium > nutrientLimits["Sodium"]!) {
      exceededNutrients.add("Sodium");
    }
    if (mealDetails.sugar > nutrientLimits["Sugar"]!) {
      exceededNutrients.add("Sugar");
    }
    if (mealDetails.cholestrol > nutrientLimits["Cholesterol"]!) {
      exceededNutrients.add("Cholesterol");
    }

    if (exceededNutrients.isEmpty) {
      warningTitle = "";
      warningDetails = "";
    } else if (exceededNutrients.length == 1) {
      warningTitle = "⚠️ High in ${exceededNutrients[0]}";
      warningDetails = "${exceededNutrients[0]} exceeds your daily limit.";
    } else if (exceededNutrients.length == 2) {
      warningTitle = "⚠️ High in 2 nutrients";
      warningDetails =
          "${exceededNutrients[0]} & ${exceededNutrients[1]} exceed your daily limit.";
    } else {
      warningTitle = "⚠️ High in ${exceededNutrients.length} nutrients";
      warningDetails =
          "${exceededNutrients[0]} and ${exceededNutrients.length - 1} other nutrients exceed your daily limit.";
    }
    return {
      "percentages": nutrientPercentages,
      "warningTitle": warningTitle,
      "warningDetails": warningDetails,
    };
  }
}

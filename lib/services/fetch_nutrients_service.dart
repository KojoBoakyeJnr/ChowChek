import 'dart:convert';
import 'package:chowchek/model/meal_log.dart';
import 'package:chowchek/services/api_services.dart';
import 'package:http/http.dart' as http;

class FetchNutrientsService {
  late http.Response apiResponse;
  String query;
  FetchNutrientsService({required this.query});

  Future<void> fetch() async {
    apiResponse = await ApiServices().fetchDataFromApi(query);
  }

  int get statusCode => apiResponse.statusCode;

  List get content => jsonDecode(apiResponse.body);

  Future<MealLog> loadNutrientContent() async {
    List foodName = [];
    double totalFat = 0;
    double saturatedFat = 0;
    double sodium = 0;
    double sugar = 0;
    double cholestrol = 0;

    for (var meal in content) {
      foodName.add(meal["name"]);
      totalFat += meal["fat_total_g"] ?? 0;
      saturatedFat += meal["fat_saturated_g"] ?? 0;
      sodium += meal["sodium_mg"] ?? 0;
      sugar += meal["sugar_g"] ?? 0;
      cholestrol += meal["cholesterol_mg"] ?? 0;
    }

    String combinationName = foodName.join(" + ");

    return MealLog(
      combinationName: combinationName,
      totalFat: totalFat,
      saturatedFat: saturatedFat,
      sugar: sugar,
      sodium: sodium,
      cholestrol: cholestrol,
    );
  }
}

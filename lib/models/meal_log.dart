class MealLog {
  double totalFat;
  double saturatedFat;
  double sodium;
  double sugar;
  double cholestrol;
  String combinationName;

  MealLog({
    required this.combinationName,
    required this.totalFat,
    required this.saturatedFat,
    required this.sugar,
    required this.sodium,
    required this.cholestrol,
  });

  Map<String, dynamic> toMap() {
    return {
      'combinationName': combinationName,
      'totalFat': totalFat,
      'saturatedFat': saturatedFat,
      'sugar': sugar,
      'sodium': sodium,
      'cholestrol': cholestrol,
    };
  }
}

class FoodLog {
  static const tableName = 'foodLog';
  static const colId = 'id';
  static const colFoodName = 'foodName';
  static const colDate = 'date';
  static const colCalories = 'calories';
  static const colPhoto = 'photo';
  static const colMealType = 'mealType';

  FoodLog(
      {this.id,
      this.foodName,
      this.date,
      this.calories,
      this.photo,
      this.mealType});

  int? id;
  String? foodName;
  String? date;
  int? calories;
  String? photo;
  int? mealType;

  FoodLog.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    foodName = map[colFoodName];
    date = map[colDate];
    calories = map[colCalories];
    photo = map[colPhoto];
    mealType = map[colMealType];
  }

  Map<String, dynamic> toMap() {
    var mapping = <String, dynamic>{colFoodName:foodName, colDate:date, colCalories:calories, colPhoto:photo, colMealType:mealType};
    if (id != null) {
      mapping[colId] = id;
    }
    return mapping;
  }
}

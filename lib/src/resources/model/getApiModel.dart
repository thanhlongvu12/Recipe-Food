class Model{
  String? image, url, source, label;
  Model({this.image, this.url, this.source, this.label});
}

class ModelDetail{
  String? image, label, ingredients, ingredientLines, calories, totalWeight, totalTime;
  ModelDetail({
    this.image,
    this.label,
    this.ingredients,
    this.ingredientLines,
    this.calories,
    this.totalWeight,
    this.totalTime,
  });
}
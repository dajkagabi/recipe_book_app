//Classok, amik a recept adatokat tárolják

class Recipe {
  final String id;
  final String title;
  final String thumbnail;
  final String instructions;
  final List<String> ingredients;

  Recipe({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.instructions,
    required this.ingredients,
  });

  factory Recipe.fromCategoryJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['idMeal'] ?? '',
      title: json['strMeal'] ?? 'Ismeretlen recept',
      thumbnail: json['strMealThumb'] ?? '',
      instructions: '',
      ingredients: [],
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ing = json['strIngredient$i'];
      if (ing != null && ing.toString().isNotEmpty) {
        ingredients.add(ing);
      }
    }

    return Recipe(
      id: json['idMeal'] ?? '',
      title: json['strMeal'] ?? 'Névtelen recept',
      thumbnail: json['strMealThumb'] ?? '',
      instructions: json['strInstructions'] ?? '',
      ingredients: ingredients,
    );
  }
}

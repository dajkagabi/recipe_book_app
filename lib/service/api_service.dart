import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  static Future<List<String>> fetchCategories() async {
    final url = Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/list.php?c=list',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['meals'] as List)
          .map<String>((json) => json['strCategory'].toString())
          .toList();
    } else {
      throw Exception('Kategória lekérés sikertelen');
    }
  }

  static Future<List<Recipe>> fetchRecipesByCategory(String category) async {
    final url = Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final meals = data['meals'];
      if (meals == null) return [];
      return meals
          .map<Recipe>((json) => Recipe.fromCategoryJson(json))
          .toList();
    } else {
      throw Exception('Receptlekérés sikertelen');
    }
  }

  static Future<Recipe?> fetchRecipeById(String id) async {
    final url = Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final meals = data['meals'];
      if (meals == null || meals.isEmpty) return null;
      return Recipe.fromJson(meals[0]);
    } else {
      return null;
    }
  }
}

//HTTP LEKÉRÉS
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  static Future<List<Recipe>> fetchRecipes(String query) async {
    final url = Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/search.php?s=$query',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final meals = data['meals'];

      if (meals == null) return [];

      return meals.map<Recipe>((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Receptlekérés sikertelen');
    }
  }
}

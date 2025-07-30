//
import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const RecipeCard({required this.recipe, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: ListTile(
        leading: Image.network(recipe.thumbnail, width: 60, fit: BoxFit.cover),
        title: Text(recipe.title),
        subtitle: Text('${recipe.ingredients.length} hozzávaló'),
        onTap: onTap,
      ),
    );
  }
}

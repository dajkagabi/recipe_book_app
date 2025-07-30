//Leírások, hozzávalók, API hívás
import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({required this.recipe, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(recipe.thumbnail),
            const SizedBox(height: 16),
            Text('Hozzávalók:', style: Theme.of(context).textTheme.titleLarge),
            ...recipe.ingredients.map((i) => Text('- $i')),
            const SizedBox(height: 16),
            Text('Elkészítés:', style: Theme.of(context).textTheme.titleLarge),
            Text(recipe.instructions),
          ],
        ),
      ),
    );
  }
}

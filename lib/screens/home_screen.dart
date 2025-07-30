import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../service/api_service.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Recipe> recipes = [];
  List<String> categories = [];
  String selectedCategory = 'Beef';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initLoad();
  }

  Future<void> _initLoad() async {
    final cats = await ApiService.fetchCategories();
    final recs = await ApiService.fetchRecipesByCategory(selectedCategory);
    setState(() {
      categories = cats;
      recipes = recs;
      isLoading = false;
    });
  }

  Future<void> _selectCategory(String category) async {
    setState(() {
      selectedCategory = category;
      isLoading = true;
    });
    final recs = await ApiService.fetchRecipesByCategory(category);
    setState(() {
      recipes = recs;
      isLoading = false;
    });
  }

  void _openDetail(String recipeId) async {
    final recipe = await ApiService.fetchRecipeById(recipeId);
    if (recipe != null && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: recipe)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Receptkereső')),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final selected = cat == selectedCategory;
                return ChoiceChip(
                  label: Text(cat),
                  selected: selected,
                  onSelected: (_) => _selectCategory(cat),
                  selectedColor: Colors.deepOrange,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 8),
            ),
          ),
          const Divider(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return GestureDetector(
                        onTap: () => _openDetail(recipe.id),
                        child: RecipeCard(recipe: recipe),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

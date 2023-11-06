import 'package:flutter/material.dart';
import 'package:recipe_model/recipe_model.dart';

class RecipeDetailView extends StatelessWidget {
  const RecipeDetailView({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  // simply show the instructions and steps of a recipe


  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("This is the recipe detail view..."));
  }
}

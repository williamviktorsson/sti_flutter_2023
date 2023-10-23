import 'package:flutter/material.dart';
import 'package:recipe_model/recipe_model.dart';

class RecipeDetailView extends StatelessWidget {
  const RecipeDetailView({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Instructions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListView.separated(
                shrinkWrap: true,
                itemCount: recipe.instructions.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 8),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(recipe.instructions[index]),
                  );
                },
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Steps',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListView.separated(
                shrinkWrap: true,
                itemCount: recipe.steps.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 8),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                        "${recipe.steps[index].ingredient.name} - ${recipe.steps[index].amount} ${recipe.steps[index].unit.toString().split('.').last}"),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

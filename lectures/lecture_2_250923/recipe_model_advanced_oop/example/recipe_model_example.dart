import 'dart:io';
import 'package:recipe_model/recipe_model.dart';

void main() async {
  final RecipeRepository recipeRepo = RecipeRepository.instance;
  final IngredientRepository ingredientRepo = IngredientRepository.instance;

  Directory directory = Directory.current;
  await ingredientRepo.initialize(filePath: directory.path);
  await recipeRepo.initialize(filePath: directory.path);

  // Create an ingredient
  final ingredient = Ingredient(
    id: '1',
    name: 'Tomato',
    description: 'A ripe red tomato.',
    defaultAmount: 1,
    defaultUnit: MeasurementUnit.gram,
  );

  final createIngredientResult = await ingredientRepo.create(ingredient);
  print('Ingredient created: ${createIngredientResult.isSuccess}');

  // Read the ingredient
  final readIngredientResult = await ingredientRepo.read('1');
  print('Ingredient read: ${readIngredientResult.isSuccess}');
  print('Ingredient name: ${readIngredientResult.value?.name}');

  // Create a recipe
  final recipeStep = RecipeStep(
    ingredient: ingredient,
    unit: MeasurementUnit.gram,
    amount: 100,
  );

  final recipe = Recipe(
    name: "Tasty",
    id: '1',
    instructions: ['Chop the tomato.', 'Cook for 5 minutes.'],
    steps: [recipeStep],
  );

  final createRecipeResult = await recipeRepo.create(recipe);
  print('Recipe created: ${createRecipeResult.isSuccess}');

  // Read the recipe
  final readRecipeResult = await recipeRepo.read('1');
  print('Recipe read: ${readRecipeResult.isSuccess}');
  print('First instruction: ${readRecipeResult.value?.instructions[0]}');

  // Cleanup
  await ingredientRepo.destroy();
  await recipeRepo.destroy();
}

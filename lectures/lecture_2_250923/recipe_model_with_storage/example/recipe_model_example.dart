import 'package:recipe_model/recipe_model.dart';

void main() async {
  // Initialize a RecipeRepository
  RecipeRepository repository = RecipeRepository();

  await repository.initialize();

  // Create a few Ingredients
  Ingredient meatballIngredient =
      Ingredient(id: "123", name: "köttbullar", description: "goda");
  Ingredient saltIngredient =
      Ingredient(id: "124", name: "Salt", description: "For flavor");

  // Print out the ingredient's name
  print(meatballIngredient.name);

  // Create a Recipe
  Recipe meatballRecipe = Recipe(
      id: "001",
      name: "Meatball Recipe",
      description: "Delicious meatballs",
      instructions: [],
      ingredients: {});

  // Print out the recipe's name
  print(meatballRecipe.name);

  // Use the RecipeEditingManager to start editing the recipe

  // Add ingredients and their amounts to the recipe
  meatballRecipe.addIngredient(meatballIngredient,
      IngredientAmount(amount: 10, unit: MeasurementUnit.msk));
  meatballRecipe.addIngredient(
      saltIngredient, IngredientAmount(amount: 1, unit: MeasurementUnit.tsk));

  // Add description steps to the recipe
  meatballRecipe.addDescription("Add 10 meatballs");
  meatballRecipe.addDescription("Add a teaspoon of salt");

  // Finish editing

  // Use the RecipeRepository to store the recipe
  bool isCreated = repository.create(meatballRecipe);
  print('Recipe added to repository: $isCreated');

  // Read it back
  Recipe? readRecipe = repository.read("001");
  print('Read recipe description: ${readRecipe?.description}');

  // Update it
  Recipe updatedRecipe = Recipe(
      id: "001",
      name: "Updated Meatball Recipe",
      description: "Very delicious meatballs",
      instructions: [],
      ingredients: {});
  Recipe updatedVersion = repository.update(updatedRecipe);
  print('Updated recipe description: ${updatedVersion.description}');

  // List all the recipes in the repository
  List<Recipe> allRecipes = repository.list();
  print('Number of recipes in repository: ${allRecipes.length}');

  bool isDeleted = repository.delete(meatballRecipe.id);
  print('Recipe deletec from repository: $isDeleted');

}

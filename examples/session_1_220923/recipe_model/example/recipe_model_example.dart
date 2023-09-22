import 'package:recipe_model/recipe_model.dart';

void main() {
  // Initialize a RecipeRepository
  RecipeRepository repository = RecipeRepository();

  // Create a few Ingredients
  Ingredient meatballIngredient =
      Ingredient(name: "köttbullar", description: "goda");
  Ingredient saltIngredient =
      Ingredient(name: "Salt", description: "For flavor");

  // Print out the ingredient's name
  print(meatballIngredient.name);

  // Create a Recipe
  Recipe meatballRecipe = Recipe(
      id: "001", name: "Meatball Recipe", description: "Delicious meatballs");

  // Print out the recipe's name
  print(meatballRecipe.name);

  // Use the RecipeEditingManager to start editing the recipe
  RecipeEditingManager manager = RecipeEditingManager();
  manager.startEditing(meatballRecipe);

  // Add steps to the recipe using the ingredients
  manager.addStep(RecipeStep(
      ingredient: meatballIngredient,
      amount: 10,
      unit: MeasurementUnit.msk,
      description: "Add 10 meatballs"));
  manager.addStep(RecipeStep(
      ingredient: saltIngredient,
      amount: 1,
      unit: MeasurementUnit.tsk,
      description: "Add a teaspoon of salt"));

  Recipe lastRecipe = manager.currentRecipe!;

  // Finish editing
  manager.finishEditing();

  // Use the RecipeRepository to store the recipe
  bool isCreated = repository.create(lastRecipe);
  print('Recipe added to repository: $isCreated');

  // Read it back
  Recipe? readRecipe = repository.read("001");
  print('Read recipe description: ${readRecipe?.description}');

  // Update it
  Recipe updatedRecipe = Recipe(
      id: "001",
      name: "Updated Meatball Recipe",
      description: "Very delicious meatballs");
  Recipe updatedVersion = repository.update(updatedRecipe);
  print('Updated recipe description: ${updatedVersion.description}');

  // List all the recipes in the repository
  List<Recipe> allRecipes = repository.list();
  print('Number of recipes in repository: ${allRecipes.length}');
}

enum MeasurementUnit { tsk, msk, dl, cl, undefined }

class Ingredient {
  final String id;
  final String name;
  final String description;
  final IngredientAmount? defaultAmount;

  Ingredient({
    required this.id,
    required this.name,
    required this.description,
    this.defaultAmount,
  });
}

class IngredientAmount {
  final double amount;
  final MeasurementUnit unit;

  IngredientAmount({required this.amount, required this.unit});
}

class Recipe {
  final String id;
  final String name;
  final String description;
  final Map<Ingredient, IngredientAmount> ingredients;
  final List<String> instructions;

  Recipe(
      {required this.id,
      required this.name,
      required this.description,
      required this.ingredients,
      required this.instructions});

  addIngredient(Ingredient ingredient, IngredientAmount amount) {
    ingredients[ingredient] = amount;
  }

  addInstruction(String description) {
    instructions.add(description);
  }
}

class RecipeRepository {
  final List<Recipe> _recipes = [];

  bool create(Recipe recipe) {
    if (_recipes.any((r) => r.id == recipe.id)) {
      return false;
    }
    _recipes.add(recipe);
    return true;
  }

  Recipe? read(String id) {
    int index = _recipes.indexWhere((r) => r.id == id);
    if (index == -1) {
      return null;
    }
    return _recipes[index];
  }

  Recipe update(Recipe recipe) {
    int index = _recipes.indexWhere((r) => r.id == recipe.id);
    if (index == -1) {
      throw Exception('Recipe not found');
    }
    _recipes[index] = recipe;
    return _recipes[index];
  }

  bool delete(String id) {
    int index = _recipes.indexWhere((r) => r.id == id);
    if (index >= 0) {
      _recipes.removeAt(index);
      return true;
    }
    return false;
  }

  List<Recipe> list() => List.of(_recipes);
}

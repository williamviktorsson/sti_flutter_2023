import 'package:uuid/uuid.dart';

part 'recipe_model_interfaces.dart';

class Ingredient implements IIngredient {
  final String id;
  final String name;
  final String description;
  final IIngredientAmount? defaultAmount;

  Ingredient({
    String? id,
    required this.name,
    required this.description,
    this.defaultAmount,
  }) : id = id ?? Uuid().v4();
}

class IngredientAmount implements IIngredientAmount {
  final double amount;
  final MeasurementUnit unit;

  IngredientAmount({required this.amount, required this.unit});
}

class Recipe implements IRecipe {
  final String id;
  final String name;
  final String description;
  final Map<IIngredient, IIngredientAmount> ingredients;
  final List<String> descriptions;

  Recipe(
      {String? id,
      required this.name,
      required this.description,
      Map<IIngredient, IIngredientAmount>? ingredients,
      List<String>? descriptions})
      : id = id ?? Uuid().v4(),
        ingredients = ingredients ?? {},
        descriptions = descriptions ?? [];

  addIngredient(IIngredient ingredient, IIngredientAmount amount) {
    ingredients[ingredient] = amount;
  }

  addDescription(String description) {
    descriptions.add(description);
  }
}

class RecipeRepository implements IRecipeRepository {
  final List<IRecipe> _recipes = [];

  @override
  bool create(IRecipe recipe) {
    if (_recipes.any((r) => r.id == recipe.id)) {
      return false;
    }
    _recipes.add(recipe);
    return true;
  }

  @override
  IRecipe? read(String id) {
    int index = _recipes.indexWhere((r) => r.id == id);
    if (index == -1) {
      return null;
    }
    return _recipes[index];
  }

  @override
  IRecipe update(IRecipe recipe) {
    int index = _recipes.indexWhere((r) => r.id == recipe.id);
    if (index == -1) {
      throw Exception('Recipe not found');
    }
    _recipes[index] = recipe;
    return _recipes[index];
  }

  @override
  bool delete(String id) {
    int index = _recipes.indexWhere((r) => r.id == id);
    if (index >= 0) {
      _recipes.removeAt(index);
      return true;
    }
    return false;
  }

  @override
  List<IRecipe> list() => List.of(_recipes);
}

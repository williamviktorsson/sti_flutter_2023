import 'package:uuid/uuid.dart';

part 'recipe_model_interfaces.dart';

class Ingredient implements IIngredient {
  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final double? defaultAmount;
  @override
  final MeasurementUnit? defaultUnit;

  // const allows for memory optimization, equal objects share same memory space
  const Ingredient._({
    required this.id,
    required this.name,
    required this.description,
    this.defaultAmount,
    this.defaultUnit,
  });

  // factory allows us to use const constructor with non-const value
  factory Ingredient({
    String? id,
    required String name,
    required String description,
    double? defaultAmount,
    MeasurementUnit? defaultUnit,
  }) {
    return Ingredient._(
        id: id ?? Uuid().v4(), name: name, description: description);
  }
}

class RecipeStep implements IRecipeStep {
  @override
  final Ingredient ingredient;
  @override
  final double amount;
  @override
  final MeasurementUnit unit;
  @override
  final String description;

  RecipeStep({
    required this.ingredient,
    required this.amount,
    required this.unit,
    required this.description,
  });
}

class Recipe implements IRecipe {
  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final List<RecipeStep> steps;

  Recipe(
      {required this.id,
      required this.name,
      required this.description,
      List<RecipeStep>? steps})
      : steps = steps ?? [];
}

class RecipeRepository implements IRecipeRepository<Recipe> {
  final List<Recipe> _recipes = [];

  @override
  bool create(Recipe recipe) {
    if (_recipes.any((r) => r.id == recipe.id)) {
      return false;
    }
    _recipes.add(recipe);
    return true;
  }

  @override
  Recipe? read(String id) {
    int index = _recipes.indexWhere((r) => r.id == id);
    if (index == -1) {
      return null;
    }
    return _recipes[index];
  }

  @override
  Recipe update(Recipe recipe) {
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
  List<Recipe> list() {
    return List.of(_recipes);
  }
}

class RecipeEditingManager
    implements IRecepieEditingManager<Recipe, RecipeStep> {
  Recipe? _currentRecipe;

  @override
  Recipe? get currentRecipe => _currentRecipe;

  @override
  void addStep(RecipeStep step) {
    if (_currentRecipe == null) {
      throw Exception('No recipe currently being edited.');
    }
    _currentRecipe!.steps.add(step);
  }

  @override
  void finishEditing() {
    _currentRecipe = null;
  }

  @override
  startEditing(Recipe recepie) {
    if (_currentRecipe != null) {
      throw Exception('A recipe is already being edited');
    }
    // TODO: implement newRecipe
    _currentRecipe = recepie;
  }
}

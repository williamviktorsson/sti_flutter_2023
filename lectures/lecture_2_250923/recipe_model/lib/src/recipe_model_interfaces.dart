// TODO: Put public facing types in this file.

part of 'recipe_model_base.dart';

enum MeasurementUnit { tsk, msk, dl, cl, undefined }

/// abstract interface class = interface i java (C#?)
abstract interface class IIngredient {
  String get id;
  String get name;
  String get description;
  IIngredientAmount? get defaultAmount;
}

abstract interface class IIngredientAmount {
  double get amount;
  MeasurementUnit get unit;
}

abstract interface class IRecipe {
  String get id;
  String get name;
  String get description;
  Map<IIngredient, IIngredientAmount> get ingredients;
  List<String> get descriptions;

  addIngredient(IIngredient ingredient, IIngredientAmount amount);

  addDescription(String description);
}

abstract interface class IRecipeRepository {
  //crud
  bool create(IRecipe recepie);
  IRecipe? read(String id);
  IRecipe update(IRecipe recepie);
  bool delete(String id);
  List<IRecipe> list();
  //note: methods are not async
}

abstract interface class RecipeActions {
  // static methods can be implemented here as "RecipeActions" will not be instantiated and static members are not inherited.
}

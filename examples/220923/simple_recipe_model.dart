part of 'recipe_model_base.dart';

enum MeasurementUnit { ml, dl, cl, krm, msk, tsk, st, gram }

abstract interface class IIngredient {
  String get name;
  String get description;
  int? get defaultAmount;
  MeasurementUnit? get defaultUnit;
}

abstract interface class IRecipeStep {
  IIngredient get ingredient;
  MeasurementUnit get unit;
  int get amount;
}

abstract interface class IRecipe {
  String get name;
  List<String> get instructions;
  List<IRecipeStep> get steps;
}

abstract interface class IRepository<T> {
  create(T item);
  read(String id);
  update(String id, T item);
  delete(String id);
  list();
  clear();
}

abstract interface class IRecipeBuilder {
  IRecipe? get recipe;
  newRecipe();
  editRecipe({required IRecipe recipe});
  addStep({required IRecipeStep step});
  addInstruction({required String instruction});
  finishEditing();
}

// TODO: this code could be improved, should handle action results and statuses for better error handling and feedback. Most results are now void.

// TODO: Consider adding identifiable interfaces for objects that require unique identification.
      // The repository indicates that it expects each object to be identifyable by id

// TODO: Serialization and deserialization methods are missing in IRepository, which are essential for data transformation.

// TODO: Provide a structured way to handle success and failure scenarios.

// TODO: Methods which may be async should be denoted as being Futures, such as Repository operations.
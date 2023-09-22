// TODO: Put public facing types in this file.

part of 'recipe_model_base.dart';

enum MeasurementUnit {
  tsk,
  msk,
  dl,
  cl,
}

/// abstract interface class = interface i java (C#?)
abstract interface class IIngredient {
  String get id;
  String get name;
  String get description;
  double? get defaultAmount;
  MeasurementUnit? get defaultUnit;
}

abstract interface class IRecipeStep {
  IIngredient get ingredient;
  double get amount;
  MeasurementUnit get unit;
  String get description;
}

abstract interface class IRecipe {
  String get id;
  String get name;
  String get description;
  List<IRecipeStep> get steps;
}

// TODO: this code could be improved,
// should handle action results and statuses for better error handling and feedback. Most results are now bool representing success/fail
// TODO: No gurarantee Recipe is identifyable by ID
// TODO: Provide a structured way to handle success and failure scenarios.
// TODO: Serialization and deserialization will be necessary at some point to store, part of interface?
// TODO: Methods which may be async should be denoted as being Futures, such as Repository operations.

abstract interface class IRecipeRepository<T extends IRecipe> {
  //crud
  bool create(T recepie);
  T? read(String id);
  T update(T recepie);
  bool delete(String id);
  List<T> list();
}

// TODO: this code could be improved,
// should handle action results and statuses for better error handling and feedback. Most results are now void.
// TODO: Provide a structured way to handle success and failure scenarios.
// TODO: Methods which may be async should be denoted as being Futures, such as Repository operations.

// Kommer skapa nya recpet
// kommer uppdatera existrande recept

abstract interface class IRecepieEditingManager<T extends IRecipe,
    V extends IRecipeStep> {
  T? get currentRecipe;
  startEditing(T recipe);
  addStep(V step);
  finishEditing();
}

// Definiera datat

// Definiera vilka operationer som lagrar/hämtar/visar/uppdaterar datat <- operationer som är agnostiska till affärslogiken, men som kan hjälpa oss
// i vår affärslogik

// Vilken logik behöver jag representra på ett annat sätt (för att underlätta och separera ansvarsområden)

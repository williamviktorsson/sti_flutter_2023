typedef IngredientId = String;


// FINISHED: Consider adding identifiable interfaces for objects that require unique identification.
      // The repository indicates that it expects each object to be identifyable by id

// sealed = cant be changed/extended outside of current library
sealed class Identifiable {
  String get id;
}

enum MeasurementUnit { ml, dl, cl, krm, msk, tsk, st, gram }

// FINISHED: this code could be improved, should handle action results and statuses for better error handling and feedback. Most results are now void.
// FINISHED: Provide a structured way to handle success and failure scenarios.
enum ActionStatus {
  Success,
  NotFound,
  ValidationFailed,
  DatabaseError,
  UnknownError
}

class ActionResult<T> {
  final T? value;
  final ActionStatus? status;
  final Object? error;

  ActionResult.success([this.value])
      : status = ActionStatus.Success,
        error = null;
  ActionResult.failure(ActionStatus this.status, [this.error])
      : assert(status != ActionStatus.Success),
        value = null;

  bool get isSuccess => status == ActionStatus.Success;
  bool get isFailure => !isSuccess;
}

abstract interface class IIngredient extends Identifiable {
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

abstract interface class IRecipe extends Identifiable {
  String get name;
  List<String> get instructions;
  List<IRecipeStep> get steps;
}

// FINISHED: Serialization and deserialization methods are missing in IRepository, which are essential for data transformation.
// TODO: Methods which may be async should be denoted as being Futures, such as Repository operations.
abstract interface class IRepository<T extends Identifiable> {
  String Function(T item) get serialize;
  T Function(String item) get deserialize;
  Future<ActionResult<T>> create(T item);
  Future<ActionResult<T>> read(String id);
  Future<ActionResult<T>> update(String id, T item);
  Future<ActionResult<void>> delete(String id);
  Future<ActionResult<List<T>>> list();
  Future<ActionResult<void>> clear();
}

abstract interface class IRecipeBuilder {
  IRecipe? get recipe;
  Future<ActionResult<IRecipe>> newRecipe();
  Future<ActionResult<IRecipe>> editRecipe({required IRecipe recipe});
  Future<ActionResult<IRecipe>> addStep({required IRecipeStep step});
  Future<ActionResult<IRecipe>> addInstruction({required String instruction});
  Future<ActionResult<IRecipe>> finishEditing();
}

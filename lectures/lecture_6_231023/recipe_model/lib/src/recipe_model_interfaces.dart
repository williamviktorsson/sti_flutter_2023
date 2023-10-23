part of 'recipe_model_base.dart';

typedef IngredientId = String;

// sealed = cant be changed/extended outside of current library
sealed class Identifiable {
  String get id;
}

enum MeasurementUnit { ml, dl, cl, krm, msk, tsk, st, gram }

enum ActionStatus {
  Success,
  NotFound,
  ValidationFailed,
  DatabaseError,
  UnknownError
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


// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_model_base.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Ingredient _$IngredientFromJson(Map<String, dynamic> json) {
  return _Ingredient.fromJson(json);
}

/// @nodoc
mixin _$Ingredient {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int? get defaultAmount => throw _privateConstructorUsedError;
  MeasurementUnit? get defaultUnit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IngredientCopyWith<Ingredient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientCopyWith<$Res> {
  factory $IngredientCopyWith(
          Ingredient value, $Res Function(Ingredient) then) =
      _$IngredientCopyWithImpl<$Res, Ingredient>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      int? defaultAmount,
      MeasurementUnit? defaultUnit});
}

/// @nodoc
class _$IngredientCopyWithImpl<$Res, $Val extends Ingredient>
    implements $IngredientCopyWith<$Res> {
  _$IngredientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? defaultAmount = freezed,
    Object? defaultUnit = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      defaultAmount: freezed == defaultAmount
          ? _value.defaultAmount
          : defaultAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      defaultUnit: freezed == defaultUnit
          ? _value.defaultUnit
          : defaultUnit // ignore: cast_nullable_to_non_nullable
              as MeasurementUnit?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IngredientImplCopyWith<$Res>
    implements $IngredientCopyWith<$Res> {
  factory _$$IngredientImplCopyWith(
          _$IngredientImpl value, $Res Function(_$IngredientImpl) then) =
      __$$IngredientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      int? defaultAmount,
      MeasurementUnit? defaultUnit});
}

/// @nodoc
class __$$IngredientImplCopyWithImpl<$Res>
    extends _$IngredientCopyWithImpl<$Res, _$IngredientImpl>
    implements _$$IngredientImplCopyWith<$Res> {
  __$$IngredientImplCopyWithImpl(
      _$IngredientImpl _value, $Res Function(_$IngredientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? defaultAmount = freezed,
    Object? defaultUnit = freezed,
  }) {
    return _then(_$IngredientImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      defaultAmount: freezed == defaultAmount
          ? _value.defaultAmount
          : defaultAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      defaultUnit: freezed == defaultUnit
          ? _value.defaultUnit
          : defaultUnit // ignore: cast_nullable_to_non_nullable
              as MeasurementUnit?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IngredientImpl extends _Ingredient {
  const _$IngredientImpl(
      {required this.id,
      required this.name,
      required this.description,
      this.defaultAmount,
      this.defaultUnit})
      : super._();

  factory _$IngredientImpl.fromJson(Map<String, dynamic> json) =>
      _$$IngredientImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final int? defaultAmount;
  @override
  final MeasurementUnit? defaultUnit;

  @override
  String toString() {
    return 'Ingredient(id: $id, name: $name, description: $description, defaultAmount: $defaultAmount, defaultUnit: $defaultUnit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IngredientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.defaultAmount, defaultAmount) ||
                other.defaultAmount == defaultAmount) &&
            (identical(other.defaultUnit, defaultUnit) ||
                other.defaultUnit == defaultUnit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, description, defaultAmount, defaultUnit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IngredientImplCopyWith<_$IngredientImpl> get copyWith =>
      __$$IngredientImplCopyWithImpl<_$IngredientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IngredientImplToJson(
      this,
    );
  }
}

abstract class _Ingredient extends Ingredient implements IIngredient {
  const factory _Ingredient(
      {required final String id,
      required final String name,
      required final String description,
      final int? defaultAmount,
      final MeasurementUnit? defaultUnit}) = _$IngredientImpl;
  const _Ingredient._() : super._();

  factory _Ingredient.fromJson(Map<String, dynamic> json) =
      _$IngredientImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  int? get defaultAmount;
  @override
  MeasurementUnit? get defaultUnit;
  @override
  @JsonKey(ignore: true)
  _$$IngredientImplCopyWith<_$IngredientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecipeStep _$RecipeStepFromJson(Map<String, dynamic> json) {
  return _RecipeStep.fromJson(json);
}

/// @nodoc
mixin _$RecipeStep {
  Ingredient get ingredient => throw _privateConstructorUsedError;
  MeasurementUnit get unit => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeStepCopyWith<RecipeStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeStepCopyWith<$Res> {
  factory $RecipeStepCopyWith(
          RecipeStep value, $Res Function(RecipeStep) then) =
      _$RecipeStepCopyWithImpl<$Res, RecipeStep>;
  @useResult
  $Res call({Ingredient ingredient, MeasurementUnit unit, int amount});

  $IngredientCopyWith<$Res> get ingredient;
}

/// @nodoc
class _$RecipeStepCopyWithImpl<$Res, $Val extends RecipeStep>
    implements $RecipeStepCopyWith<$Res> {
  _$RecipeStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredient = null,
    Object? unit = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      ingredient: null == ingredient
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as Ingredient,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as MeasurementUnit,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IngredientCopyWith<$Res> get ingredient {
    return $IngredientCopyWith<$Res>(_value.ingredient, (value) {
      return _then(_value.copyWith(ingredient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecipeStepImplCopyWith<$Res>
    implements $RecipeStepCopyWith<$Res> {
  factory _$$RecipeStepImplCopyWith(
          _$RecipeStepImpl value, $Res Function(_$RecipeStepImpl) then) =
      __$$RecipeStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Ingredient ingredient, MeasurementUnit unit, int amount});

  @override
  $IngredientCopyWith<$Res> get ingredient;
}

/// @nodoc
class __$$RecipeStepImplCopyWithImpl<$Res>
    extends _$RecipeStepCopyWithImpl<$Res, _$RecipeStepImpl>
    implements _$$RecipeStepImplCopyWith<$Res> {
  __$$RecipeStepImplCopyWithImpl(
      _$RecipeStepImpl _value, $Res Function(_$RecipeStepImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredient = null,
    Object? unit = null,
    Object? amount = null,
  }) {
    return _then(_$RecipeStepImpl(
      ingredient: null == ingredient
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as Ingredient,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as MeasurementUnit,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeStepImpl implements _RecipeStep {
  const _$RecipeStepImpl(
      {required this.ingredient, required this.unit, required this.amount});

  factory _$RecipeStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeStepImplFromJson(json);

  @override
  final Ingredient ingredient;
  @override
  final MeasurementUnit unit;
  @override
  final int amount;

  @override
  String toString() {
    return 'RecipeStep(ingredient: $ingredient, unit: $unit, amount: $amount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeStepImpl &&
            (identical(other.ingredient, ingredient) ||
                other.ingredient == ingredient) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ingredient, unit, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeStepImplCopyWith<_$RecipeStepImpl> get copyWith =>
      __$$RecipeStepImplCopyWithImpl<_$RecipeStepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeStepImplToJson(
      this,
    );
  }
}

abstract class _RecipeStep implements RecipeStep, IRecipeStep {
  const factory _RecipeStep(
      {required final Ingredient ingredient,
      required final MeasurementUnit unit,
      required final int amount}) = _$RecipeStepImpl;

  factory _RecipeStep.fromJson(Map<String, dynamic> json) =
      _$RecipeStepImpl.fromJson;

  @override
  Ingredient get ingredient;
  @override
  MeasurementUnit get unit;
  @override
  int get amount;
  @override
  @JsonKey(ignore: true)
  _$$RecipeStepImplCopyWith<_$RecipeStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return _Recipe.fromJson(json);
}

/// @nodoc
mixin _$Recipe {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  List<String> get instructions => throw _privateConstructorUsedError;
  List<RecipeStep> get steps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeCopyWith<Recipe> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeCopyWith<$Res> {
  factory $RecipeCopyWith(Recipe value, $Res Function(Recipe) then) =
      _$RecipeCopyWithImpl<$Res, Recipe>;
  @useResult
  $Res call(
      {String name,
      String id,
      List<String> instructions,
      List<RecipeStep> steps});
}

/// @nodoc
class _$RecipeCopyWithImpl<$Res, $Val extends Recipe>
    implements $RecipeCopyWith<$Res> {
  _$RecipeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? instructions = null,
    Object? steps = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<RecipeStep>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeImplCopyWith<$Res> implements $RecipeCopyWith<$Res> {
  factory _$$RecipeImplCopyWith(
          _$RecipeImpl value, $Res Function(_$RecipeImpl) then) =
      __$$RecipeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String id,
      List<String> instructions,
      List<RecipeStep> steps});
}

/// @nodoc
class __$$RecipeImplCopyWithImpl<$Res>
    extends _$RecipeCopyWithImpl<$Res, _$RecipeImpl>
    implements _$$RecipeImplCopyWith<$Res> {
  __$$RecipeImplCopyWithImpl(
      _$RecipeImpl _value, $Res Function(_$RecipeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? instructions = null,
    Object? steps = null,
  }) {
    return _then(_$RecipeImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      instructions: null == instructions
          ? _value._instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<RecipeStep>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeImpl extends _Recipe {
  const _$RecipeImpl(
      {required this.name,
      required this.id,
      required final List<String> instructions,
      required final List<RecipeStep> steps})
      : _instructions = instructions,
        _steps = steps,
        super._();

  factory _$RecipeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeImplFromJson(json);

  @override
  final String name;
  @override
  final String id;
  final List<String> _instructions;
  @override
  List<String> get instructions {
    if (_instructions is EqualUnmodifiableListView) return _instructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_instructions);
  }

  final List<RecipeStep> _steps;
  @override
  List<RecipeStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  String toString() {
    return 'Recipe(name: $name, id: $id, instructions: $instructions, steps: $steps)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._instructions, _instructions) &&
            const DeepCollectionEquality().equals(other._steps, _steps));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      id,
      const DeepCollectionEquality().hash(_instructions),
      const DeepCollectionEquality().hash(_steps));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeImplCopyWith<_$RecipeImpl> get copyWith =>
      __$$RecipeImplCopyWithImpl<_$RecipeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeImplToJson(
      this,
    );
  }
}

abstract class _Recipe extends Recipe implements IRecipe {
  const factory _Recipe(
      {required final String name,
      required final String id,
      required final List<String> instructions,
      required final List<RecipeStep> steps}) = _$RecipeImpl;
  const _Recipe._() : super._();

  factory _Recipe.fromJson(Map<String, dynamic> json) = _$RecipeImpl.fromJson;

  @override
  String get name;
  @override
  String get id;
  @override
  List<String> get instructions;
  @override
  List<RecipeStep> get steps;
  @override
  @JsonKey(ignore: true)
  _$$RecipeImplCopyWith<_$RecipeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

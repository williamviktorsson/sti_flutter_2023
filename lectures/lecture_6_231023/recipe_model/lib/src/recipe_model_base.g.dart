// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ingredient _$$_IngredientFromJson(Map<String, dynamic> json) =>
    _$_Ingredient(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      defaultAmount: json['defaultAmount'] as int?,
      defaultUnit:
          $enumDecodeNullable(_$MeasurementUnitEnumMap, json['defaultUnit']),
    );

Map<String, dynamic> _$$_IngredientToJson(_$_Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'defaultAmount': instance.defaultAmount,
      'defaultUnit': _$MeasurementUnitEnumMap[instance.defaultUnit],
    };

const _$MeasurementUnitEnumMap = {
  MeasurementUnit.ml: 'ml',
  MeasurementUnit.dl: 'dl',
  MeasurementUnit.cl: 'cl',
  MeasurementUnit.krm: 'krm',
  MeasurementUnit.msk: 'msk',
  MeasurementUnit.tsk: 'tsk',
  MeasurementUnit.st: 'st',
  MeasurementUnit.gram: 'gram',
};

_$_RecipeStep _$$_RecipeStepFromJson(Map<String, dynamic> json) =>
    _$_RecipeStep(
      ingredient:
          Ingredient.fromJson(json['ingredient'] as Map<String, dynamic>),
      unit: $enumDecode(_$MeasurementUnitEnumMap, json['unit']),
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$$_RecipeStepToJson(_$_RecipeStep instance) =>
    <String, dynamic>{
      'ingredient': instance.ingredient,
      'unit': _$MeasurementUnitEnumMap[instance.unit]!,
      'amount': instance.amount,
    };

_$_Recipe _$$_RecipeFromJson(Map<String, dynamic> json) => _$_Recipe(
      name: json['name'] as String,
      id: json['id'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_RecipeToJson(_$_Recipe instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'instructions': instance.instructions,
      'steps': instance.steps,
    };

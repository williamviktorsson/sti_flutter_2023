import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';

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

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      defaultAmount: json['defaultAmount'] == null
          ? null
          : IngredientAmount.fromJson(json['defaultAmount']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'defaultAmount': defaultAmount?.toJson(),
      };

  String serialize() {
    final json = toJson();
    final string = jsonEncode(json);
    return string;
  }

  factory Ingredient.deserialize(String serialized) {
    return Ingredient.fromJson(jsonDecode(serialized));
  }
}

class IngredientAmount {
  final double amount;
  final MeasurementUnit unit;

  IngredientAmount({required this.amount, required this.unit});

  factory IngredientAmount.fromJson(Map<String, dynamic> json) {
    return IngredientAmount(
      amount: json['amount'],
      unit: MeasurementUnit.values[json['unit']],
    );
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'unit': unit.index,
      };
}

class Recipe {
  final String id;
  final String name;
  final String description;
  final Map<Ingredient, IngredientAmount> ingredients;
  final List<String> instructions;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    Map<Ingredient, IngredientAmount> ingredients = {};

    (json['ingredients'] as Map<String, dynamic>).forEach((key, value) {
      ingredients[Ingredient.fromJson(jsonDecode(
              key))] = // Using JSON decoding for the key because map keys need to be strings.
          IngredientAmount.fromJson(value);
    });

    return Recipe(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      ingredients: ingredients,
      instructions: List<String>.from(json['instructions']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'ingredients': ingredients.map((key, value) => MapEntry(
            jsonEncode(key.toJson()),
            value
                .toJson())), // Using JSON encoding for the key because map keys need to be strings.
        'instructions': instructions,
      };

  String serialize() => jsonEncode(toJson());
  factory Recipe.deserialize(String serialized) {
    return Recipe.fromJson(jsonDecode(serialized));
  }

  addIngredient(Ingredient ingredient, IngredientAmount amount) {
    ingredients[ingredient] = amount;
  }

  addDescription(String description) {
    instructions.add(description);
  }
}

class RecipeRepository {
  late Box<String> _recipeBox;

  RecipeRepository() {
    // nit (petig) : användaren kanske själv vill konfigurera var datat ska sparas
    Directory directory = Directory.current;
    Hive.init(directory.path);
  }

  Future<void> initialize() async {
    // asynkron operation, tar obestämd (men snabb) tid att öppna vår datalagring.
    _recipeBox = await Hive.openBox('recipes');
  }

  bool create(Recipe recipe) {
    if (!Hive.isBoxOpen("recipes")) {
      throw StateError("Please await RecipeRepository initialize method");
    }
    var existingRecipe = _recipeBox.get(recipe.id);
    if (existingRecipe != null) {
      return false;
    }
    _recipeBox.put(recipe.id, recipe.serialize());
    return true;
  }

  Recipe? read(String id) {
    var serialized = _recipeBox.get(id);
    return serialized != null ? Recipe.deserialize(serialized) : null;
  }

  Recipe update(Recipe recipe) {
    var existingRecipe = _recipeBox.get(recipe.id);
    if (existingRecipe == null) {
      throw Exception('Recipe not found');
    }
    _recipeBox.put(recipe.id, recipe.serialize());
    return recipe;
  }

  bool delete(String id) {
    var existingRecipe = _recipeBox.get(id);
    if (existingRecipe != null) {
      _recipeBox.delete(id);
      return true;
    }
    return false;
  }

  List<Recipe> list() => _recipeBox.values
      .map((serialized) => Recipe.deserialize(serialized))
      .toList();
}

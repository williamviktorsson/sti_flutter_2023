import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

enum MeasurementUnit { tsk, msk, dl, cl, undefined }

@immutable
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

@immutable
class Recipe {
  final String id;
  final String name;
  final String description;
  final Map<Ingredient, IngredientAmount> _ingredients;
  final List<String> _instructions;

  List<String> get instructions => List.unmodifiable(_instructions);
  Map<Ingredient, IngredientAmount> get ingredients =>
      Map.unmodifiable(_ingredients);

  // const here does not guarantee that instructions/ingredients is immutable
  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required Map<Ingredient, IngredientAmount> ingredients,
    required List<String> instructions,
  })  : _ingredients = ingredients,
        _instructions = instructions;

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

  void addInstruction(String instruction) {
    instructions.add(instruction);
  }

  // sätt att underlätta modifiering av objekt
  // 1. mutera objektet rakt av. T.ex. via
  // fördelar: överenstämmer med mångas bild av oop, objektet definierar själv hur det kan modifieras
  // fördelar: läsbart
  // fördelar: enkelt
  // fördelar: solid? SRP?

  // nackdelar: muterbarhet KAN vara en oönskad egenskap
  // Premature optimization ?
  // KISS  ?
  // YAGNI ?

  // farliga saker med muterbart data
  // 1. gui operationer ändrar datat där det cacheat (sidoeffekt)
  // - filtrerar en lista (filtrerar också cachead lista)
  // - vanligt om man inte är super pedantisk

  // 2. Mutera objektet i klassen, MEN returnera ett nytt objekt (bryter till viss del oop-principer)
  // känns fel

  // 3. Hjälpklass för att utföra uppdateringar, skicka in objektet och få tillbaka en uppdaterad version. Fungerar vid immutability

  

}

void main(List<String> args) {
  Recipe recipe = Recipe(
      id: "id",
      name: "name",
      description: "description",
      ingredients: {},
      instructions: []);

  print(recipe.serialize());
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

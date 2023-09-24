import 'package:recipe_model/recipe_model.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Recipe tests', () {
    final repository = RecipeRepository();

    setUp(() {
      // Additional setup goes here.
    });

    test('Create Ingredient', () {
      Ingredient ingredient =
          Ingredient(id: "asd", name: "Salt", description: "description");
      expect(ingredient, isNotNull);
    });

    test('Edit Recipe', () {
      Recipe recipe = Recipe(
          id: "1258",
          name: "goda köttbullar",
          description: "supergoda",
          ingredients: {},
          instructions: []);
      Ingredient ingredient =
          Ingredient(id: "asdas", name: "Salt", description: "description");
      recipe.addIngredient(
          ingredient, IngredientAmount(amount: 2, unit: MeasurementUnit.tsk));
      recipe.addDescription("Add salt while cooking");

      // Check that the manager's current recipe is the same as our recipe
      expect(recipe.id, equals(recipe.id));
      expect(recipe.name, equals(recipe.name));
      expect(recipe.description, equals(recipe.description));

      // Check the ingredients were added correctly
      var saltAmount = recipe.ingredients[ingredient];
      expect(saltAmount?.amount, equals(2));
      expect(saltAmount?.unit, equals(MeasurementUnit.tsk));

      // Check that the description was added
      expect(recipe.instructions, contains("Add salt while cooking"));
    });

    test('Add Recipe to Repository', () {
      var recipe = Recipe(
          id: "2222",
          name: "pancakes",
          description: "fluffy pancakes",
          instructions: [],
          ingredients: {});
      bool result = repository.create(recipe);
      expect(result, isTrue);
    });

    test('Read Recipe from Repository', () {
      var recipe = repository.read("2222");
      expect(recipe?.id, equals("2222"));
      expect(recipe?.name, equals("pancakes"));
      expect(recipe?.description, equals("fluffy pancakes"));
    });

    test('Update Recipe in Repository', () {
      var updatedRecipe = Recipe(
          id: "2222",
          name: "pancakes",
          description: "extra fluffy pancakes",
          ingredients: {},
          instructions: []);
      var returnedRecipe = repository.update(updatedRecipe);
      expect(returnedRecipe.description, equals("extra fluffy pancakes"));
    });

    test('Delete Recipe from Repository', () {
      bool deleted = repository.delete("2222");
      expect(deleted, isTrue);
      var recipe = repository.read("2222");
      expect(recipe, isNull);
    });
  });
}

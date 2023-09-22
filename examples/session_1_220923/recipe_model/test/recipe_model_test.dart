import 'package:recipe_model/recipe_model.dart';
import 'package:test/test.dart';

void main() {
  group('Recipe tests', () {
    final repository = RecipeRepository();

    setUp(() {
      // Additional setup goes here.
    });

    test('Create Ingredient', () {
      Ingredient ingredient =
          Ingredient(name: "Salt", description: "description");
      expect(ingredient, isNotNull);
    });

    test('Edit Recipe', () {
      var manager = RecipeEditingManager();
      var recipe = Recipe(
        id: "1258",
        name: "goda köttbullar",
        description: "supergoda",
      );
      manager.startEditing(recipe);
      expect(manager.currentRecipe, isNotNull);
    });

    test('Add Step to Recipe', () {
      Ingredient ingredient =
          Ingredient(id: "123", name: "Salt", description: "description");
      var manager = RecipeEditingManager();
      var recipe = Recipe(
        id: "1258",
        name: "goda köttbullar",
        description: "supergoda",
      );
      manager.startEditing(recipe);
      manager.addStep(RecipeStep(
          ingredient: ingredient,
          amount: 15,
          unit: MeasurementUnit.tsk,
          description: "salta köttbullarna"));
      expect(manager.currentRecipe?.steps, isNotEmpty);
    });

    test('Add Recipe to Repository', () {
      var recipe = Recipe(
        id: "2222",
        name: "pancakes",
        description: "fluffy pancakes",
      );
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
      );
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

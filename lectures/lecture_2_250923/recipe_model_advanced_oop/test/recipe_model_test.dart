import 'dart:io';

import 'package:recipe_model/recipe_model.dart';
import 'package:test/test.dart';

void main() {
  final RecipeRepository recipeRepo = RecipeRepository.instance;
  final IngredientRepository ingredientRepo = IngredientRepository.instance;

  setUpAll(() async {
    Directory directory = Directory.current;
    await ingredientRepo.initialize(filePath: directory.path);
    await recipeRepo.initialize(filePath: directory.path);
  });

  tearDownAll(() async {
    await ingredientRepo.destroy();
    await recipeRepo.destroy();
  });

  group('IngredientRepository Tests', () {
    test('Create Ingredient', () async {
      final ingredient = Ingredient(
        id: '1',
        name: 'Salt',
        description: 'Common seasoning.',
        defaultAmount: 5,
        defaultUnit: MeasurementUnit.tsk,
      );

      final result = await ingredientRepo.create(ingredient);
      expect(result.isSuccess, isTrue);
    });

    test('Read Ingredient', () async {
      final result = await ingredientRepo.read('1');
      expect(result.isSuccess, isTrue);
      expect(result.value?.name, 'Salt');
    });

    test('Update Ingredient', () async {
      final updatedIngredient = Ingredient(
        id: '1',
        name: 'Salt',
        description: 'Common seasoning.',
        defaultAmount: 5,
        defaultUnit: MeasurementUnit.tsk,
      ).copyWith(name: "Sea Salt");

      final result = await ingredientRepo.update('1', updatedIngredient);
      expect(result.isSuccess, isTrue);
    });

    test('Verify Updated Ingredient', () async {
      final result = await ingredientRepo.read('1');
      expect(result.isSuccess, isTrue);
      expect(result.value?.name, 'Sea Salt');
    });

    // Add more tests for IngredientRepository
  });

  group('RecipeRepository Tests', () {
    test('Create Recipe', () async {
      final recipeStep = RecipeStep(
        ingredient: Ingredient(
          id: '1',
          name: 'Salt',
          description: 'Common seasoning.',
          defaultAmount: 5,
          defaultUnit: MeasurementUnit.tsk,
        ),
        unit: MeasurementUnit.tsk,
        amount: 5,
      );

      final recipe = Recipe(
        name: "Super Tasty",
        id: '1',
        instructions: ['Add salt to taste.'],
        steps: [recipeStep],
      );

      final result = await recipeRepo.create(recipe);
      expect(result.isSuccess, isTrue);
    });

    test('Read Recipe', () async {
      final result = await recipeRepo.read('1');
      expect(result.isSuccess, isTrue);
      expect(result.value?.instructions[0], 'Add salt to taste.');
    });

    test('Update Recipe', () async {
      final recipeStep = RecipeStep(
        ingredient: Ingredient(
          id: '1',
          name: 'Salt',
          description: 'Common seasoning.',
          defaultAmount: 5,
          defaultUnit: MeasurementUnit.tsk,
        ),
        unit: MeasurementUnit.tsk,
        amount: 5,
      );

      final recipe = Recipe(
        name: "Super Tasty",
        id: '1',
        instructions: ['Add salt to taste.'],
        steps: [recipeStep],
      );

      final updatedRecipe = recipe.copyWith(
        instructions: ['Add sea salt to taste.'],
      );

      updatedRecipe.addInstruction("instruction");

      final result = await recipeRepo.update('1', updatedRecipe);
      expect(result.isSuccess, isTrue);
    });

    test('Verify Updated Recipe', () async {
      final result = await recipeRepo.read('1');
      expect(result.isSuccess, isTrue);
      expect(result.value?.instructions[0], 'Add sea salt to taste.');
    });

    // Add more tests for RecipeRepository
  });
}

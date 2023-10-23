import 'package:flutter/material.dart';
import 'package:recipe_app/views/recipes/add_recipe_step_dialog.dart';
import 'package:recipe_model/recipe_model.dart';
import 'package:uuid/uuid.dart';

class EditRecipeModal extends StatefulWidget {
  final Recipe? existingRecipe;

  const EditRecipeModal({super.key, this.existingRecipe});

  @override
  State<EditRecipeModal> createState() => _EditRecipeModalState();
}

class _EditRecipeModalState extends State<EditRecipeModal> {

  // add a form key and a name controller and a reference to the recipe being edited

  @override
  void initState() {
    // use the existing recipe passed to widget or create a new recipe if none is passed
    super.initState();
  }

  // todo: add a form with a textformfield for the name of the recipe
  // add a listview with a listtile for each step of the recipe
  // add a button to add a step to the recipe
  // add a button to save the recipe
  // add a popup dialog for adding an instruction
  // add a popup dialog for adding a recipe step
  // on close, read value passed through navigation pop, and update edited recipe
  

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("This is the edit recipe modal..."));
  }
}

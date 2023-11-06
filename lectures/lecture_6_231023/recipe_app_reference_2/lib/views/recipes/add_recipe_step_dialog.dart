import 'package:flutter/material.dart';
import 'package:recipe_model/recipe_model.dart';

class AddRecipeStepDialog extends StatefulWidget {
  const AddRecipeStepDialog({Key? key, required this.ingredients})
      : super(key: key);

  final List<Ingredient> ingredients;

  @override
  State<AddRecipeStepDialog> createState() => _AddRecipeStepDialogState();
}

class _AddRecipeStepDialogState extends State<AddRecipeStepDialog> {
  // widget returns alertdialog
  // add form key and ingredient, unit and amount variables
  // update state of widget when any value changes
  // use dropdownbuttons for ingredients and unit
  // numerical textfield for amount
  // return a recipe step when add is pressed using navigation pop

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Recipe Step'),
      content: Center(
        child: Text("content"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

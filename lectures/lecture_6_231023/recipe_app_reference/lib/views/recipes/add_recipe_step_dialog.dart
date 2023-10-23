
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
  Ingredient? ingredient;
  MeasurementUnit? unit;
  int? amount;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Recipe Step'),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<Ingredient>(
              value: ingredient,
              hint: const Text('Select an ingredient'),
              onChanged: (Ingredient? newValue) {
                setState(() {
                  ingredient = newValue;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select an ingredient';
                }
                return null;
              },
              items: widget.ingredients
                  .map((ingredient) => DropdownMenuItem<Ingredient>(
                        value: ingredient,
                        child: Text(ingredient.name),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<MeasurementUnit>(
              value: unit,
              hint: const Text('Select a unit'),
              onChanged: (MeasurementUnit? newValue) {
                setState(() {
                  unit = newValue;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a unit';
                }
                return null;
              },
              items: MeasurementUnit.values
                  .map((unit) => DropdownMenuItem<MeasurementUnit>(
                        value: unit,
                        child: Text(unit.toString().split('.').last),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amount = int.tryParse(value);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                final amount = int.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (ingredient != null && unit != null && amount != null) {
                Navigator.pop(
                    context,
                    RecipeStep(
                        ingredient: ingredient!, unit: unit!, amount: amount!));
              }
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

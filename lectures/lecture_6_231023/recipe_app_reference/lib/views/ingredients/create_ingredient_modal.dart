import 'package:flutter/material.dart';
import 'package:recipe_model/recipe_model.dart';
import 'package:uuid/uuid.dart';

class CreateIngredientModal extends StatefulWidget {
  const CreateIngredientModal({
    super.key,
  });

  @override
  State<CreateIngredientModal> createState() => _CreateIngredientModalState();
}

class _CreateIngredientModalState extends State<CreateIngredientModal> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Ingredient Name',
                          hintText: 'Enter the name of the ingredient',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter the description of the ingredient',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      )
                    ],
                  ),
                ),
              )),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: const Text('Close'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final future = IngredientRepository.instance.create(
                            Ingredient(
                                id: const Uuid().v4(),
                                name: _nameController.text,
                                description: _descriptionController.text));
                        Navigator.pop(context, future);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
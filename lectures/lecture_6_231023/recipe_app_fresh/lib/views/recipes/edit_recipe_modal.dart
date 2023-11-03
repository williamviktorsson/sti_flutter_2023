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

class _EditRecipeModalState extends State<EditRecipeModal>
    with TickerProviderStateMixin {
  // add a form key and a name controller and a reference to the recipe being edited
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

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
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  child: Center(
                      child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    // returns error text if validation fails, null otherwise
                                    if (value == null || value == "") {
                                      return "Recipe name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Recipe Name',
                                    hintText: 'Enter the name of the recipe',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    // returns error text if validation fails, null otherwise
                                    if (value == null || value == "") {
                                      return "Recipe name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Recipe Name',
                                    hintText: 'Enter the name of the recipe',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    // returns error text if validation fails, null otherwise
                                    if (value == null || value == "") {
                                      return "Recipe name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Recipe Name',
                                    hintText: 'Enter the name of the recipe',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    // returns error text if validation fails, null otherwise
                                    if (value == null || value == "") {
                                      return "Recipe name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Recipe Name',
                                    hintText: 'Enter the name of the recipe',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    // returns error text if validation fails, null otherwise
                                    if (value == null || value == "") {
                                      return "Recipe name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Recipe Name',
                                    hintText: 'Enter the name of the recipe',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    // returns error text if validation fails, null otherwise
                                    if (value == null || value == "") {
                                      return "Recipe name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Recipe Name',
                                    hintText: 'Enter the name of the recipe',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    // returns error text if validation fails, null otherwise
                                    if (value == null || value == "") {
                                      return "Recipe name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Recipe Name',
                                    hintText: 'Enter the name of the recipe',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    // returns error text if validation fails, null otherwise
                                    if (value == null || value == "") {
                                      return "Recipe name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Recipe Name',
                                    hintText: 'Enter the name of the recipe',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    // returns error text if validation fails, null otherwise
                                    if (value == null || value == "") {
                                      return "Recipe name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Recipe Name',
                                    hintText: 'Enter the name of the recipe',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    // returns error text if validation fails, null otherwise
                                    if (value == null || value == "") {
                                      return "Recipe name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Recipe Name',
                                    hintText: 'Enter the name of the recipe',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    // returns error text if validation fails, null otherwise
                                    if (value == null || value == "") {
                                      return "Recipe name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Recipe Name',
                                    hintText: 'Enter the name of the recipe',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                  ),
                                ),
                              ],
                            ),
                          )))),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FilledButton(
                    child: const Text('Save'),
                    onPressed: () {
                      final name = _nameController.text; // name is "" if empty

                      final success = _formKey.currentState!.validate();

                      if (success) {
                        final recipe = Recipe(
                          id: const Uuid().v4(),
                          name: name,
                          instructions: [],
                          steps: [],
                        );
                        Navigator.of(context).pop(recipe);
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

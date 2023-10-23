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
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController =
      TextEditingController(text: widget.existingRecipe?.name);

  late Recipe editedRecipe;

  @override
  void initState() {
    editedRecipe = widget.existingRecipe?.copyWith() ??
        Recipe(id: const Uuid().v4(), instructions: [], steps: [], name: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
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
                          labelText: 'Recipe Name',
                          hintText: 'Enter the name of the recipe',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        onChanged: (value) {
                          setState(() {
                            editedRecipe = editedRecipe.copyWith(name: value);
                          });
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FilledButton(
                            onPressed: () async {
                              final result = await showDialog<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  TextEditingController controller =
                                      TextEditingController();
                                  return AlertDialog(
                                    title: const Text('Add Instruction'),
                                    content: TextFormField(
                                      controller: controller,
                                      decoration: const InputDecoration(
                                        labelText: 'Instruction',
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
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
                                          Navigator.pop(
                                              context, controller.text);
                                        },
                                        child: const Text('Add'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (result != null) {
                                setState(() {
                                  editedRecipe = editedRecipe.copyWith(
                                      instructions: [
                                        ...editedRecipe.instructions,
                                        result
                                      ]);
                                });
                              }
                            },
                            child: const Text('Add Instruction'),
                          ),
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: () async {
                              IngredientRepository.instance
                                  .list()
                                  .then((ingredients) async {
                                final result = await showDialog<RecipeStep>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddRecipeStepDialog(
                                        ingredients: ingredients.value!);
                                  },
                                );

                                if (result != null) {
                                  setState(() {
                                    editedRecipe = editedRecipe.copyWith(
                                        steps: [...editedRecipe.steps, result]);
                                  });
                                }
                              });
                            },
                            child: const Text('Add Step'),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Instructions',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: editedRecipe.instructions.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 8),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(editedRecipe.instructions[index]),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              editedRecipe =
                                                  editedRecipe.copyWith(
                                                      instructions: [
                                                ...editedRecipe.instructions
                                              ]..removeAt(index));
                                            });
                                          },
                                          icon: const Icon(Icons.delete))
                                    ],
                                  ));
                            },
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Steps',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: editedRecipe.steps.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 8),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${editedRecipe.steps[index].ingredient.name} - ${editedRecipe.steps[index].amount} ${editedRecipe.steps[index].unit.toString().split('.').last}"),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              editedRecipe =
                                                  editedRecipe.copyWith(
                                                      steps: [
                                                ...editedRecipe.steps
                                              ]..removeAt(index));
                                            });
                                          },
                                          icon: const Icon(Icons.delete))
                                    ],
                                  ));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
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
                      if (widget.existingRecipe != null) {
                        final future = RecipeRepository.instance
                            .update(widget.existingRecipe!.id, editedRecipe);
                        Navigator.pop(context, future);
                      } else {
                        final future =
                            RecipeRepository.instance.create(editedRecipe);
                        Navigator.pop(context, future);
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipe_model/recipe_model.dart';

import 'edit_recipe_modal.dart';
import 'recipe_detail_view.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({Key? key}) : super(key: key);

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  var recipesFuture = RecipeRepository.instance.list();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: recipesFuture,
          builder: (context, snapshot) {
            final result = snapshot.data;

            if (result != null) {
              // data is ready  to be displayed
              if (result.isFailure) {
                return Center(child: Text(result.error.toString()));
              } else {
                final recipes = result.value;
                return ListView.builder(
                    itemCount: recipes!.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeDetailView(recipe: recipe)));
                        },
                        title: Text(recipe.name),
                        subtitle: Text('${recipe.steps.length} steps'),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              showEditRecipeModal(context, recipe);
                            } else if (value == 'delete') {
                              final future =
                                  RecipeRepository.instance.delete(recipe.id);
                              future.then((result) {
                                if (result.isSuccess) {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Recipe deleted"),
                                    backgroundColor: Colors.green,
                                  ));
                                  setState(() {
                                    // update list
                                    recipesFuture =
                                        RecipeRepository.instance.list();
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Error deleting recipe"),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              });
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ],
                          child: const Icon(Icons.more_vert),
                        ),
                      );
                    });
              }
            } else if (snapshot.hasError) {
              // error
              return const Center(child: Text("Error"));
            } else {
              // loading
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showEditRecipeModal(context);
          },
          label: const Text("New recipe")),
    );
  }

  void showEditRecipeModal(BuildContext context, [Recipe? existingRecipe]) {
    showModalBottomSheet<Future<ActionResult<Recipe>>?>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return EditRecipeModal(
          existingRecipe: existingRecipe,
        );
      },
    ).then((future) {
      if (future != null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Creating recipe..."),
        ));
        future.then((result) {
          if (result.isSuccess) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Recipe created"),
              backgroundColor: Colors.green,
            ));
            setState(() {
              // update list
              recipesFuture = RecipeRepository.instance.list();
            });
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Error creating recipe"),
              backgroundColor: Colors.red,
            ));
          }
        });
      }
    });
  }
}
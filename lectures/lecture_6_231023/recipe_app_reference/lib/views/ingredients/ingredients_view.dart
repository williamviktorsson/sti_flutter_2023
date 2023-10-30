import 'package:flutter/material.dart';
import 'package:recipe_app/views/ingredients/create_ingredient_modal.dart';
import 'package:recipe_model/recipe_model.dart';

class IngredientsView extends StatefulWidget {
  const IngredientsView({Key? key}) : super(key: key);

  @override
  State<IngredientsView> createState() => _IngredientsViewState();
}


class _IngredientsViewState extends State<IngredientsView> {
  var ingredientsFuture = IngredientRepository.instance.list();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: ingredientsFuture,
          builder: (context, snapshot) {
            final result = snapshot.data;

            if (result != null) {
              // data is ready  to be displayed
              if (result.isFailure) {
                return Center(child: Text(result.error.toString()));
              } else {
                final ingredients = result.value;
                return ListView.builder(
                    itemCount: ingredients!.length,
                    itemBuilder: (context, index) {
                      final ingredient = ingredients[index];
                      return ListTile(
                        title: Text(ingredient.name),
                        subtitle: Text(ingredient.description),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            final future = IngredientRepository.instance
                                .delete(ingredient.id);
                            future.then((result) {
                              if (result.isSuccess) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Ingredient deleted"),
                                  backgroundColor: Colors.green,
                                ));
                                setState(() {
                                  // update list
                                  ingredientsFuture =
                                      IngredientRepository.instance.list();
                                });
                              } else {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Error deleting ingredient"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            });
                          },
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
            showModalBottomSheet<Future<ActionResult<Ingredient>>?>(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return const CreateIngredientModal();
              },
            ).then((future) {
              if (future != null) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Creating ingredient..."),
                ));
                future.then((result) {
                  if (result.isSuccess) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Ingredient created"),
                      backgroundColor: Colors.green,
                    ));
                    setState(() {
                      // update list
                      ingredientsFuture = IngredientRepository.instance.list();
                    });
                  } else {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Error creating ingredient"),
                      backgroundColor: Colors.red,
                    ));
                  }
                });
              }
            });
          },
          label: const Text("New ingredient")),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipe_app/views/recipes/edit_recipe_modal.dart';
import 'package:recipe_model/recipe_model.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({Key? key}) : super(key: key);

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class SlowPageRoute extends MaterialPageRoute {
  SlowPageRoute({required WidgetBuilder builder})
      : super(builder: builder, maintainState: true);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 750);

  // lots of other things such as fading, sliding, etc.
}

class _RecipesViewState extends State<RecipesView> {
  // stateful widget as we will want to update the recipes list when actions are performed

  var recipesFuture = RecipeRepository.instance.list();

  @override
  Widget build(BuildContext context) {
    // create a scaffold with a futurebuilding
    // show progress when loading
    // otherwise show recipes as listtiles
    // add a fab which creates recipes and updates the list
    // fab can use a modal bottom sheet to show create recipe modal

    return Navigator(
      restorationScopeId: "recipesView",
      onGenerateRoute: (settings) => MaterialPageRoute(
        settings: settings,
        builder: (
          context,
        ) =>
            FutureBuilder(
                future: recipesFuture,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    final recipes = snapshot.data!.value!;

                    return Scaffold(
                      body: ListView.builder(
                          itemBuilder: (context, index) {
                            final recipe = recipes[index];
                            return Hero(
                              tag: recipe.id,
                              child: Material(
                                // to make hero work properly
                                child: ListTile(
                                  onTap: () {
                                    // todo: navigate to recipe detail view
                                    Navigator.of(context).push(SlowPageRoute(
                                        builder: (context) =>
                                            RecipeDetailedView(
                                              recipe: recipe,
                                            )));
                                  },
                                  title: Text(recipe.name),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      // todo: open popup dialog, delete on confirm
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                            false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Deletion dialog'),
                                            content: const Text(
                                                "confirm recipe delete"),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('delete'),
                                                onPressed: () {
                                                  RecipeRepository.instance
                                                      .delete(recipe.id);
                                                  setState(() {
                                                    recipesFuture =
                                                        RecipeRepository
                                                            .instance
                                                            .list();
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: recipes.length),
                      floatingActionButton: FloatingActionButton.extended(
                          onPressed: () async {
                            final recipeResult = await showDialog<Recipe>(
                              context: context,
                              builder: (BuildContext context) {
                                return const EditRecipeModal();
                              },
                            );

                            // modal popped with new recipe
                            if (recipeResult != null) {
                              RecipeRepository.instance.create(recipeResult);
                              setState(() {
                                recipesFuture =
                                    RecipeRepository.instance.list();
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.green,
                                      content:
                                          Text("Successfully added recipe")));
                            }
                          },
                          label: const Text("Add Recipe")),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("error"));
                  } else {
                    // allt under 50ms är ungefär omedelbart
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
      ),
    );
  }
}

class RecipeDetailedView extends StatelessWidget {
  const RecipeDetailedView({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: recipe.id,
      child: Scaffold(
        appBar: AppBar(
          title: Text(recipe.name),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          color: Colors.greenAccent,
          child: const Center(
            child: Text("foobar"),
          ),
        ),
      ),
    );
  }
}

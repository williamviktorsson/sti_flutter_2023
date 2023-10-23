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
  // basically do the same as ingredients view
  // add a popup menu button to edit or delete a recipe
  // edit recipe can use a modal bottom sheet to show edit recipe modal
  // fab can use same modal to edit a newly created recipe
  // showmodalbottomsheet

  var recipesFuture = RecipeRepository.instance.list();

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("This is the recipes view..."));
  }
}

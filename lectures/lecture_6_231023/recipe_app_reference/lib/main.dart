import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_model/recipe_model.dart';
import 'views/ingredients/ingredients_view.dart';
import 'views/recipes/recipes_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final RecipeRepository recipeRepo = RecipeRepository.instance;
  final IngredientRepository ingredientRepo = IngredientRepository.instance;
  final directory = await getApplicationDocumentsDirectory();
  await ingredientRepo.initialize(filePath: directory.path);
  await recipeRepo.initialize(filePath: directory.path);
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const RecipesApp(),
  ));
}



class RecipesApp extends StatefulWidget {
  const RecipesApp({super.key});

  @override
  State<RecipesApp> createState() => _RecipesAppState();
}

class _RecipesAppState extends State<RecipesApp> {
  int currentPageIndex = 0;

  final List<Widget> views = const [IngredientsView(), RecipesView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.apple),
              label: 'Ingredients',
            ),
            NavigationDestination(
              icon: Icon(Icons.restaurant_menu),
              label: 'Recipes',
            )
          ],
        ),
        body: views[currentPageIndex]);
  }
}

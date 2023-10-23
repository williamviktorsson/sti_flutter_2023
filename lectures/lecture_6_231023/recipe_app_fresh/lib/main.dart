import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_model/recipe_model.dart';
import 'views/ingredients/ingredients_view.dart';
import 'views/recipes/recipes_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // required if you need to run platform native code before initializing the app
  // get app directory and initialize repos.

  IngredientRepository ingredientRepository = IngredientRepository.instance;
  RecipeRepository recipeRepository = RecipeRepository.instance;

  final directory = await getApplicationDocumentsDirectory();

  await ingredientRepository.initialize(filePath: directory.path);
  await recipeRepository.initialize(filePath: directory.path);

  runApp(MaterialApp(
    title: 'Recipes App',
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

  // TODO: Add a bottom navigation bar with two items: Ingredients and Recipes
  // Create NavigationDestinations with proper icons and labels
  // Create a list of NavigationDestinations

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: views[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: "Ingredients",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            label: "Recipes",
          ),
        ],
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      )
    );
  }
}

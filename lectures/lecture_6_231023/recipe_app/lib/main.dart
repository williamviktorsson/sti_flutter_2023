import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipe_model/recipe_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final RecipeRepository recipeRepo = RecipeRepository.instance;
  final IngredientRepository ingredientRepo = IngredientRepository.instance;
  final directory = await getApplicationDocumentsDirectory();
  await ingredientRepo.initialize(filePath: directory.path);
  await recipeRepo.initialize(filePath: directory.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

@immutable
class IconRoutePair {
  final Widget icon;
  final Widget route;

  const IconRoutePair({required this.icon, required this.route});
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  final List<IconRoutePair> iconRoutePairs = const [
    IconRoutePair(
        icon: NavigationDestination(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        route: Text("tester")),
    IconRoutePair(
        icon: NavigationDestination(
          icon: Icon(Icons.commute),
          label: 'Commute',
        ),
        route: Text("fester")),
    IconRoutePair(
        icon: NavigationDestination(
          selectedIcon: Icon(Icons.bookmark),
          icon: Icon(Icons.bookmark_border),
          label: 'Saved',
        ),
        route: Text("letser")),
  ];

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
          destinations: iconRoutePairs.map((e) => e.icon).toList(),
        ),
        body: iconRoutePairs[currentPageIndex].route);
  }
}

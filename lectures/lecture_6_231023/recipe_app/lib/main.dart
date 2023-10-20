import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipe_model/recipe_model.dart';

void main() async {
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Builder(builder: (context) {
          return Container(
              margin: const EdgeInsets.all(40.0), child: const TesterWidget());
        }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ValueNotifier<int>>().value++;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TesterWidget extends StatelessWidget {
  const TesterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Your score:',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const TestWidget(),
      ],
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // run rebuild if that which is being watched changes
    final value = context.watch<ValueNotifier<int>>().value;
    return Text(
      '$value',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

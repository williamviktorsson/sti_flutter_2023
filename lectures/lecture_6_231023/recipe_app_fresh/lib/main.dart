import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipe_model/recipe_model.dart';
import 'views/ingredients/ingredients_view.dart';
import 'views/recipes/recipes_view.dart';

import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006877),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFA4EEFF),
  onPrimaryContainer: Color(0xFF001F25),
  secondary: Color(0xFFA63A28),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFFFDAD4),
  onSecondaryContainer: Color(0xFF3F0300),
  tertiary: Color(0xFF814791),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFBD7FF),
  onTertiaryContainer: Color(0xFF330044),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFFFBFF),
  onBackground: Color(0xFF311300),
  surface: Color(0xFFFFFBFF),
  onSurface: Color(0xFF311300),
  surfaceVariant: Color(0xFFDBE4E7),
  onSurfaceVariant: Color(0xFF3F484B),
  outline: Color(0xFF6F797B),
  onInverseSurface: Color(0xFFFFEDE4),
  inverseSurface: Color(0xFF512400),
  inversePrimary: Color(0xFF52D7F0),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006877),
  outlineVariant: Color(0xFFBFC8CB),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF52D7F0),
  onPrimary: Color(0xFF00363F),
  primaryContainer: Color(0xFF004E5A),
  onPrimaryContainer: Color(0xFFA4EEFF),
  secondary: Color(0xFFFFB4A6),
  onSecondary: Color(0xFF650901),
  secondaryContainer: Color(0xFF862213),
  onSecondaryContainer: Color(0xFFFFDAD4),
  tertiary: Color(0xFFF1AFFF),
  onTertiary: Color(0xFF4E155F),
  tertiaryContainer: Color(0xFF672F78),
  onTertiaryContainer: Color(0xFFFBD7FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF311300),
  onBackground: Color(0xFFFFDBC7),
  surface: Color(0xFF311300),
  onSurface: Color(0xFFFFDBC7),
  surfaceVariant: Color(0xFF3F484B),
  onSurfaceVariant: Color(0xFFBFC8CB),
  outline: Color(0xFF899295),
  onInverseSurface: Color(0xFF311300),
  inverseSurface: Color(0xFFFFDBC7),
  inversePrimary: Color(0xFF006877),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF52D7F0),
  outlineVariant: Color(0xFF3F484B),
  scrim: Color(0xFF000000),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // required if you need to run platform native code before initializing the app
  // get app directory and initialize repos.

  IngredientRepository ingredientRepository = IngredientRepository.instance;
  RecipeRepository recipeRepository = RecipeRepository.instance;

  final directory = await getApplicationDocumentsDirectory();

  await ingredientRepository.initialize(filePath: directory.path);
  await recipeRepository.initialize(filePath: directory.path);
  await initializeDateFormatting(); // initialize this thing for date formatting

  ValueNotifier<Locale> selectedLocale =
      ValueNotifier(const Locale("sv", "SE"));

  runApp(
    ValueListenableBuilder(
        valueListenable: selectedLocale, // rebuild app on selectedLocale change
        builder: (context, locale, _) {
          return MaterialApp(
            title: 'Recipes App',
            theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
            darkTheme:
                ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
            home: ChangeNotifierProvider<ValueNotifier<Locale>>.value(
                // provide selectedLocale to the app
                value: selectedLocale,
                child: const RecipesApp()),
            locale: locale,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("sv", "SE"),
              Locale("en", "US"),
            ],
          );
        }),
  );
}

class RecipesApp extends StatefulWidget {
  const RecipesApp({super.key});

  @override
  State<RecipesApp> createState() => _RecipesAppState();
}

class _RecipesAppState extends State<RecipesApp>
    with AutomaticKeepAliveClientMixin {
  int currentPageIndex = 0;

  final List<Widget> views = [
    const IngredientsView(),
    const RecipesView(),
    const LocalizationView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: currentPageIndex,
          children: views,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank),
              label: "Ingredients",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank_outlined),
              label: "Recipes",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.language),
              label: "Locale",
            ),
          ],
          currentIndex: currentPageIndex,
          onTap: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class LocalizationView extends StatelessWidget {
  const LocalizationView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<Locale> selectedLocale =
        context.watch<ValueNotifier<Locale>>();
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text(selectedLocale.value.languageCode),
          TextButton(
            child: Text("show date picker"),
            onPressed: () {
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)));
            },
          )
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("${selectedLocale.value.countryCode}"),
        onPressed: () {
          if (selectedLocale.value.countryCode == "SE") {
            selectedLocale.value = const Locale("en", "US");
          } else {
            selectedLocale.value = const Locale("sv", "SE");
          }
        },
      ),
    );
  }
}

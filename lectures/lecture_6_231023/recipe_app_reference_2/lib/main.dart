import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/views/provider_example/provider_example.dart';
import 'package:recipe_model/recipe_model.dart';
import 'l10n/l10n.dart';
import 'views/ingredients/ingredients_view.dart';
import 'views/localization/localization_view.dart';
import 'views/recipes/recipes_view.dart';

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

  if (!kIsWeb) {
    final directory = await getApplicationDocumentsDirectory();

    await ingredientRepository.initialize(filePath: directory.path);
    await recipeRepository.initialize(filePath: directory.path);
  } else {
    await ingredientRepository.initializeWeb();
    await recipeRepository.initializeWeb();
  }
  await initializeDateFormatting(); // initialize this thing for date formatting

  ValueNotifier<Locale> selectedLocale =
      ValueNotifier(const Locale("sv", "SE"));

  runApp(
    ValueListenableBuilder(
        valueListenable: selectedLocale, // rebuild app on selectedLocale change
        builder: (context, locale, _) {
          return SafeArea(
            child: MaterialApp(
              title: 'Recipes App',
              theme:
                  //fromseed,
                  ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
              darkTheme:
                  ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
              home: ChangeNotifierProvider<ValueNotifier<Locale>>.value(
                  // provide selectedLocale to the app
                  value: selectedLocale,
                  child: const RecipesApp()),
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            ),
          );
        }),
  );
}

class RecipesApp extends StatelessWidget {
  const RecipesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool mobile = MediaQuery.of(context).size.width <= 600;

    return mobile
        ? const RecipesAppBottomNavigation()
        : const RecipesAppDrawer();
  }
}

class RecipesAppBottomNavigation extends StatefulWidget {
  const RecipesAppBottomNavigation({super.key});

  @override
  State<RecipesAppBottomNavigation> createState() =>
      _RecipesAppBottomNavigationState();
}

class _RecipesAppBottomNavigationState
    extends State<RecipesAppBottomNavigation> {
  int currentPageIndex = 0;
  late PageController _pageController;
  late List<Widget> views;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    views = [
      const IngredientsView(),
      const RecipesView(),
      const LocalizationView(),
    ];
    _pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: views,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.food_bank),
              label: AppLocalizations.of(context)!.ingredients,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.food_bank_outlined),
              label: AppLocalizations.of(context)!.recipes,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.language),
              label: AppLocalizations.of(context)!.localeName,
            ),
          ],
          currentIndex: currentPageIndex,
          onTap: (int index) {
            setState(() {
              currentPageIndex = index;
              _pageController.jumpToPage(currentPageIndex);
            });
          },
        ));
  }
}

class RecipesAppDrawer extends StatefulWidget {
  const RecipesAppDrawer({super.key});

  @override
  State<RecipesAppDrawer> createState() => _RecipesAppDrawerState();
}

class _RecipesAppDrawerState extends State<RecipesAppDrawer> {
  int currentPageIndex = 0;
  late PageController _pageController;
  late List<Widget> views;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    views = [
      const IngredientsView(),
      const RecipesView(),
      const LocalizationView(),
    ];
    _pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            minWidth: 50,
            destinations: [
              NavigationRailDestination(
                icon: const Icon(Icons.food_bank),
                label: Text(AppLocalizations.of(context)!.ingredients),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.food_bank_outlined),
                label: Text(AppLocalizations.of(context)!.recipes),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.language),
                label: Text(AppLocalizations.of(context)!.localeName),
              ),
            ],
            selectedIndex: currentPageIndex,
            useIndicator: true,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
                _pageController.jumpToPage(currentPageIndex);
              });
            },
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
              child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: views,
          )),
        ],
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipe_model/recipe_model.dart';
import 'l10n/l10n.dart';
import 'views/ingredients/ingredients_view.dart';
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

  final localeNotifier = ValueNotifier<Locale>(const Locale("sv"));

  runApp(
    ChangeNotifierProvider.value(
        value: localeNotifier,
        child: ChangeNotifierProvider(
          create: (_) => ValueNotifier<int>(0),
          child: Builder(builder: (context) {
            final currentLocale = context.watch<ValueNotifier<Locale>>().value;
            return MaterialApp(
              title: 'Recipes App',
              theme:
                  ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
              darkTheme:
                  ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
              home: const LayoutChooser(),
              locale: currentLocale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
            );
          }),
        )),
  );
}

class LayoutChooser extends StatelessWidget {
  const LayoutChooser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 600
        ? const DesktopView()
        : const RecipesApp();
  }
}

class DesktopView extends StatefulWidget {
  const DesktopView({super.key});

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  int currentPageIndex = 0;

  final List<Widget> views = const [
    IngredientsView(),
    RecipesView(),
    SettingsView()
  ];

  // TODO: Add a bottom navigation bar with two items: Ingredients and Recipes
  // Create NavigationDestinations with proper icons and labels
  // Create a list of NavigationDestinations

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // change to PageView to only load view when needed
      // requires adding automatickeepalive on child views to not dispose when hidden
      body: Row(
        children: [
          NavigationRail(
              onDestinationSelected: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
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
                  icon: const Icon(Icons.settings),
                  label: Text(AppLocalizations.of(context)!.recipes),
                ),
              ],
              selectedIndex: currentPageIndex),
          const VerticalDivider(),
          Expanded(
            child: IndexedStack(
              index: currentPageIndex,
              children: views,
            ),
          ),
        ],
      ),
    );
  }
}

class RecipesApp extends StatefulWidget {
  const RecipesApp({super.key});

  @override
  State<RecipesApp> createState() => _RecipesAppState();
}

class _RecipesAppState extends State<RecipesApp> {
  int currentPageIndex = 0;

  final List<Widget> views = const [
    IngredientsView(),
    RecipesView(),
    SettingsView()
  ];

  // TODO: Add a bottom navigation bar with two items: Ingredients and Recipes
  // Create NavigationDestinations with proper icons and labels
  // Create a list of NavigationDestinations

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // change to PageView to only load view when needed
        // requires adding automatickeepalive on child views to not dispose when hidden
        body: IndexedStack(
          index: currentPageIndex,
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
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.recipes,
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
}

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale selectedLocale = context.watch<ValueNotifier<Locale>>().value;
    return Center(
      child: DropdownButton<String>(
          value: selectedLocale.languageCode,
          items: AppLocalizations.supportedLocales
              .map((e) => DropdownMenuItem(
                  value: e.languageCode, child: Text(e.languageCode)))
              .toList(),
          onChanged: (country) {
            context.read<ValueNotifier<Locale>>().value = Locale(country!);
          }),
    );
  }
}

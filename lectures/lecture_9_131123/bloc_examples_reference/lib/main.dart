import 'package:bloc_examples/blocs/auth_bloc.dart';
import 'package:bloc_examples/blocs/counter_bloc.dart';
import 'package:bloc_examples/blocs/infinity_bloc.dart';
import 'package:bloc_examples/blocs/weather_bloc.dart';
import 'package:bloc_examples/views/counter_view.dart';
import 'package:bloc_examples/views/infinity_list_view.dart';
import 'package:bloc_examples/views/weather_api_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
          title: 'Bloc Examples',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
            useMaterial3: true,
          ),
          home: Builder(builder: (context) {
            final authBloc = context.watch<AuthBloc>();

            switch (authBloc.state.status) {
              case AuthStatus.authenticating:
                return const Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ));
              case AuthStatus.authenticated:
                return const SignedInView();
              case AuthStatus.initial:
              case AuthStatus.unauthenticated:
              default:
                return const SignedOutView();
            }
          })),
    );
  }
}

class SignedOutView extends StatelessWidget {
  const SignedOutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<AuthBloc>().add(AuthEvent.login);
        },
        child: const Text("Login"),
      ),
    ));
  }
}

class SignedInView extends StatelessWidget {
  const SignedInView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CounterBloc(),
        ),
        BlocProvider(
          create: (context) => InfinityBloc(),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
      ],
      child: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final List<Widget> views = const [
    CounterView(),
    InfinityListView(),
    WeatherAPIView(),
  ];

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  final List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.calculate_outlined),
      label: "Counter",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.view_list),
      label: "Infinity List",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Weather API",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, index, child) {
          return Scaffold(
              body: views[index],
              bottomNavigationBar: BottomNavigationBar(
                items: bottomItems,
                currentIndex: index,
                onTap: (int index) {
                  _selectedIndex.value = index;
                },
              ));
        });
  }
}

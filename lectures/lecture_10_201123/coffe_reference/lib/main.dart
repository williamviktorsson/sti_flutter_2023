import 'package:coffe_reference/bloc/orders_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffe demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final data = snapshot.data;

            if (snapshot.hasData && data != null) {
              User user = data;
              return Provider(create: (_) => user, child: LoginView());
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }

            return Center(
                child: FilledButton(
              onPressed: () {
                FirebaseAuth.instance.signInAnonymously();
              },
              child: const Text('Login'),
            ));
          }),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome :' + user.uid),
      ),
      body: BlocProvider(
          create: (context) => OrdersBloc(user: user)..add(LoadOrders()),
          child: const OrdersView()),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text("Logout"),
          onPressed: () {
            FirebaseAuth.instance.signOut();
          }),
    );
  }
}

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersBloc = context.watch<OrdersBloc>();

    return Column(
      children: [
        Center(
          child: Text(
            'Orders',
          ),
        ),
        Expanded(
            child: switch (ordersBloc.state) {
          OrderInitial() => Container(),
          OrderLoading() => Center(child: CircularProgressIndicator()),
          OrderLoaded(:var orders) => OrdersList(orders: orders),
          OrderError() => Center(child: Text('Something went wrong')),
        }),
        FilledButton(
            onPressed: () {
              ordersBloc.placeOrder();
            },
            child: Text("Place order"))
      ],
    );
  }
}

class OrdersList extends StatelessWidget {
  final List<Order> orders;

  const OrdersList({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text(order.placedAt.toString()),
            subtitle: Text(order.status.toString()),
          );
        });
  }
}

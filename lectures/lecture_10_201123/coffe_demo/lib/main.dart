import 'package:coffe_demo/bloc/orders_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;

void main() async {
  // ensure that the binding is initialized before launching app
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffe demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  ValueNotifier<int> index = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data;

          if (snapshot.hasData && data != null) {
            User user = data;

            return ValueListenableBuilder(
                valueListenable: index,
                builder: (context, i, _) {
                  return Scaffold(
                    body: [
                      BlocProvider(
                          create: (context) => OrdersBloc()
                            ..add(LoadOrders()), // ..add(LoadOrders()),
                          child: const CoffeView()),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("User id: " + user.uid),
                          ],
                        ),
                      ),
                    ][i],
                    bottomNavigationBar: ValueListenableBuilder(
                      valueListenable: index,
                      builder: (context, value, child) {
                        return BottomNavigationBar(
                          currentIndex: value,
                          onTap: (index) {
                            this.index.value = index;
                          },
                          items: [
                            BottomNavigationBarItem(
                              icon: Icon(Icons.coffee),
                              label: "Coffe",
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.person),
                              label: "Profile",
                            ),
                          ],
                        );
                      },
                    ),
                  );
                });
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          return Center(
            child: FilledButton(
                onPressed: () {
                  // create a user with unique id, that will remain logged in
                  // after app restart
                  FirebaseAuth.instance.signInAnonymously();
                },
                child: Text("Login")),
          );
        },
      ),
    );
  }
}

class CoffeView extends StatelessWidget {
  const CoffeView({super.key});

  @override
  Widget build(BuildContext context) {
    // coffe view reads coffe orders from orders bloc

    final ordersBloc = context.watch<OrdersBloc>();

    return switch (ordersBloc.state) {
      OrderInitial() => Center(child: Text("nothing loaded")),
      OrdersLoading() => Center(child: CircularProgressIndicator()),
      OrdersLoaded(:final orders) => OrdersListView(orders: orders),
      OrderError(:final message) => Center(child: Text(message)),
    };
  }
}

class OrdersListView extends StatelessWidget {
  final List<Order> orders;

  const OrdersListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (orders.isEmpty) {
          return Center(child: Text("no orders"));
        }

        return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              Order order = orders[index];

              String userId = FirebaseAuth.instance.currentUser!.uid;

              if (userId == order.userId) {
                return ListTile(
                  tileColor: Colors.lightGreenAccent,
                  title: Text(order.placedAt.toString()),
                  subtitle: Text(order.status.toString() + '\n' + order.userId),
                  isThreeLine: true,
                );
              }

              return ListTile(
                title: Text(order.placedAt.toString()),
                subtitle: Text(order.status.toString() + '\n' + order.userId),
                isThreeLine: true,
              );
            });
      }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            
            context.read<OrdersBloc>().add(CreateOrder(Order(
                  FirebaseAuth.instance.currentUser!.uid,
                  OrderStatus.queue,
                  DateTime.now(),
                  null,
                )));

          },
          label: Text("Order a coffe")),
    );
  }
}

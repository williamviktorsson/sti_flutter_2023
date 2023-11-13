import 'package:bloc_examples/blocs/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final counterbloc = context.watch<CounterBloc>();


    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Counter:',
              ),
              Text(
                '${counterbloc.state}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: ButtonBar(
          children: [
            FloatingActionButton(
              onPressed: () {
                counterbloc.add(CounterEvent.decrement);
              },
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: () {
                counterbloc.add(CounterEvent.increment);
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            )
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

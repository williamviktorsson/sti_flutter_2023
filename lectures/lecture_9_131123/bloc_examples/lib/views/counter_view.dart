import 'package:bloc_examples/blocs/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // every time the bloc emits a new state
    // the build function is re-run

    return Scaffold(
      body: Center(child: Builder(builder: (context) {
        CounterBloc bloc = context.watch<CounterBloc>();
        return Text(
          "${bloc.state}",
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        );
      })),
      floatingActionButton: ButtonBar(children: [
        FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              // send event to bloc
              context.read<CounterBloc>().add(DecrementEvent());
            }),
        FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              // send event to bloc
              context.read<CounterBloc>().add(IncrementEvent());
            }),
        FloatingActionButton(
            child: const Icon(Icons.repeat),
            onPressed: () {
              // send event to bloc
              context.read<CounterBloc>().add(IncrementManyEvent());
            }),
        FloatingActionButton(
            child: const Icon(Icons.stop),
            onPressed: () {
              // send event to bloc
              context.read<CounterBloc>().add(StopIncrementing());
            })
      ]),
    );
  }
}

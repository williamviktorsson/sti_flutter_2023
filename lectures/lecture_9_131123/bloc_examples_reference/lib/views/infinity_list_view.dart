import 'package:bloc_examples/blocs/counter_bloc.dart';
import 'package:bloc_examples/blocs/infinity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfinityListView extends StatelessWidget {
  const InfinityListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infinityBloc = context.watch<InfinityBloc>();

    return Scaffold(
        body: ListView.builder(itemBuilder: (context, index) {
          String? item = infinityBloc.getStringAtIndex(index);
          return item != null
              ? ListTile(
                  title: Text(item),
                )
              : const Center(child: CircularProgressIndicator());
        }),
        floatingActionButton: ButtonBar(
          children: [
            FloatingActionButton(
              onPressed: () {
                infinityBloc.add(InfinityAddOne());
              },
              tooltip: 'Add one',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                infinityBloc.add(InfinityAdd20());
              },
              tooltip: 'Add 20',
              child: const Icon(Icons.twenty_mp),
            ),
            FloatingActionButton(
              onPressed: () {
                infinityBloc.add(InfinityStartAdding());
              },
              tooltip: 'Add forever',
              child: const Icon(Icons.repeat),
            ),
            FloatingActionButton(
              onPressed: () {
                infinityBloc.add(InfinityStopAdding());
              },
              tooltip: 'stop adding',
              child: const Icon(Icons.stop),
            ),
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

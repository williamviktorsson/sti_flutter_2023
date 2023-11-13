import 'package:bloc_examples/blocs/counter_bloc.dart';
import 'package:bloc_examples/blocs/infinity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfinityListView extends StatefulWidget {
  const InfinityListView({Key? key}) : super(key: key);

  @override
  State<InfinityListView> createState() => _InfinityListViewState();
}

class _InfinityListViewState extends State<InfinityListView> {

  late InfinityBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = context.read<InfinityBloc>();
  }

  @override
  void dispose() {

    // get reference to bloc on init (when context exists)
    // send stop adding to THAT bloc 
    // (not the one that exists'nt when context is null

    bloc.add(InfinityStopAdding());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InfinityBloc bloc = context.watch<InfinityBloc>();

    return Scaffold(
        body: ListView.builder(
          itemBuilder: (context, index) {
            String? word = bloc.state.words.elementAtOrNull(index);

            return word != null
                ? ListTile(
                    title: Text(word),
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: ButtonBar(
          children: [
            FloatingActionButton(
              onPressed: () {
                bloc.add(InfinityAddOne());
              },
              tooltip: 'Add one',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                bloc.add(InfinityAdd20());
              },
              tooltip: 'Add 20',
              child: const Icon(Icons.twenty_mp),
            ),
            FloatingActionButton(
              onPressed: () {
                bloc.add(InfinityStartAdding());
              },
              tooltip: 'Add forever',
              child: const Icon(Icons.repeat),
            ),
            FloatingActionButton(
              onPressed: () {
                bloc.add(InfinityStopAdding());
              },
              tooltip: 'stop adding',
              child: const Icon(Icons.stop),
            ),
          ],
        ) // ,
        );
  }
}

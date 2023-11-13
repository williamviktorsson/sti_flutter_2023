// help me create a counter bloc, states, events and bloc.

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class CounterEvent {}

class IncrementEvent extends CounterEvent {
  // definitely use classes when events should carry data
}

class DecrementEvent extends CounterEvent {}

class StopIncrementing extends CounterEvent {}

class IncrementManyEvent extends CounterEvent {}

// bloc takes 2 type parameters
// first is the events that will be sent to the bloc
// second is the state that the bloc emits
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    StreamSubscription? subscription;

    // initial state is 0
    on<CounterEvent>((event, emit) async {
      if (event is IncrementEvent) {
        emit(state + 1);
      } else if (event is DecrementEvent) {
        emit(state - 1);
      } else if (event is IncrementManyEvent) {
        // emit a new state every 50 milliseconds
        Stream periodic = Stream.periodic(const Duration(milliseconds: 50))
            .asBroadcastStream();

        subscription = periodic.listen((event) {
          emit(state + 1);
          // emit should never be called after on event handler has finished running
        });

        await subscription!.asFuture(); // wait for the subscription to finish
      } else if (event is StopIncrementing) {
        subscription?.cancel();
      }
    });
  }
}

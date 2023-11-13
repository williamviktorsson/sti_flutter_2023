// help me create a counter bloc, states, events and bloc.

import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    // initial state is 0

    on<CounterEvent>((event, emit) => switch (event) {
          CounterEvent.increment => emit(state + 1),
          CounterEvent.decrement => emit(state - 1)
        });
  }
}

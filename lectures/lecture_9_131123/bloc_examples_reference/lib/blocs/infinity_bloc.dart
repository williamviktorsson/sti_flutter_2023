// help me create a counter bloc, states, events and bloc.

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_generator/word_generator.dart';

sealed class InfinityEvent {}

class InfinityAddOne extends InfinityEvent {}

class InfinityStartAdding extends InfinityEvent {}

class InfinityStopAdding extends InfinityEvent {}

class InfinityAdd20 extends InfinityEvent {}

class InfinityState {
  Map<int, String?> strings;

  InfinityState({
    required this.strings,
  });

  InfinityState.initial() : this(strings: {});

  InfinityState copyWith({
    Map<int, String?>? strings,
  }) {
    return InfinityState(
      strings: strings ?? this.strings,
    );
  }
}

class InfinityBloc extends Bloc<InfinityEvent, InfinityState> {
  InfinityBloc() : super(InfinityState.initial()) {
    WordGenerator generator = WordGenerator();

    StreamSubscription? subscription;

    on<InfinityAddOne>((event, emit) async {

      // indicate that we have "begun fetching" so that rebuilds of gui dont trigger fetches

      final index = state.strings.length;

      emit(state.copyWith(strings: {...state.strings, index: null}));

      await Future.delayed(const Duration(milliseconds: 500));

      final strings = Map.of(state.strings);

      strings[index] = generator.randomNoun();

      emit(state.copyWith(strings: strings));
    });

    on<InfinityStartAdding>((event, emit) async {
      if (subscription == null) {
        Stream periodicStream =
            Stream.periodic(const Duration(milliseconds: 50));
        subscription = periodicStream.listen((_) {
          add(InfinityAddOne());
        });
        await subscription?.asFuture();
      }
    });

    on<InfinityStopAdding>((event, emit) async {
      await subscription?.cancel();
      subscription = null;
    });
    on<InfinityAdd20>((event, emit) {
      for (int i = 0; i < 20; i++) {
        add(InfinityAddOne());
      }
    });
  }

  String? getStringAtIndex(int index) {
    if (state.strings.containsKey(index)) {
      return state.strings[index];
    } else {
      add(InfinityAddOne());
      return null;
    }
  }
}

// help me create a counter bloc, states, events and bloc.

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_generator/word_generator.dart';

// events for adding one word, 20 words, and starting/stopping
// adding words every 50 milliseconds
sealed class InfinityEvent {}

class InfinityAddOne extends InfinityEvent {}

class InfinityStartAdding extends InfinityEvent {}

class InfinityStopAdding extends InfinityEvent {}

class InfinityAdd20 extends InfinityEvent {}

class InfinityState {
  List<String> words;

  InfinityState({
    required this.words,
  });

  InfinityState.initial() : this(words: []);
}

class InfinityBloc extends Bloc<InfinityEvent, InfinityState> {
  InfinityBloc() : super(InfinityState.initial()) {
    WordGenerator generator = WordGenerator(); // package from pub.dev

    Timer? timer;

    on<InfinityAddOne>((event, emit) async {
      await Future.delayed(Duration(milliseconds: 500));
      emit(InfinityState(words: [...state.words, generator.randomNoun()]));
    });
    on<InfinityStartAdding>((event, emit) async {
      // assign if null
      timer ??= Timer.periodic(const Duration(milliseconds: 100), (timer) {
        add(InfinityAddOne());
      });
    });
    on<InfinityStopAdding>((event, emit) async {
      timer?.cancel();
      timer = null;
    });
    on<InfinityAdd20>((event, emit) {
      for (int i = 0; i < 20; i++) {
        add(InfinityAddOne());
      }
    });
  }

  // todo: add method on bloc to read words from its state by index
  // if that index has already been requested, do not fetch another word (its loading)
  // if it is the first time it has been requested, fetch another word
  // if it has been requested and fetched, return it

}

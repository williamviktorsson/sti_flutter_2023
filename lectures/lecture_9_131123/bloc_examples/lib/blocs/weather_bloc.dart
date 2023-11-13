// help me create a counter bloc, states, events and bloc.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:word_generator/word_generator.dart';

sealed class WeatherEvent {}

class WeatherSearch extends WeatherEvent {
  final String city;

  WeatherSearch(this.city);
}

enum WeatherStatus { initial, loading, loaded, error }

class WeatherState {
  String? body;
  String? searchWord;
  WeatherStatus status;
  WeatherState({
    this.body,
    this.searchWord,
    required this.status,
  });
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState(status: WeatherStatus.initial)) {
    const String api_url = 'https://goweather.herokuapp.com/weather/';

    on<WeatherSearch>((event, emit) async {
      emit(WeatherState(status: WeatherStatus.loading, searchWord: event.city));

      final response = await http.get(Uri.parse(api_url + event.city));

      if (response.statusCode == 200) {
        emit(WeatherState(status: WeatherStatus.loaded, body: response.body));
      } else {
        emit(WeatherState(status: WeatherStatus.error, body: response.body));
      }
    },

        // after 500 ms of inactivity, yields only the last event
        // one of the selling points of bloc
        transformer: (events, mapper) => events
            .debounceTime(const Duration(milliseconds: 2000))
            .switchMap(mapper));
  }
}

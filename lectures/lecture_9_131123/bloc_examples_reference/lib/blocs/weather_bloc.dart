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
  Map<String, dynamic>? json;
  String? error;
  String? citySearched;

  WeatherStatus status;
  WeatherState({
    this.json,
    this.error,
    this.citySearched,
    required this.status,
  });

  WeatherState.initial() : this(json: null, status: WeatherStatus.initial);
  WeatherState.searching(String city)
      : this(citySearched: city, json: null, status: WeatherStatus.loading);
  WeatherState.loaded(String city, Map<String, dynamic> json)
      : this(citySearched: city, json: json, status: WeatherStatus.loaded);
  WeatherState.error(String city, String error)
      : this(citySearched: city, error: error, status: WeatherStatus.error);
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState.initial()) {
    const String api_url = 'https://goweather.herokuapp.com/weather/';

    on<WeatherSearch>((event, emit) async {
      if (event.city == "") {
        emit(WeatherState.initial());
        return;
      }
      emit(WeatherState.searching(event.city));
      final response = await http.get(Uri.parse(api_url + event.city));
      if (response.statusCode == 200) {
        emit(WeatherState.loaded(event.city, json.decode(response.body)));
      } else {
        emit(WeatherState.error(event.city, response.body));
      }
    },
        transformer: (events, mapper) => events
            .debounceTime(const Duration(milliseconds: 500))
            .switchMap(mapper));
  }
}

import 'dart:convert';

import 'package:bloc_examples/blocs/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherAPIView extends StatelessWidget {
  const WeatherAPIView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Expanded(child: SearchResults()),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search',
            ),
            onChanged: (value) {
              context.read<WeatherBloc>().add(WeatherSearch(value));
            },
          ),
        ],
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state.status == WeatherStatus.loading) {
          return Center(
              child: Column(
            children: [
              Text("Searching for ${state.citySearched}"),
              const Divider(),
              const CircularProgressIndicator(),
            ],
          ));
        } else if (state.status == WeatherStatus.loaded) {
          return Center(
            child: Text(const JsonEncoder.withIndent('  ').convert(state.json)),
          );
        } else if (state.status == WeatherStatus.error) {
          return Center(
            child: Text(state.error!),
          );
        } else {
          return const Center(child: Text("Search for a city"));
        }
      },
    );
  }
}

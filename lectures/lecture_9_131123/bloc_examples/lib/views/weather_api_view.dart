import 'dart:convert';

import 'package:bloc_examples/blocs/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherAPIView extends StatelessWidget {
  const WeatherAPIView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
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
        ),
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherBloc bloc = context.watch<WeatherBloc>();

    switch (bloc.state.status) {
      case WeatherStatus.initial:
        return const Center(child: Text('Search for a city'));
      case WeatherStatus.loading:
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(bloc.state.searchWord ?? 'loading'),
            const CircularProgressIndicator(),
          ],
        ));
      case WeatherStatus.loaded:
        return Center(
            child: Text(
          bloc.state.body ?? 'no data',
          style: const TextStyle(color: Colors.green),
        ));
      case WeatherStatus.error:
        return Center(
            child: Text(
          bloc.state.body ?? 'no data',
          style: const TextStyle(color: Colors.red),
        ));
    }
  }
}

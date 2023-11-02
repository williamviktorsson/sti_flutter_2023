import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:game_server/src/helpers.dart';
import 'package:game_server/src/hive_repository.dart';
import 'package:game_shared/game_shared.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => get(context),
    HttpMethod.post => post(context),
    _ => Future.value(
        Response(statusCode: CRUDStatus.NotFound.toHTTPStatusCode),
      )
  };
}

Future<Response> post(RequestContext context) async {
  final repository = await context.read<Future<HiveBoardRepository>>();

  final request = context.request;

  final body = await request.body();
  final game = Board.deserialize(body);

  final result = await repository.create(game);

  if (result.isSuccess) {
    return result.toHTTPSuccess(
      body: game.serialize(),
    );
  } else {
    return result.toHTTPError();
  }
}

Future<Response> get(RequestContext context) async {
  final repository = await context.read<Future<HiveBoardRepository>>();

  final result = await repository.list();

  if (result.isSuccess) {
    final games = result.value!.map((e) => e.serialize()).toList();
    return result.toHTTPSuccess(
      body: jsonEncode(games),
    );
  } else {
    return result.toHTTPError();
  }
}

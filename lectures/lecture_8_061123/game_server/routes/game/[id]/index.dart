import 'package:dart_frog/dart_frog.dart';
import 'package:game_server/src/helpers.dart';
import 'package:game_server/src/hive_repository.dart';
import 'package:game_shared/game_shared.dart';

Future<Response> onRequest(RequestContext context, String gameId) async {
  return switch (context.request.method) {
    HttpMethod.get => get(context, gameId),
    HttpMethod.put => put(context, gameId),
    HttpMethod.delete => delete(context, gameId),
    _ => Future.value(
        Response(statusCode: CRUDStatus.NotFound.toHTTPStatusCode),
      )
  };
}

Future<Response> get(RequestContext context, String gameId) async {
  final repository = await context.read<Future<HiveBoardRepository>>();

  final result = await repository.read(gameId);

  if (result.isSuccess && result.value != null) {
    final game = result.value!;
    return result.toHTTPSuccess(body: game.serialize());
  } else {
    return result.toHTTPError();
  }
}

Future<Response> put(RequestContext context, String gameId) async {
  final repository = await context.read<Future<HiveBoardRepository>>();
  final request = context.request;
  final body = await request.body();
  final game = Board.deserialize(body);

  final result = await repository.update(gameId, game);

  if (result.isSuccess && result.value != null) {
    final game = result.value!;
    return result.toHTTPSuccess(body: game.serialize());
  } else {
    return result.toHTTPError();
  }
}

Future<Response> delete(RequestContext context, String gameId) async {
  final repository = await context.read<Future<HiveBoardRepository>>();

  final result = await repository.delete(gameId);

  if (result.isSuccess) {
    return result.toHTTPSuccess();
  } else {
    return result.toHTTPError();
  }
}

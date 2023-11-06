// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/index.dart' as index;
import '../routes/game/index.dart' as game_index;
import '../routes/game/[id]/index.dart' as game_$id_index;
import '../routes/game/[id]/stream/index.dart' as game_$id_stream_index;

import '../routes/game/_middleware.dart' as game_middleware;

void main() async {
  final address = InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  hotReload(() => createServer(address, port));
}

Future<HttpServer> createServer(InternetAddress address, int port) {
  final handler = Cascade().add(buildRootHandler()).handler;
  return serve(handler, address, port);
}

Handler buildRootHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..mount('/game/<id>/stream', (context,id,) => buildGame$idStreamHandler(id,)(context))
    ..mount('/game/<id>', (context,id,) => buildGame$idHandler(id,)(context))
    ..mount('/game', (context) => buildGameHandler()(context))
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildGame$idStreamHandler(String id,) {
  final pipeline = const Pipeline().addMiddleware(game_middleware.middleware);
  final router = Router()
    ..all('/', (context) => game_$id_stream_index.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildGame$idHandler(String id,) {
  final pipeline = const Pipeline().addMiddleware(game_middleware.middleware);
  final router = Router()
    ..all('/', (context) => game_$id_index.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildGameHandler() {
  final pipeline = const Pipeline().addMiddleware(game_middleware.middleware);
  final router = Router()
    ..all('/', (context) => game_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => index.onRequest(context,));
  return pipeline.addHandler(router);
}


import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:game_server/src/hive_repository.dart';

Future<Response> onRequest(RequestContext context, String gameId) async {

  final repository = await context.read<Future<HiveBoardRepository>>();

  final stream = await repository.changes(gameId);

  final handler = webSocketHandler((channel, protocol) {
    channel.sink.addStream(
      stream.map((event) => event?.serialize()),
    );
  });
  return handler(context);
}

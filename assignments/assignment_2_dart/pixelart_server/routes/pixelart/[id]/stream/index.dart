import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:pixelart_server/src/hive_repository.dart';

Future<Response> onRequest(RequestContext context, String pixelArtId) async {

  final repository = await context.read<Future<HivePixelArtRepository>>();

  final stream = await repository.changes(pixelArtId);

  final handler = webSocketHandler((channel, protocol) {
    channel.sink.addStream(
      stream.map((event) => event?.serialize()),
    );
  });
  return handler(context);
}

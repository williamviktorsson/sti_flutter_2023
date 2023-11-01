import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:paint_server/src/hive_repository.dart';

Future<Response> onRequest(RequestContext context, String paintId) async {

  final repository = await context.read<Future<HivePaintRepository>>();

  final stream = await repository.changes(paintId);

  final handler = webSocketHandler((channel, protocol) {
    channel.sink.addStream(
      stream.map((event) => event?.serialize()),
    );
  });
  return handler(context);
}

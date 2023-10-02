import 'package:dart_frog/dart_frog.dart';
import 'package:pixelart_server/src/helpers.dart';
import 'package:pixelart_server/src/hive_repository.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

Future<Response> onRequest(RequestContext context, String pixelArtId) async {
  return switch (context.request.method) {
    HttpMethod.get => get(context, pixelArtId),
    HttpMethod.put => put(context, pixelArtId),
    HttpMethod.delete => delete(context, pixelArtId),
    _ => Future.value(
        Response(statusCode: CRUDStatus.NotFound.toHTTPStatusCode),
      )
  };
}

Future<Response> get(RequestContext context, String pixelArtId) async {
  final repository = await context.read<Future<HivePixelArtRepository>>();

  // TODO: 9. Read from the repository. Await the request and return a result. Make sure to error handle.
  //          Take inspiration from the put method

  throw UnimplementedError();
}

Future<Response> put(RequestContext context, String pixelArtId) async {
  final repository = await context.read<Future<HivePixelArtRepository>>();
  final request = context.request;
  final body = await request.body();
  final pixelArt = PixelArt.deserialize(body);

  final result = await repository.update(pixelArtId, pixelArt);

  if (result.isSuccess && result.value != null) {
    final pixelart = result.value!;
    return result.toHTTPSuccess(body: pixelart.serialize());
  } else {
    return result.toHTTPError();
  }
}

Future<Response> delete(RequestContext context, String pixelArtId) async {
  final repository = await context.read<Future<HivePixelArtRepository>>();

  final result = await repository.delete(pixelArtId);

  if (result.isSuccess) {
    return result.toHTTPSuccess();
  } else {
    return result.toHTTPError();
  }
}

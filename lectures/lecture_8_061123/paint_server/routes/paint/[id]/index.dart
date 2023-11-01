import 'package:dart_frog/dart_frog.dart';
import 'package:paint_server/src/helpers.dart';
import 'package:paint_server/src/hive_repository.dart';
import 'package:paint_shared/paint_shared.dart';

Future<Response> onRequest(RequestContext context, String paintId) async {
  return switch (context.request.method) {
    HttpMethod.get => get(context, paintId),
    HttpMethod.put => put(context, paintId),
    HttpMethod.delete => delete(context, paintId),
    _ => Future.value(
        Response(statusCode: CRUDStatus.NotFound.toHTTPStatusCode),
      )
  };
}

Future<Response> get(RequestContext context, String paintId) async {
  final repository = await context.read<Future<HivePaintRepository>>();

  final result = await repository.read(paintId);

  if (result.isSuccess && result.value != null) {
    final paint = result.value!;
    return result.toHTTPSuccess(body: paint.serialize());
  } else {
    return result.toHTTPError();
  }
}

Future<Response> put(RequestContext context, String paintId) async {
  final repository = await context.read<Future<HivePaintRepository>>();
  final request = context.request;
  final body = await request.body();
  final paint = Paint.deserialize(body);

  final result = await repository.update(paintId, paint);

  if (result.isSuccess && result.value != null) {
    final paint = result.value!;
    return result.toHTTPSuccess(body: paint.serialize());
  } else {
    return result.toHTTPError();
  }
}

Future<Response> delete(RequestContext context, String paintId) async {
  final repository = await context.read<Future<HivePaintRepository>>();

  final result = await repository.delete(paintId);

  if (result.isSuccess) {
    return result.toHTTPSuccess();
  } else {
    return result.toHTTPError();
  }
}

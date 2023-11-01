import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:paint_server/src/helpers.dart';
import 'package:paint_server/src/hive_repository.dart';
import 'package:paint_shared/paint_shared.dart';

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
  final repository = await context.read<Future<HivePaintRepository>>();

  final request = context.request;

  final body = await request.body();
  final paint = Paint.deserialize(body);

  final result = await repository.create(paint);

  if (result.isSuccess) {
    return result.toHTTPSuccess(
      body: paint.serialize(),
    );
  } else {
    return result.toHTTPError();
  }
}

Future<Response> get(RequestContext context) async {
  final repository = await context.read<Future<HivePaintRepository>>();

  final result = await repository.list();

  if (result.isSuccess) {
    final paints = result.value!.map((e) => e.serialize()).toList();
    return result.toHTTPSuccess(
      body: jsonEncode(paints),
    );
  } else {
    return result.toHTTPError();
  }
}

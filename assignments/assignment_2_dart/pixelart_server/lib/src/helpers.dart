// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

extension HTTPResponseFromCRUD<T> on CRUDResult<T> {
  Response toHTTPSuccess({String? body}) =>
      Response(statusCode: status.toHTTPStatusCode, body: body);
  Response toHTTPError() =>
      Response(statusCode: status.toHTTPStatusCode, body: jsonEncode(error));
}

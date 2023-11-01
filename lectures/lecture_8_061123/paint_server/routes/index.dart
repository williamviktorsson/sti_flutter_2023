import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
      body:
          'This is an API for crating and editing paint art :-).\nGo to /paint to list / post new paint art.\nGo to /paint/[id] to update/collaborate/delete paint');
}

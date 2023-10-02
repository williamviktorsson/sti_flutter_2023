import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
      body:
          'This is an API for crating and editing pixel art :-).\nGo to /pixelart to list / post new pixel art.\nGo to /pixelart/[id] to update/collaborate/delete pixelart');
}

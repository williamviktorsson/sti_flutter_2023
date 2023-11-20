import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
      body:
          'This is an API for crating and editing game art :-).\nGo to /game to list / post new game art.\nGo to /game/[id] to update/collaborate/delete game');
}

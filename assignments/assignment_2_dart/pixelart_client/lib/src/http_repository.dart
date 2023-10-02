// immutable data, from/toJson, copyWith functions for easily yielding new copies
import 'dart:convert';

import 'package:pixelart_client/src/helpers.dart';
import 'package:pixelart_shared/pixelart_shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:http/http.dart' as http;

class HTTPPixelArtRepository extends AbstractPixelArtRepository {
  final String url;
  final String _HTTPurl;
  final String _WSurl;

  const HTTPPixelArtRepository({required this.url})
      : _HTTPurl = "http://" + url,
        _WSurl = "ws://" + url;

  @override
  Future<CRUDResult<PixelArt>> create(PixelArt item) async {
    try {
      // TODO: 16. Post item as serialized string to http url and await response

      throw UnimplementedError();

      var response;

      if (response.isSuccess) {
        return CRUDResult.success(PixelArt.deserialize(response.body));
      } else {
        return CRUDResult.failure(response.statusCode.toCRUDStatus);
      }
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.NetworkError, e);
    }
  }

  @override
  Future<CRUDResult<PixelArt>> read(String id) async {
    try {
      final response = await http.get(Uri.parse('$_HTTPurl/$id'));

      // TODO: 17. check if response was successful and return success/failure result by deserializing the body or providing the failed crudstatus

      throw UnimplementedError();
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.NetworkError, e);
    }
  }

  @override
  Future<CRUDResult<PixelArt>> update(String id, PixelArt item) async {
    // TODO: 18. use HTTP PUT with item serialized as body to HTTPURL/[id]. Make sure to error handle and return proper crudresults.
    throw UnimplementedError();
  }

  @override
  Future<CRUDResult<void>> delete(String id) async {
    // TODO: 19. use HTTP DELETE to HTTPURL/[id]. Make sure to error handle and return proper crudresults.
    throw UnimplementedError();
  }

  @override
  Future<CRUDResult<List<PixelArt>>> list() async {
    try {
      final response = await http.get(Uri.parse(_HTTPurl));
      if (response.isSuccess) {
        List<dynamic> body = jsonDecode(response.body);
        List<PixelArt> items =
            body.map((e) => PixelArt.deserialize(e as String)).toList();
        return CRUDResult.success(items);
      } else {
        return CRUDResult.failure(response.statusCode.toCRUDStatus);
      }
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.NetworkError, e);
    }
  }

  @override
  Future<Stream<PixelArt?>> changes(String id) async {
    final uri = Uri.parse('$_WSurl/$id/stream');
    final channel = WebSocketChannel.connect(uri);
    return channel.stream.map((event) {
      if (event.runtimeType == String) {
        event = event as String;
        return event.isNotEmpty ? PixelArt.deserialize(event) : null;
      } else {
        return null;
      }
    });
  }
}

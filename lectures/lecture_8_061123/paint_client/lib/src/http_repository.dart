// immutable data, from/toJson, copyWith functions for easily yielding new copies
import 'dart:convert';

import 'package:paint_client/src/helpers.dart';
import 'package:paint_shared/paint_shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:http/http.dart' as http;

class HTTPPaintRepository extends AbstractPaintRepository {
  final String url;
  final String _HTTPurl;
  final String _WSurl;

  const HTTPPaintRepository({required this.url})
      : _HTTPurl = "http://" + url,
        _WSurl = "ws://" + url;

  @override
  Future<CRUDResult<Paint>> create(Paint item) async {
    try {
      final response = await http.post(
        Uri.parse(_HTTPurl),
        body: item.serialize(),
      );

      if (response.isSuccess) {
        return CRUDResult.success(Paint.deserialize(response.body));
      } else {
        return CRUDResult.failure(response.statusCode.toCRUDStatus);
      }
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.NetworkError, e);
    }
  }

  @override
  Future<CRUDResult<Paint>> read(String id) async {
    try {
      final response = await http.get(Uri.parse('$_HTTPurl/$id'));
      if (response.isSuccess) {
        return CRUDResult.success(Paint.deserialize(response.body));
      } else {
        return CRUDResult.failure(response.statusCode.toCRUDStatus);
      }
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.NetworkError, e);
    }
  }

  @override
  Future<CRUDResult<Paint>> update(String id, Paint item) async {
    try {
      final response = await http.put(
        Uri.parse('$_HTTPurl/$id'),
        body: item.serialize(),
      );

      if (response.isSuccess) {
        return CRUDResult.success(Paint.deserialize(response.body));
      } else {
        return CRUDResult.failure(response.statusCode.toCRUDStatus);
      }
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.NetworkError, e);
    }
  }

  @override
  Future<CRUDResult<void>> delete(String id) async {
    try {
      final response = await http.delete(Uri.parse('$_HTTPurl/$id'));

      if (response.isSuccess) {
        return CRUDResult.success();
      } else {
        return CRUDResult.failure(response.statusCode.toCRUDStatus);
      }
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.NetworkError, e);
    }
  }

  @override
  Future<CRUDResult<List<Paint>>> list() async {
    try {
      final response = await http.get(Uri.parse(_HTTPurl));
      if (response.isSuccess) {
        List<dynamic> body = jsonDecode(response.body);
        List<Paint> items =
            body.map((e) => Paint.deserialize(e as String)).toList();
        return CRUDResult.success(items);
      } else {
        return CRUDResult.failure(response.statusCode.toCRUDStatus);
      }
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.NetworkError, e);
    }
  }

  @override
  Future<Stream<Paint?>> changes(String id) async {
    final uri = Uri.parse('$_WSurl/$id/stream');
    final channel = WebSocketChannel.connect(uri);
    return channel.stream.map((event) {
      if (event.runtimeType == String) {
        event = event as String;
        return event.isNotEmpty ? Paint.deserialize(event) : null;
      } else {
        throw TypeError();
      }
    });
  }
}

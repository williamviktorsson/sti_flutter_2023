// ignore_for_file: public_member_api_docs

import 'dart:io';
import 'package:hive/hive.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

class HivePixelArtRepository extends AbstractPixelArtRepository {
  late String collectionName;
  late Box<String> box;

  // Initialize method to set up Hive and open the box
  Future<void> initialize({required String collectionName}) async {
    final directory = Directory.current;
    Hive.init(directory.path);
    box = await Hive.openBox<String>(collectionName);
  }

  @override
  Future<CRUDResult<PixelArt>> create(PixelArt item) async {
    try {
      // TODO: 7. save serialized item to box if it does not already exist
      throw UnimplementedError();
      return CRUDResult.success(item);
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.DatabaseError, e);
    }
  }

  @override
  Future<CRUDResult<void>> delete(String id) async {
    try {
      if (!box.containsKey(id)) {
        return CRUDResult.failure(CRUDStatus.NotFound);
      }
      await box.delete(id);
      return CRUDResult.success();
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.DatabaseError, e);
    }
  }

  @override
  Future<CRUDResult<PixelArt>> read(String id) async {
      // TODO: 8. attempt to read item from box by id. Remember to deserialize and error handle.
      throw UnimplementedError();

  }

  @override
  Future<CRUDResult<PixelArt>> update(String id, PixelArt item) async {
    try {
      if (!box.containsKey(id)) {
        return CRUDResult.failure(CRUDStatus.NotFound);
      }
      await box.put(id, item.serialize());
      return CRUDResult.success(item);
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.DatabaseError, e);
    }
  }

  @override
  Future<CRUDResult<List<PixelArt>>> list() async {
    try {
      final items = box.values.map(PixelArt.deserialize).toList();
      return CRUDResult.success(items);
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.DatabaseError, e);
    }
  }

  @override
  Future<Stream<PixelArt?>> changes(String itemId) async {
    return Future.value(box.watch(key: itemId).map(
      (event) {
        return (event.value != null && event.value is String)
            ? PixelArt.deserialize(event.value as String)
            : null;
      },
    ));
  }

  Future<CRUDResult<void>> clear() async {
    try {
      await box.clear();
      await box.close();
      return CRUDResult.success();
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.DatabaseError, e);
    }
  }

  Future<CRUDResult<void>> destroy() async {
    try {
      await box.clear();
      await Hive.deleteBoxFromDisk(collectionName);
      return CRUDResult.success();
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.DatabaseError, e);
    }
  }
}

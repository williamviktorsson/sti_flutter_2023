// ignore_for_file: public_member_api_docs

import 'dart:io';
import 'package:hive/hive.dart';
import 'package:paint_shared/paint_shared.dart';

class HivePaintRepository extends AbstractPaintRepository {
  late String collectionName;
  late Box<String> box;

  // Initialize method to set up Hive and open the box
  Future<void> initialize({required String collectionName}) async {
    final directory = Directory.current;
    Hive.init(directory.path);
    box = await Hive.openBox<String>(collectionName);
  }

  @override
  Future<CRUDResult<Paint>> create(Paint item) async {
    try {
      if (box.containsKey(item.id)) {
        return CRUDResult.failure(CRUDStatus.ValidationFailed);
      }
      await box.put(item.id, item.serialize());
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
  Future<CRUDResult<Paint>> read(String id) async {
    try {
      final item = box.get(id);
      if (item == null) {
        return CRUDResult.failure(CRUDStatus.NotFound);
      }
      return CRUDResult.success(Paint.deserialize(item));
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.DatabaseError, e);
    }
  }

  @override
  Future<CRUDResult<Paint>> update(String id, Paint item) async {
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
  Future<CRUDResult<List<Paint>>> list() async {
    try {
      final items = box.values.map(Paint.deserialize).toList();
      return CRUDResult.success(items);
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.DatabaseError, e);
    }
  }

  @override
  Future<Stream<Paint?>> changes(String itemId) async {
    return Future.value(box.watch(key: itemId).map(
      (event) {
        return (event.value != null && event.value is String)
            ? Paint.deserialize(event.value as String)
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

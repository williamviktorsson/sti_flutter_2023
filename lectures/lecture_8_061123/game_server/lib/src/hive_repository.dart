// ignore_for_file: public_member_api_docs

import 'dart:io';
import 'package:hive/hive.dart';
import 'package:game_shared/game_shared.dart';

class HiveBoardRepository extends AbstractBoardRepository {
  late String collectionName;
  late Box<String> box;

  // Initialize method to set up Hive and open the box
  Future<void> initialize({required String collectionName}) async {
    final directory = Directory.current;
    Hive.init(directory.path);
    box = await Hive.openBox<String>(collectionName);
  }

  @override
  Future<CRUDResult<Board>> create(Board item) async {
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
  Future<CRUDResult<Board>> read(String id) async {
    try {
      final item = box.get(id);
      if (item == null) {
        return CRUDResult.failure(CRUDStatus.NotFound);
      }
      return CRUDResult.success(Board.deserialize(item));
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.DatabaseError, e);
    }
  }

  @override
  Future<CRUDResult<Board>> update(String id, Board item) async {
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
  Future<CRUDResult<List<Board>>> list() async {
    try {
      final items = box.values.map(Board.deserialize).toList();
      return CRUDResult.success(items);
    } catch (e) {
      return CRUDResult.failure(CRUDStatus.DatabaseError, e);
    }
  }

  @override
  Future<Stream<Board?>> changes(String itemId) async {
    return Future.value(box.watch(key: itemId).map(
      (event) {
        return (event.value != null && event.value is String)
            ? Board.deserialize(event.value as String)
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

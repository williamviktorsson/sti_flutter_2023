import 'dart:io';

import 'package:paint_client/paint_client.dart';
import 'package:paint_shared/paint_shared.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  Uuid uuid = Uuid();

  Paint art = Paint(
      id: uuid.v4(),
      name: uuid.v4(),
      description: uuid.v4(),
      width: 64,
      height: 64,
      editors: [],
      paintMatrix: [[]]);

  group('Paint CRUD Tests', () {
    final repository = HTTPPaintRepository(url: "localhost:8080/paint");

    setUpAll(() async {
      var connected = false;
      for (int i = 0; i < 10; i++) {
        var response = await repository.list();
        if (response.isFailure && response.status == CRUDStatus.NetworkError) {
          print(
              "NetworkError connecting to server. Is the server up and running? Start with 'dart_frog dev'");
          await Future.delayed(Duration(seconds: 2));
        } else {
          connected = true;
          break;
        }
      }

      if (!connected) {
        print(
            "Unable to connect to server. Is the server up and running? Start with 'dart_frog dev'");
        print("Exiting. Try again.");
        exit(255);
      }
    });

    test('Create Paint successfully', () async {
      final result = await repository.create(art);
      expect(result.status, equals(CRUDStatus.Success));
    });

    test('Read Paint successfully', () async {
      final result = await repository.read(art.id);
      expect(result.status, equals(CRUDStatus.Success));
    });

    test('Fail to read Paint due to not found', () async {
      final id = "nonexistentId";
      final result = await repository.read(id);
      expect(result.status, equals(CRUDStatus.NotFound));
    });

    test('List Paints shouldContainArt', () async {
      final result = await repository.list();
      expect(result.value, isNotNull);
      if (result.value != null) {
        expect(result.value!.map((e) => e.name).toList(), contains(art.name));
      }
    });

    test('Update Paint successfully', () async {
      art = art.copyWith(name: uuid.v4());
      final result = await repository.update(art.id, art);
      expect(result.status, equals(CRUDStatus.Success));
      expect(result.value, isNotNull);
      if (result.value != null) {
        expect(result.value!.name, equals(art.name));
      }
    });

    test('Fail to update Paint due to not found', () async {
      final id = "nonexistentId";
      final result = await repository.update(id, art);
      expect(result.status, equals(CRUDStatus.NotFound));
    });

    test('Delete Paint successfully', () async {
      final result = await repository.delete(art.id);
      expect(result.status, equals(CRUDStatus.Success));
    });

    test('Fail to delete Paint due to not found', () async {
      final id = "nonexistentId";
      final result = await repository.delete(id);
      expect(result.status, equals(CRUDStatus.NotFound));
    });

    test('List Paints shouldNotContainArt', () async {
      final result = await repository.list();
      expect(result.value, isNotNull);
      if (result.value != null) {
        expect(result.value!.map((e) => e.name).toList(),
            isNot(contains("testUpdateNewName")));
      }
    });

    test('Paint Changes stream successfully', () async {
      // this is

      Paint art = Paint(
          id: uuid.v4(),
          name: uuid.v4(),
          description: uuid.v4(),
          width: 64,
          height: 64,
          editors: [],
          paintMatrix: [[]]);

      final stream = await repository.changes(art.id);

      final changedArt = art.copyWith(name: 'streamTestUpdateNewName');
      final changedArt1 = art.copyWith(name: 'streamTestUpdateNewName1');
      final changedArt2 = art.copyWith(name: 'streamTestUpdateNewName2');

      expect(stream,
          emitsInOrder([art, changedArt, changedArt1, changedArt2, null]));

      await repository.create(art);

      await repository.update(art.id, changedArt);

      await repository.update(art.id, changedArt1);

      await repository.update(art.id, changedArt2);

      await repository.delete(art.id);
    });
  });
}

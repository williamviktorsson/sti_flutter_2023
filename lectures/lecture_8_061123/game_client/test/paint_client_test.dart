import 'dart:io';

import 'package:game_client/game_client.dart';
import 'package:game_shared/game_shared.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  Uuid uuid = Uuid();

  Board art = Board(
      id: uuid.v4(),
      name: uuid.v4(),
      description: uuid.v4(),
      width: 64,
      height: 64,
      players: [],
      player_positions: {});

  group('Board CRUD Tests', () {
    final repository = HTTPBoardRepository(url: "localhost:8080/game");

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

    test('Create Board successfully', () async {
      final result = await repository.create(art);
      expect(result.status, equals(CRUDStatus.Success));
    });

    test('Read Board successfully', () async {
      final result = await repository.read(art.id);
      expect(result.status, equals(CRUDStatus.Success));
    });

    test('Fail to read Board due to not found', () async {
      final id = "nonexistentId";
      final result = await repository.read(id);
      expect(result.status, equals(CRUDStatus.NotFound));
    });

    test('List Boards shouldContainArt', () async {
      final result = await repository.list();
      expect(result.value, isNotNull);
      if (result.value != null) {
        expect(result.value!.map((e) => e.name).toList(), contains(art.name));
      }
    });

    test('Update Board successfully', () async {
      art = art.copyWith(name: uuid.v4());
      final result = await repository.update(art.id, art);
      expect(result.status, equals(CRUDStatus.Success));
      expect(result.value, isNotNull);
      if (result.value != null) {
        expect(result.value!.name, equals(art.name));
      }
    });

    test('Fail to update Board due to not found', () async {
      final id = "nonexistentId";
      final result = await repository.update(id, art);
      expect(result.status, equals(CRUDStatus.NotFound));
    });

    test('Delete Board successfully', () async {
      final result = await repository.delete(art.id);
      expect(result.status, equals(CRUDStatus.Success));
    });

    test('Fail to delete Board due to not found', () async {
      final id = "nonexistentId";
      final result = await repository.delete(id);
      expect(result.status, equals(CRUDStatus.NotFound));
    });

    test('List Boards shouldNotContainArt', () async {
      final result = await repository.list();
      expect(result.value, isNotNull);
      if (result.value != null) {
        expect(result.value!.map((e) => e.name).toList(),
            isNot(contains("testUpdateNewName")));
      }
    });

    test('Board Changes stream successfully', () async {
      // this is

      Board art = Board(
          id: uuid.v4(),
          name: uuid.v4(),
          description: uuid.v4(),
          width: 64,
          height: 64,
          players: [],
          player_positions: {});

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

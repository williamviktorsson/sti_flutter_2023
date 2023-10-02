import 'dart:io';

import 'package:pixelart_client/pixelart_client.dart';
import 'package:pixelart_shared/pixelart_shared.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  Uuid uuid = Uuid();

  PixelArt art = PixelArt(
      id: uuid.v4(),
      name: uuid.v4(),
      description: uuid.v4(),
      width: 64,
      height: 64,
      editors: [],
      pixelMatrix: [[]]);

  group('PixelArt CRUD Tests', () {
    final repository = HTTPPixelArtRepository(url: "localhost:8080/pixelart");

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

    test('Create PixelArt successfully', () async {
      final result = await repository.create(art);
      expect(result.status, equals(CRUDStatus.Success));
    });

    // TODO: 12. Create read success test

    test('Fail to read PixelArt due to not found', () async {
      final id = "nonexistentId";
      final result = await repository.read(id);
      expect(result.status, equals(CRUDStatus.NotFound));
    });

    test('List PixelArts shouldContainArt', () async {
      final result = await repository.list();
      expect(result.value, isNotNull);
      if (result.value != null) {
        expect(result.value!.map((e) => e.name).toList(), contains(art.name));
      }
    });

    test('Update PixelArt successfully', () async {
      art = art.copyWith(name: uuid.v4());
      final result = await repository.update(art.id, art);
      expect(result.status, equals(CRUDStatus.Success));
      expect(result.value, isNotNull);
      if (result.value != null) {
        expect(result.value!.name, equals(art.name));
      }
    });

    test('Fail to update PixelArt due to not found', () async {
      final id = "nonexistentId";
      final result = await repository.update(id, art);
      expect(result.status, equals(CRUDStatus.NotFound));
    });

    // TODO: 13. Create delete success test.

    // TODO: 14. Create delete fail test (on non existent id)

    test('List PixelArts shouldNotContainArt', () async {
      final result = await repository.list();
      expect(result.value, isNotNull);
      if (result.value != null) {
        expect(result.value!.map((e) => e.name).toList(),
            isNot(contains("testUpdateNewName")));
      }
    });

    test('PixelArt Changes stream successfully', () async {

          // TODO: 15. Uncomment this test when the other tests succeeed.


/*       PixelArt art = PixelArt(
          id: uuid.v4(),
          name: uuid.v4(),
          description: uuid.v4(),
          width: 64,
          height: 64,
          editors: [],
          pixelMatrix: [[]]);

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

      await repository.delete(art.id); */

      fail("unimplemented test");

    });
  });
}

// ignore_for_file: library_prefixes

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixelart_server/pixelart_server.dart';
import 'package:pixelart_shared/pixelart_shared.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import '../../routes/index.dart' as route;
import '../../routes/pixelart/[id]/index.dart' as pixelArtSlugRoute;
import '../../routes/pixelart/[id]/stream/index.dart'
    as pixelArtSlugStreamRoute;
import '../../routes/pixelart/index.dart' as pixelArtRoute;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('HivePixelArtRepository', () {
    final repository = HivePixelArtRepository();
    const testPixelArt = PixelArt(
      id: 'testId',
      name: 'Test Art',
      description: 'This is a test pixel art',
      width: 10,
      height: 10,
      editors: [],
      pixelMatrix: [],
    );

    setUpAll(() async {
      await repository.initialize(collectionName: 'testCollection');
    });

    tearDownAll(() async {
      await repository.destroy();
    });

    test('create and read a PixelArt', () async {
      // TODO: 1. use the repository and the testpixelart to attempt to create a pixelart, then attempt to read it. Verify responses uing expect
      fail("unimplemented test");
    });

    test('update a PixelArt', () async {
      await repository.create(testPixelArt);

      final updatedPixelArt = testPixelArt.copyWith(name: 'Updated Name');
      final updateResult =
          await repository.update(testPixelArt.id, updatedPixelArt);
      expect(updateResult.isSuccess, true);
      expect(updateResult.value?.name, 'Updated Name');
    });

    test('delete a PixelArt', () async {
      await repository.create(testPixelArt);

      final deleteResult = await repository.delete(testPixelArt.id);
      expect(deleteResult.isSuccess, true);

      final readResult = await repository.read(testPixelArt.id);
      expect(readResult.status, CRUDStatus.NotFound);
    });

    test('list all PixelArts', () async {
      await repository.create(testPixelArt);

      // TODO: 2. use the repository to list the pixelarts. expect the list of pixelarts to be longer than 0
      fail("unimplemented test");
    });

    test('watch changes on a PixelArt', () async {
      // TODO: 11. Uncomment this test when all other tests succeed.

      /*    

      await repository.delete(testPixelArt.id);

      final stream = await repository.changes(testPixelArt.id);

      final changedArt = testPixelArt.copyWith(name: 'streamTestUpdateNewName');
      final changedArt1 =
          testPixelArt.copyWith(name: 'streamTestUpdateNewName1');
      final changedArt2 =
          testPixelArt.copyWith(name: 'streamTestUpdateNewName2');

      expect(
          stream,
          emitsInOrder(
              [testPixelArt, changedArt, changedArt1, changedArt2, null]));

      await repository.create(testPixelArt);

      await repository.update(testPixelArt.id, changedArt);

      await repository.update(testPixelArt.id, changedArt1);

      await repository.update(testPixelArt.id, changedArt2);

      await repository.delete(testPixelArt.id); */

      fail("unimplemented test");
    });
  });

  group('PixelArt API', () {
    final context = _MockRequestContext();
    const uuid = Uuid();

    var art = PixelArt(
      id: uuid.v4(),
      name: uuid.v4(),
      description: uuid.v4(),
      width: 64,
      height: 64,
      editors: [],
      pixelMatrix: [[]],
    );

    Future<HivePixelArtRepository> initRepo() async {
      final repository = HivePixelArtRepository();
      await repository.initialize(collectionName: 'pixelart_api_test');
      return repository;
    }

    late Future<HivePixelArtRepository> repoFuture;

    setUpAll(() {
      repoFuture = initRepo();
    });

    tearDownAll(() async {
      final repo = await repoFuture;
      await repo.destroy();
    });

    setUp(() {
      // Reset the mock before each test
      reset(context);
      when(() => context.read<Future<HivePixelArtRepository>>())
          .thenAnswer((_) => repoFuture);
    });

    test('GET / - responds with a welcome message', () async {
      final response = route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.body(),
        completion(
            contains('This is an API for crating and editing pixel art :-)')),
      );
    });

    test('POST / - creates a PixelArt', () async {
      when(() => context.request)
          .thenAnswer((e) => Request.post(Uri.base, body: art.serialize()));

      final response = await pixelArtRoute.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      // TODO 3. Check response body for serialized PixelArt.
    });

    test('GET /:id - reads a PixelArt', () async {
      when(() => context.request)
          .thenAnswer((e) => Request.get(Uri.base, body: art.id));

      final response = await pixelArtSlugRoute.onRequest(context, art.id);
      expect(response.statusCode, equals(HttpStatus.ok));
      // TODO 4. Check response body for serialized PixelArt.
    });

    test('PUT /:id - updates a PixelArt', () async {
      art = art.copyWith(name: uuid.v4());
      when(() => context.request)
          .thenAnswer((e) => Request.put(Uri.base, body: art.serialize()));

      final response = await pixelArtSlugRoute.onRequest(context, art.id);
      expect(response.statusCode, equals(HttpStatus.ok));
      // TODO 5. Check response body for serialized PixelArt.
    });

    test('DELETE /:id - deletes a PixelArt', () async {
      when(() => context.request)
          .thenAnswer((e) => Request.delete(Uri.base, body: art.id));
      final response = await pixelArtSlugRoute.onRequest(context, art.id);
      expect(response.statusCode, equals(HttpStatus.ok));
    });

    test('DELETE /:id - fails to delete non existing', () async {
      when(() => context.request).thenAnswer((e) => Request.delete(Uri.base));
      final response =
          await pixelArtSlugRoute.onRequest(context, "nonExistingId");
      expect(response.statusCode, equals(HttpStatus.notFound));
    });

    test('GET / - lists all PixelArts', () async {
      when(() => context.request).thenAnswer((e) => Request.get(
            Uri.base,
          ));

      final response = await pixelArtRoute.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      // TODO 6. Check response body for list of PixelArt.
    });

    test('GET / - stream returns 404 for invalid ws request', () async {
      when(() => context.request).thenAnswer((e) => Request.get(Uri.base));

      final response = await pixelArtSlugStreamRoute.onRequest(context, art.id);
      expect(response.statusCode, equals(HttpStatus.notFound));
    });
  });
}

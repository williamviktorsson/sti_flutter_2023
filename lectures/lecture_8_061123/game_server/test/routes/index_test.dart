import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:game_server/game_server.dart';
import 'package:game_shared/game_shared.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import '../../routes/index.dart' as route;
import '../../routes/game/index.dart' as gameRoute;
import '../../routes/game/[id]/index.dart' as gameSlugRoute;
import '../../routes/game/[id]/stream/index.dart'
    as gameSlugStreamRoute;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('HiveBoardRepository', () {
    final repository = HiveBoardRepository();
    const testBoard = Board(
      id: 'testId',
      name: 'Test Art',
      description: 'This is a test game art',
      width: 10,
      height: 10,
      players: [],
      player_positions: {},
    );

    setUpAll(() async {
      await repository.initialize(collectionName: 'testCollection');
    });

    tearDownAll(() async {
      await repository.destroy();
    });

    test('create and read a Board', () async {
      final createResult = await repository.create(testBoard);
      expect(createResult.isSuccess, true);

      final readResult = await repository.read(testBoard.id);
      expect(readResult.isSuccess, true);
      expect(readResult.value?.id, testBoard.id);
    });

    test('update a Board', () async {
      await repository.create(testBoard);

      final updatedBoard = testBoard.copyWith(name: 'Updated Name');
      final updateResult =
          await repository.update(testBoard.id, updatedBoard);
      expect(updateResult.isSuccess, true);
      expect(updateResult.value?.name, 'Updated Name');
    });

    test('delete a Board', () async {
      await repository.create(testBoard);

      final deleteResult = await repository.delete(testBoard.id);
      expect(deleteResult.isSuccess, true);

      final readResult = await repository.read(testBoard.id);
      expect(readResult.status, CRUDStatus.NotFound);
    });

    test('list all Boards', () async {
      await repository.create(testBoard);

      final listResult = await repository.list();

      expect(listResult.isSuccess, true);
      expect(listResult.value?.length, 1);
      await repository.delete(testBoard.id);
    });

    test('watch changes on a Board', () async {
      final stream = await repository.changes(testBoard.id);

      final changedArt = testBoard.copyWith(name: 'streamTestUpdateNewName');
      final changedArt1 =
          testBoard.copyWith(name: 'streamTestUpdateNewName1');
      final changedArt2 =
          testBoard.copyWith(name: 'streamTestUpdateNewName2');

      expect(
          stream,
          emitsInOrder(
              [testBoard, changedArt, changedArt1, changedArt2, null]));

      await repository.create(testBoard);

      await repository.update(testBoard.id, changedArt);

      await repository.update(testBoard.id, changedArt1);

      await repository.update(testBoard.id, changedArt2);

      await repository.delete(testBoard.id);
    });
  });

  group('Board API', () {
    final context = _MockRequestContext();
    const uuid = Uuid();

    var art = Board(
      id: uuid.v4(),
      name: uuid.v4(),
      description: uuid.v4(),
      width: 64,
      height: 64,
      players: [],
      player_positions: {},
    );

    Future<HiveBoardRepository> initRepo() async {
      final repository = HiveBoardRepository();
      await repository.initialize(collectionName: 'game_api_test');
      return repository;
    }

    late Future<HiveBoardRepository> repoFuture;

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
      when(() => context.read<Future<HiveBoardRepository>>())
          .thenAnswer((_) => repoFuture);
    });

    test('GET / - responds with a welcome message', () async {
      final response = route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.body(),
        completion(
            contains('This is an API for crating and editing game art :-)')),
      );
    });

    test('POST / - creates a Board', () async {
      when(() => context.request)
          .thenAnswer((e) => Request.post(Uri.base, body: art.serialize()));

      // Add more mock setups for request body, headers, etc. if needed

      final response = await gameRoute.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      // Add more assertions for response body, headers, etc.
    });

    test('GET /:id - reads a Board', () async {
      when(() => context.request)
          .thenAnswer((e) => Request.get(Uri.base, body: art.id));
      // Mock the ID parameter from the URL

      final response = await gameSlugRoute.onRequest(context, art.id);
      expect(response.statusCode, equals(HttpStatus.ok));
      // Add more assertions for response body, headers, etc.
    });

    test('PUT /:id - updates a Board', () async {
      art = art.copyWith(name: uuid.v4());
      when(() => context.request)
          .thenAnswer((e) => Request.put(Uri.base, body: art.serialize()));

      // Mock the ID parameter from the URL and request body if needed

      final response = await gameSlugRoute.onRequest(context, art.id);
      expect(response.statusCode, equals(HttpStatus.ok));
      // Add more assertions for response body, headers, etc.
    });

    test('DELETE /:id - deletes a Board', () async {
      when(() => context.request)
          .thenAnswer((e) => Request.delete(Uri.base, body: art.id));
      final response = await gameSlugRoute.onRequest(context, art.id);
      expect(response.statusCode, equals(HttpStatus.ok));
    });

    test('GET / - lists all Boards', () async {
      when(() => context.request).thenAnswer((e) => Request.get(
            Uri.base,
          ));

      final response = await gameRoute.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      // Add more assertions for response body, headers, etc.
    });

    test('GET / - stream returns 404 for invalid ws request', () async {
      when(() => context.request).thenAnswer((e) => Request.get(Uri.base));

      final response = await gameSlugStreamRoute.onRequest(context, art.id);
      expect(response.statusCode, equals(HttpStatus.notFound));
      // Add more assertions for response body, headers, etc.
    });
  });
}

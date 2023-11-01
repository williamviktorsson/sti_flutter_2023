import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:paint_server/paint_server.dart';
import 'package:paint_shared/paint_shared.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import '../../routes/index.dart' as route;
import '../../routes/paint/index.dart' as paintRoute;
import '../../routes/paint/[id]/index.dart' as paintSlugRoute;
import '../../routes/paint/[id]/stream/index.dart'
    as paintSlugStreamRoute;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('HivePaintRepository', () {
    final repository = HivePaintRepository();
    const testPaint = Paint(
      id: 'testId',
      name: 'Test Art',
      description: 'This is a test paint art',
      width: 10,
      height: 10,
      editors: [],
      paintMatrix: [],
    );

    setUpAll(() async {
      await repository.initialize(collectionName: 'testCollection');
    });

    tearDownAll(() async {
      await repository.destroy();
    });

    test('create and read a Paint', () async {
      final createResult = await repository.create(testPaint);
      expect(createResult.isSuccess, true);

      final readResult = await repository.read(testPaint.id);
      expect(readResult.isSuccess, true);
      expect(readResult.value?.id, testPaint.id);
    });

    test('update a Paint', () async {
      await repository.create(testPaint);

      final updatedPaint = testPaint.copyWith(name: 'Updated Name');
      final updateResult =
          await repository.update(testPaint.id, updatedPaint);
      expect(updateResult.isSuccess, true);
      expect(updateResult.value?.name, 'Updated Name');
    });

    test('delete a Paint', () async {
      await repository.create(testPaint);

      final deleteResult = await repository.delete(testPaint.id);
      expect(deleteResult.isSuccess, true);

      final readResult = await repository.read(testPaint.id);
      expect(readResult.status, CRUDStatus.NotFound);
    });

    test('list all Paints', () async {
      await repository.create(testPaint);

      final listResult = await repository.list();

      expect(listResult.isSuccess, true);
      expect(listResult.value?.length, 1);
      await repository.delete(testPaint.id);
    });

    test('watch changes on a Paint', () async {
      final stream = await repository.changes(testPaint.id);

      final changedArt = testPaint.copyWith(name: 'streamTestUpdateNewName');
      final changedArt1 =
          testPaint.copyWith(name: 'streamTestUpdateNewName1');
      final changedArt2 =
          testPaint.copyWith(name: 'streamTestUpdateNewName2');

      expect(
          stream,
          emitsInOrder(
              [testPaint, changedArt, changedArt1, changedArt2, null]));

      await repository.create(testPaint);

      await repository.update(testPaint.id, changedArt);

      await repository.update(testPaint.id, changedArt1);

      await repository.update(testPaint.id, changedArt2);

      await repository.delete(testPaint.id);
    });
  });

  group('Paint API', () {
    final context = _MockRequestContext();
    const uuid = Uuid();

    var art = Paint(
      id: uuid.v4(),
      name: uuid.v4(),
      description: uuid.v4(),
      width: 64,
      height: 64,
      editors: [],
      paintMatrix: [[]],
    );

    Future<HivePaintRepository> initRepo() async {
      final repository = HivePaintRepository();
      await repository.initialize(collectionName: 'paint_api_test');
      return repository;
    }

    late Future<HivePaintRepository> repoFuture;

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
      when(() => context.read<Future<HivePaintRepository>>())
          .thenAnswer((_) => repoFuture);
    });

    test('GET / - responds with a welcome message', () async {
      final response = route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.body(),
        completion(
            contains('This is an API for crating and editing paint art :-)')),
      );
    });

    test('POST / - creates a Paint', () async {
      when(() => context.request)
          .thenAnswer((e) => Request.post(Uri.base, body: art.serialize()));

      // Add more mock setups for request body, headers, etc. if needed

      final response = await paintRoute.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      // Add more assertions for response body, headers, etc.
    });

    test('GET /:id - reads a Paint', () async {
      when(() => context.request)
          .thenAnswer((e) => Request.get(Uri.base, body: art.id));
      // Mock the ID parameter from the URL

      final response = await paintSlugRoute.onRequest(context, art.id);
      expect(response.statusCode, equals(HttpStatus.ok));
      // Add more assertions for response body, headers, etc.
    });

    test('PUT /:id - updates a Paint', () async {
      art = art.copyWith(name: uuid.v4());
      when(() => context.request)
          .thenAnswer((e) => Request.put(Uri.base, body: art.serialize()));

      // Mock the ID parameter from the URL and request body if needed

      final response = await paintSlugRoute.onRequest(context, art.id);
      expect(response.statusCode, equals(HttpStatus.ok));
      // Add more assertions for response body, headers, etc.
    });

    test('DELETE /:id - deletes a Paint', () async {
      when(() => context.request)
          .thenAnswer((e) => Request.delete(Uri.base, body: art.id));
      final response = await paintSlugRoute.onRequest(context, art.id);
      expect(response.statusCode, equals(HttpStatus.ok));
    });

    test('GET / - lists all Paints', () async {
      when(() => context.request).thenAnswer((e) => Request.get(
            Uri.base,
          ));

      final response = await paintRoute.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      // Add more assertions for response body, headers, etc.
    });

    test('GET / - stream returns 404 for invalid ws request', () async {
      when(() => context.request).thenAnswer((e) => Request.get(Uri.base));

      final response = await paintSlugStreamRoute.onRequest(context, art.id);
      expect(response.statusCode, equals(HttpStatus.notFound));
      // Add more assertions for response body, headers, etc.
    });
  });
}

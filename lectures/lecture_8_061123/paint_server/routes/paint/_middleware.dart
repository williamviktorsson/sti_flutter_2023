// dependency injection across routes.
import 'package:dart_frog/dart_frog.dart';
import 'package:paint_server/src/hive_repository.dart';

Middleware repositoryProvider() {
  return provider<Future<HivePaintRepository>>(
    (context) async {
      final repository = HivePaintRepository();
      await repository.initialize(collectionName: 'paints');
      return repository;
    },
  );
}

Handler middleware(Handler handler) {
  return handler.use(repositoryProvider());
}

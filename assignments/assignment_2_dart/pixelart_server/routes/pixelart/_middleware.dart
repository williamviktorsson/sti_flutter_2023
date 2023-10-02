// dependency injection across routes.
import 'package:dart_frog/dart_frog.dart';
import 'package:pixelart_server/src/hive_repository.dart';

Middleware repositoryProvider() {
  return provider<Future<HivePixelArtRepository>>(
    (context) async {
      final repository = HivePixelArtRepository();
      await repository.initialize(collectionName: 'pixelarts');
      return repository;
    },
  );
}

Handler middleware(Handler handler) {
  return handler.use(repositoryProvider());
}

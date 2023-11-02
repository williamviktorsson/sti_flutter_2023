// dependency injection across routes.
import 'package:dart_frog/dart_frog.dart';
import 'package:game_server/src/hive_repository.dart';

Middleware repositoryProvider() {
  return provider<Future<HiveBoardRepository>>(
    (context) async {
      final repository = HiveBoardRepository();
      await repository.initialize(collectionName: 'games');
      return repository;
    },
  );
}

Handler middleware(Handler handler) {
  return handler.use(repositoryProvider());
}

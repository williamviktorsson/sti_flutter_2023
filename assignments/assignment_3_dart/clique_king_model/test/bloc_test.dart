import 'dart:io';

import 'package:clique_king_model/clique_king_model.dart';
import 'package:dotenv/dotenv.dart';
import 'package:firedart/firedart.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() async {
  // TODO: Expand these tests.

  group('A group of tests', () {
    late AuthenticationRepository authenticationRepository;
    late UserRepository userRepository;
    setUpAll(() async {
      final env = DotEnv(includePlatformEnvironment: true)..load();
      String? apiKey = env['FIREBASE_API_KEY'];
      String? projectId = env['FIREBASE_PROJECT_ID'];

      if (apiKey == null) {
        print("FIREBASE_API_KEY missing from .env file");
        exit(0);
      }

      if (projectId == null) {
        print("FIREBASE_PROJECT_ID missing from .env file");
        exit(0);
      }

      FirebaseAuth.initialize(
          apiKey, await HiveStore.create(path: Directory.current.path));
      Firestore.initialize(projectId);
      authenticationRepository =
          AuthenticationRepository(auth: FirebaseAuth.instance);
      userRepository = UserRepository(store: Firestore.instance);
    });

    blocTest(
      'Nothing emitted when created, initial state == UserInitial',
      build: () => UserBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository),
      expect: () => [],
      verify: (bloc) => bloc.state is UserInitial,
    );

    blocTest(
      'Emits LoginInProgress on UserStarted Event (which should be sent on app startup)',
      build: () => UserBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository),
      act: (bloc) => bloc.add(UserStarted()), // UserStarted is a Naming Convention
      expect: () => [UserLoginInProgress()], // why userstarted -> userlogin?
      // try login using local token if exists?
    );
  });
}

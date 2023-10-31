import 'dart:io';

import 'package:clique_king_model/clique_king_model.dart';
import 'package:clique_king_model/src/models/user.dart';
import 'package:firedart/auth/user_gateway.dart' as auth;
import 'package:firedart/firedart.dart';
import 'package:dotenv/dotenv.dart';

void main() async {
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

  AuthenticationRepository repository =
      AuthenticationRepository(auth: FirebaseAuth.instance);

  late User user;

  try {
    user = await repository.signUp(
        "name", "name@boom.com", "abc123!"); // signing up also signs in
    await Firestore.instance
        .collection("users")
        .document(user.id)
        .set(user.toJson()); // add user to users collection
  } catch (e) {
    print(e);
  }


  if (!FirebaseAuth.instance.isSignedIn) {
    final success = await repository.signIn("name@boom.com", "abc123!");
    print("signed in: $success");
  }

  FirebaseAuth.instance.signInState.listen((event) {
    print(event);
  });

  Firestore.instance.collection("users").stream.listen((event) {
    //print(event); // get all users when the users collection changes
  });

  final currentUser = await FirebaseAuth.instance.getUser();

  final document = await Firestore.instance
      .collection("users")
      .document(currentUser.id)
      .get();

  Firestore.instance.collection("users").document(document.id).stream.listen(
    (event) {
      print({"yooo", event});
    },
  );

  //await Firestore.instance.collection("users").document(document.id).delete();
await Firestore.instance.collection("users").document(document.id).update({"name": "new name", "id": "new id", "score": 100});
  var exists =
      await Firestore.instance.collection("users").document(document.id).exists;

  if (!exists) {
    await FirebaseAuth.instance.deleteAccount();
  }
  await Future.delayed(Duration(seconds: 1));

  exit(255);
}

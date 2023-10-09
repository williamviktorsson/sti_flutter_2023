import 'dart:io';

import 'package:clique_king_model/clique_king_model.dart';
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
  try {
    await FirebaseAuth.instance.signUp("tester@lester.com", "test123"); // successful signup = logged in
  } catch (e) {
    print(e);
  }

  FirebaseAuth.instance.signInState.listen((event) {
    print(event);
  });

  Firestore.instance.collection("users").stream.listen((event) {
    print(event);
  });

  var user = await FirebaseAuth.instance.getUser();
  print(user.toString());

  final document =
      await Firestore.instance.collection("users").add(user.toMap());

  Firestore.instance.collection("users").document(document.id).stream.listen(
    (event) {
      print({"yooo", event});
    },
  );

  print(document);
  var read = auth.User.fromMap(document.map);
  print(read);

  await Firestore.instance.collection("users").document(document.id).delete();

  var exists =
      await Firestore.instance.collection("users").document(document.id).exists;

  if (!exists) {
    await FirebaseAuth.instance.deleteAccount();
  }
  await Future.delayed(Duration(seconds: 1));

  exit(255);
}

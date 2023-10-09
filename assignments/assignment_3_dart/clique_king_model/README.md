<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This package contains an implementation of the business logic for a social platform called "Clique King"

## Features

The package is implemented using the bloc pattern.
All operations are performed by submitting Actions to a bloc.
A GUI should listen to state changes emitted from the bloc to display the state of the application.

To use the package, provide .env file in root of directory to connect to Firebase.
Firebase provides authentication of users and storage of user information.

## Getting started

Learn how to use bloc.
Setup a Firebase project.
Enable Firebase authentication methods.
Initialize Firebase Firestore.

## Instructions

dart create -t package clique_king_model
dart pub add bloc
dart pub add bloc_test
dart pub add equatable
dart pub add meta

https://firebase.google.com/
signup with mail
add project
clique king (identifier clique-king)
enable analytics
analytics location sweden

build > authentication > get started > start with email+password
skip email link for now...
Authentication / Users -> Add user
test@test.com / test123 t.ex.

build > Firestore Database

Note here: Ideally, we would want a firebase function to trigger on auth create and then create a database entry.
However, to do this we need to upgrade to a paid plan with firebase.

Hence, we will handle it client side. If we successfully authenticate a user but we dont find anything in the database matching that account, we will create an empty user entity in the db.

Not great, not terrible.

Cloud firestore > Create database > start in test mode (lax rules)
Cloud location > europe-west 3 (frankfurt) > enable

rules > timestamp 2024-4-4 (to get that out of the way)

dart pub add firedart (not an official dart client, google maintains only the flutter client and thus does not provide desktop support (small indie company, please?))

Flutter client also only allows in-emulator/in-hardware testing, which makes it unsuitable for developing standalone

dart pub add hive

```dart
import 'package:firedart/firedart.dart';
import 'package:hive/hive.dart';

/// Stores tokens using a Hive store.
class HiveStore extends TokenStore {
  static const keyToken = "auth_token";

  static Future<HiveStore> create({required String path}) async {
    // Make sure you call both:
     Hive.init(path);
     Hive.registerAdapter(TokenAdapter());

    var box = await Hive.openBox("auth_store",
        compactionStrategy: (entries, deletedEntries) => deletedEntries > 50);
    return HiveStore._internal(box);
  }

  final Box _box;

  HiveStore._internal(this._box);

  @override
  Token read() => _box.get(keyToken);

  @override
  void write(Token? token) => _box.put(keyToken, token);

  @override
  void delete() => _box.delete(keyToken);
}

class TokenAdapter extends TypeAdapter<Token> {
  @override
  final typeId = 42;

  @override
  void write(BinaryWriter writer, Token token) =>
      writer.writeMap(token.toMap());

  @override
  Token read(BinaryReader reader) =>
      Token.fromMap(reader.readMap().map<String, dynamic>(
          (key, value) => MapEntry<String, dynamic>(key, value)));
}
```

Yoink the above code for a simple hive implementation of the "TokenStore" which should be provided to the firebase instance, for persisting auth tokens.

We need to put some environment variables down for our firebase project.

dart pub global activate dotenv (once again, billion dollar company by the way does not have its own .env solution)
dart pub add dotenv
export FIREBASE_API_KEY = "YOUR_WEB_API_KEY_FROM_PROJECT_SETTINGS/GENERAL"
export FIREBASE_PROJECT_ID = "clique-king" (unless you took some other project id)

Then, let's try it like this:

```dart
// example.dart
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
    await FirebaseAuth.instance.signUp("tester@lester.com", "test123");
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
  var read = User.fromMap(document.map);
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

```

Then we basically just need to do something similar to this:

https://bloclibrary.dev/#/flutterlogintutorial?id=authentication-repository
https://bloclibrary.dev/#/flutterlogintutorial?id=user-repository
https://bloclibrary.dev/#/flutterlogintutorial?id=authentication-bloc
https://bloclibrary.dev/#/flutterlogintutorial?id=authentication_eventdart
https://bloclibrary.dev/#/flutterlogintutorial?id=authentication_statedart
https://bloclibrary.dev/#/flutterlogintutorial?id=authentication_blocdart

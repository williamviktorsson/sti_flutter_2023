import 'package:clique_king_model/src/models/user.dart';
import 'package:firedart/firedart.dart';
import 'package:meta/meta.dart';

@immutable
final class AuthenticationRepository {
  final FirebaseAuth auth; // pass it in so it can be mocked.

  AuthenticationRepository({required this.auth});

  // TODO: Create methods for registration and login using Firebase Authentication.

  Future<User> signUp(String name, String email, String password) async {
    final user = await auth.signUp(email, password); // user from firebase auth

    return User(name: name, id: user.id); // user from our model
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final user =
          await auth.signIn(email, password); // user from firebase auth
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

import 'package:firedart/firedart.dart';
import 'package:meta/meta.dart';

@immutable
final class AuthenticationRepository {
  final FirebaseAuth auth; // pass it in so it can be mocked.

  AuthenticationRepository({required this.auth});

    // TODO: Create methods for registration and login using Firebase Authentication.

}

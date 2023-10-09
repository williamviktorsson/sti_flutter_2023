import 'package:firedart/firedart.dart';
import 'package:meta/meta.dart';

@immutable
final class UserRepository {
  final Firestore store; // pass it in so it can be mocked.

  UserRepository({required this.store});

  // TODO: Create methods for managing users stored in Firebase Firestore.
  // With Firestore, you have the option to return data once, or return a stream which emits
  // data anytime data in the query changes.
}

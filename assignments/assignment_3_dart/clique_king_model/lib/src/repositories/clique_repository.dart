import 'package:firedart/firedart.dart';
import 'package:meta/meta.dart';

@immutable
final class CliqueRepository {
  final Firestore store; // pass it in so it can be mocked.

  CliqueRepository({required this.store});

  // TODO: Create methods for managing cliques stored in Firebase Firestore.

  // Basically, crud.
  // With Firestore, you have the option to return data once, or return a stream which emits
  // data anytime data in the query changes.
}

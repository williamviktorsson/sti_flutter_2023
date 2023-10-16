import 'package:meta/meta.dart';

@immutable
class Score {
  final String userId;
  final String username; // creator selects name of clique
  final int value;

  Score({required this.userId, required this.username, required this.value});
}

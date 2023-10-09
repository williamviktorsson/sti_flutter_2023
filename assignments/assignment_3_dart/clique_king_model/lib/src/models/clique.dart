import 'package:meta/meta.dart';

typedef UserId = String;
typedef ParticipantScore = int;

@immutable
class Clique {
  final String id;
  final String name;

  final Map<UserId, ParticipantScore> participantScoreMap;

  // TODO: Reflect over participantScores
  // The user with the highest score is the Clique King

  Clique(
      {required this.id,
      required this.name,
      required this.participantScoreMap});
}

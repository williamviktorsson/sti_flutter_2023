import 'package:meta/meta.dart';

@immutable
class Clique {
  final String id; // TODO: generate with uuid?
  final String name; // creator selects name of clique

  Clique({
    required this.id,
    required this.name,
  });
}

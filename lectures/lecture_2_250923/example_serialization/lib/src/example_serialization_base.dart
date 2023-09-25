// TODO: Put public facing types in this file.
import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';

class Example {
  final String name;
  final String id;

  const Example({required this.name, required this.id});

  factory Example.fromJson(Map<String, dynamic> json) {
    return Example(name: json['name'], id: json['id']);
  }

  Map<String, dynamic> toJson() => {'name': name, 'id': id};

  // first convert to json. then use built in json encoding to string
  String serialize() {
    final json = toJson();
    final string = jsonEncode(json);
    return string;
  }

  // first convert string to json, then create class from json
  factory Example.deserialize(String serialized) {
    return Example.fromJson(jsonDecode(serialized));
  }

  Example copyWith({
    String? name,
    String? id,
  }) {
    return Example(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}

class ExampleHolder {
  String id;
  List<Example> examples;
  ExampleHolder({
    required this.id,
    this.examples = const [],
  });

  factory ExampleHolder.fromJson(Map<String, dynamic> json) {
    return ExampleHolder(
      id: json['id'],
      examples: (json['examples'] as List)
          .map((json) => Example.fromJson(json))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'examples': examples.map((example) => example.toJson()).toList(),
      };

  String serialize() => jsonEncode(toJson());

  factory ExampleHolder.deserialize(String serialized) {
    return ExampleHolder.fromJson(jsonDecode(serialized));
  }
  ExampleHolder copyWith({String? id, List<Example>? examples}) {
    return ExampleHolder(
        id: id ?? this.id, examples: examples ?? this.examples);
  }
}

void main(List<String> args) {
  ExampleHolder temp = ExampleHolder(id: "123");

  // Den här typen av operationer kommer vårt bloc utföra när actions skickas från gui

  ExampleHolder changed = temp.copyWith(
      examples: [...temp.examples, Example(name: "name", id: "123123id")]);

  // sedan sparas förändringarna via repo
}

class ExampleRepository {
  late Box<String> _exampleBox; // late = promise that it WILL BE SET before use

  ExampleRepository() {
    Directory directory = Directory.current;
    Hive.init(directory.path);
  }

  Future<void> initialize() async {
    //: potential race condition if initialize is unawaited in application
    _exampleBox = await Hive.openBox('examples');
  }

  bool create(Example example) {
    var existing = _exampleBox.get(example.id);
    if (existing != null) {
      return false;
    }
    _exampleBox.put(example.id, example.serialize());
    return true;
  }

  Example? read(String id) {
    var serialized = _exampleBox.get(id);
    return serialized != null ? Example.deserialize(serialized) : null;
  }

  Example update(Example example) {
    var existing = _exampleBox.get(example.id);
    if (existing == null) {
      throw Exception('Example not found');
    }
    _exampleBox.put(example.id, example.serialize());
    return example;
  }

  bool delete(String id) {
    var existing = _exampleBox.get(id);
    if (existing != null) {
      _exampleBox.delete(id);
      return true;
    }
    return false;
  }

  List<Example> readAll() {
    return _exampleBox.values
        .map((serialized) => Example.deserialize(serialized))
        .toList();
  }
}

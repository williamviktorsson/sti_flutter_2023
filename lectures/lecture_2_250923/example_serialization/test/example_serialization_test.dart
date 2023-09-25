import 'package:example_serialization/example_serialization.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Example tests', () {
    final repository = ExampleRepository();

    setUp(() async {
      // Additional setup goes here.
      await repository.initialize();
    });

    test('Create Example', () {
      var uuid = Uuid();
      Example example = Example(id: uuid.v4(), name: "ExampleName");
      expect(example, isNotNull);
    });

    test('Add Example to Repository', () {
      var uuid = Uuid();
      Example example = Example(id: uuid.v4(), name: "ExampleName");
      bool result = repository.create(example);
      expect(result, isTrue);
    });

    test('Read Example from Repository', () {
      var uuid = Uuid();
      var example = Example(id: uuid.v4(), name: "ExampleName");
      repository.create(example);

      var retrievedExample = repository.read(example.id);
      expect(retrievedExample?.id, equals(example.id));
      expect(retrievedExample?.name, equals(example.name));
    });

    test('Update Example in Repository', () {
      var uuid = Uuid();
      var example = Example(id: uuid.v4(), name: "ExampleName");
      repository.create(example);

      var updatedExample = Example(id: example.id, name: "UpdatedName");
      var returnedExample = repository.update(updatedExample);
      expect(returnedExample.name, equals("UpdatedName"));
    });

    test('Delete Example from Repository', () {
      var uuid = Uuid();
      var example = Example(id: uuid.v4(), name: "ExampleName");
      repository.create(example);

      bool deleted = repository.delete(example.id);
      expect(deleted, isTrue);
      var retrievedExample = repository.read(example.id);
      expect(retrievedExample, isNull);
    });
  });
}

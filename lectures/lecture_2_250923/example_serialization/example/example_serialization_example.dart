
import 'package:example_serialization/example_serialization.dart';

void main() async {
  // Initialize an ExampleRepository
  ExampleRepository repository = ExampleRepository();

  await repository.initialize();

  // Create a few Examples
  Example example1 = Example(id: "123", name: "ExampleName1");
  Example example2 = Example(id: "124", name: "ExampleName2");

  // Print out the example's name
  print(example1.name);

  // Use the ExampleRepository to store the example
  bool isCreated1 = repository.create(example1);
  print('Example1 added to repository: $isCreated1');

  bool isCreated2 = repository.create(example2);
  print('Example2 added to repository: $isCreated2');

  // Read it back
  Example? readExample1 = repository.read(example1.id);
  print('Read example1 name: ${readExample1?.name}');

  // Update it
  Example updatedExample1 = Example(id: example1.id, name: "UpdatedName1");
  Example updatedVersion1 = repository.update(updatedExample1);
  print('Updated example1 name: ${updatedVersion1.name}');

  // List all the examples in the repository
  List<Example> allExamples = repository.readAll();
  print('Number of examples in repository: ${allExamples.length}');

  bool isDeleted1 = repository.delete(example1.id);
  print('Example1 deleted from repository: $isDeleted1');
}

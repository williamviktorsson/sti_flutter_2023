import 'dart:io';
import 'package:paint_client/paint_client.dart';
import 'package:paint_shared/paint_shared.dart';
import 'package:uuid/uuid.dart';

void main() async {
  // Initialize a UUID generator
  Uuid uuid = Uuid();

  // Create a new Paint object
  Paint art = Paint(
    id: uuid.v4(),
    name: uuid.v4(),
    description: uuid.v4(),
    width: 64,
    height: 64,
    editors: [],
    paintMatrix: [[]],
  );

  // Initialize the repository
  final repository = HTTPPaintRepository(url: "localhost:8080/paint");
  var connected = false;
  for (int i = 0; i < 10; i++) {
    var response = await repository.list();
    if (response.isFailure && response.status == CRUDStatus.NetworkError) {
      print(
          "NetworkError connecting to server. Is the server up and running? Start with 'dart_frog dev'");
      await Future.delayed(Duration(seconds: 2));
    } else {
      connected = true;
      break;
    }
  }

  if (!connected) {
    print(
        "Unable to connect to server. Is the server up and running? Start with 'dart_frog dev'");
    print("Exiting. Try again.");
    exit(255);
  }

  // Subscribe to changes in Paint
  final stream = await repository.changes(art.id);
  final subscription = stream.listen((art) {
    if (art != null) {
      print('----> Paint Changed:');
      print(art);
    } else {
      print('----> Paint Deleted');
    }
  });

  // Create a new Paint record
  print('Creating new Paint record...');
  await repository.create(art);
  print('----> Created.');

  // Read the Paint record
  print('Reading Paint record...');
  final result = await repository.read(art.id);
  print('----> Read complete:');
  print(result.value);

  // Update the Paint description
  print('Updating Paint description...');
  art = art.copyWith(description: "changedDesc${uuid.v4()}");
  await repository.update(art.id, art);
  print('----> Update complete.');

  // List all Paints
  print('Listing all Paints...');
  await repository.list();
  print('----> List complete.');

  // Delete the Paint
  print('Deleting Paint...');
  await repository.delete(art.id);
  print('----> Deletion complete.');

  // List all Paints to confirm deletion
  print('Listing all Paints to confirm deletion...');
  await repository.list();
  print('----> List complete. Deletion confirmed.');

  // Cancel the subscription to changes
  print('Canceling subscription...');
  subscription.cancel();
  print('----> Subscription canceled.');

  // Exit the application
  print('Exiting application.');
  exit(0);
}

import 'dart:io';
import 'package:game_client/game_client.dart';
import 'package:game_shared/game_shared.dart';
import 'package:uuid/uuid.dart';

void main() async {
  // Initialize a UUID generator
  Uuid uuid = Uuid();

  // Create a new Board object
  Board art = Board(
    id: uuid.v4(),
    name: uuid.v4(),
    description: uuid.v4(),
    width: 64,
    height: 64,
    players: [],
    player_positions: {},
  );

  // Initialize the repository
  final repository = HTTPBoardRepository(url: "localhost:8080/game");
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

  // Subscribe to changes in Board
  final stream = await repository.changes(art.id);
  final subscription = stream.listen((art) {
    if (art != null) {
      print('----> Board Changed:');
      print(art);
    } else {
      print('----> Board Deleted');
    }
  });

  // Create a new Board record
  print('Creating new Board record...');
  await repository.create(art);
  print('----> Created.');

  // Read the Board record
  print('Reading Board record...');
  final result = await repository.read(art.id);
  print('----> Read complete:');
  print(result.value);

  // Update the Board description
  print('Updating Board description...');
  art = art.copyWith(description: "changedDesc${uuid.v4()}");
  await repository.update(art.id, art);
  print('----> Update complete.');

  // List all Boards
  print('Listing all Boards...');
  await repository.list();
  print('----> List complete.');

  // Delete the Board
  print('Deleting Board...');
  await repository.delete(art.id);
  print('----> Deletion complete.');

  // List all Boards to confirm deletion
  print('Listing all Boards to confirm deletion...');
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

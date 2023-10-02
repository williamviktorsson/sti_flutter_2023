import 'dart:io';
import 'package:pixelart_client/pixelart_client.dart';
import 'package:pixelart_shared/pixelart_shared.dart';
import 'package:uuid/uuid.dart';

void main() async {
  // Initialize a UUID generator
  Uuid uuid = Uuid();

  // Create a new PixelArt object
  PixelArt art = PixelArt(
    id: uuid.v4(),
    name: uuid.v4(),
    description: uuid.v4(),
    width: 64,
    height: 64,
    editors: [],
    pixelMatrix: [[]],
  );

  // Initialize the repository
  final repository = HTTPPixelArtRepository(url: "localhost:8080/pixelart");
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

  // TODO: 20. Use the create/read/list/update/delete/changes methods of the repository to show how it is supposed to be used.

  // Exit the application
  print('Exiting application.');
  exit(0);
}

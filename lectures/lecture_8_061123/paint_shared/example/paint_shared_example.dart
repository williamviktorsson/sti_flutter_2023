import 'package:paint_shared/paint_shared.dart';

void main() {
  // Create participants
  final john = Participant(id: '1', name: 'John Doe');
  final jane = Participant(id: '2', name: 'Jane Smith');

  print('Participants Created:');
  print('Participant 1: ${john.name}');
  print('Participant 2: ${jane.name}');
  print('-----------------------------');

  // Create paints
  final redPixel = Pixel(
    red: 255,
    green: 0,
    blue: 0,
    alpha: 1,
    placedBy: john,
  );

  final bluePixel = Pixel(
    red: 0,
    green: 0,
    blue: 255,
    alpha: 1,
    placedBy: jane,
  );

  print('Pixels Created:');
  print('Red Pixel by ${redPixel.placedBy.name}');
  print('Blue Pixel by ${bluePixel.placedBy.name}');
  print('-----------------------------');

  // Create a Paint
  final art = Paint(
    id: 'art1',
    name: 'Flag Art',
    description: 'A simple flag art',
    width: 3,
    height: 2,
    editors: [john, jane],
    paintMatrix: [
      [redPixel, redPixel, redPixel],
      [bluePixel, bluePixel, bluePixel],
    ],
  );

  print('Pixel Art Created:');
  print('Name: ${art.name}');
  print('Description: ${art.description}');
  print('Width x Height: ${art.width}x${art.height}');
  print('Editors: ${art.editors.map((e) => e.name).join(', ')}');
  print('Pixel Matrix:');
  for (var row in art.paintMatrix) {
    for (var paint in row) {
      print(
          '${paint.placedBy.name} placed a paint with RGB(${paint.red},${paint.green},${paint.blue})');
    }
  }
  print('-----------------------------');

  // Update Paint using placePixel
  final greenPixel = Pixel(
    red: 0,
    green: 255,
    blue: 0,
    alpha: 1,
    placedBy: john,
  );

  final updatedArt = art.placePixel(1, 1, greenPixel);

  print('Pixel Art Updated:');
  print(
      'Pixel at (1,1) updated to green by ${updatedArt.paintMatrix[1][1].placedBy.name}');
}

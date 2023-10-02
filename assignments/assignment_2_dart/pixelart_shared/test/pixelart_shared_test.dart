import 'package:pixelart_shared/pixelart_shared.dart';
import 'package:test/test.dart';

void main() {
  group('PixelArt Tests', () {

    test('Creation of Participant', () {
      final participant = Participant(id: '1', name: 'John Doe');
      expect(participant.id, '1');
      expect(participant.name, 'John Doe');
    });

    test('Creation of Pixel', () {
      final participant = Participant(id: '1', name: 'John Doe');
      final pixel = Pixel(
        red: 255,
        green: 255,
        blue: 255,
        alpha: 1,
        placedBy: participant,
      );
      expect(pixel.red, 255);
      expect(pixel.placedBy.name, 'John Doe');
    });

    test('Creation of PixelArt', () {
      final participant = Participant(id: '1', name: 'John Doe');
      final pixel = Pixel(
        red: 255,
        green: 255,
        blue: 255,
        alpha: 1,
        placedBy: participant,
      );
      final pixelArt = PixelArt(
        id: 'art1',
        name: 'Sample Art',
        description: 'A sample pixel art',
        width: 5,
        height: 5,
        editors: [participant],
        pixelMatrix: [
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
        ],
      );
      expect(pixelArt.id, 'art1');
      expect(pixelArt.pixelMatrix[0][0].red, 255);
    });

    test('Update PixelArt using placePixel', () {
      final participant = Participant(id: '1', name: 'John Doe');
      final pixel = Pixel(
        red: 255,
        green: 255,
        blue: 255,
        alpha: 1,
        placedBy: participant,
      );
      final newPixel = Pixel(
        red: 0,
        green: 0,
        blue: 0,
        alpha: 1,
        placedBy: participant,
      );
      final pixelArt = PixelArt(
        id: 'art1',
        name: 'Sample Art',
        description: 'A sample pixel art',
        width: 5,
        height: 5,
        editors: [participant],
        pixelMatrix: [
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
        ],
      );

      final updatedPixelArt = pixelArt.placePixel(2, 2, newPixel);
      expect(updatedPixelArt.pixelMatrix[2][2].red, 0);
      expect(pixelArt.pixelMatrix[2][2].red, 255);
    });
  });
}

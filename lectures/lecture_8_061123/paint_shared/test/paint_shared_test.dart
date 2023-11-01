import 'package:paint_shared/paint_shared.dart';
import 'package:test/test.dart';

void main() {
  group('Paint Tests', () {
    test('Creation of Participant', () {
      final participant = Participant(id: '1', name: 'John Doe');
      expect(participant.id, '1');
      expect(participant.name, 'John Doe');
    });

    test('Creation of Pixel', () {
      final participant = Participant(id: '1', name: 'John Doe');
      final paint = Pixel(
        red: 255,
        green: 255,
        blue: 255,
        alpha: 1,
        placedBy: participant,
      );
      expect(paint.red, 255);
      expect(paint.placedBy.name, 'John Doe');
    });

    test('Creation of Paint', () {
      final participant = Participant(id: '1', name: 'John Doe');
      final pixel = Pixel(
        red: 255,
        green: 255,
        blue: 255,
        alpha: 1,
        placedBy: participant,
      );
      final paint = Paint(
        id: 'art1',
        name: 'Sample Art',
        description: 'A sample paint art',
        width: 5,
        height: 5,
        editors: [participant],
        paintMatrix: [
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
        ],
      );
      expect(paint.id, 'art1');
      expect(paint.paintMatrix[0][0].red, 255);
    });

    test('Update Paint using placePixel', () {
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
      final paint = Paint(
        id: 'art1',
        name: 'Sample Art',
        description: 'A sample paint art',
        width: 5,
        height: 5,
        editors: [participant],
        paintMatrix: [
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
          [pixel, pixel, pixel, pixel, pixel],
        ],
      );

      final updatedPaint = paint.placePixel(2, 2, newPixel);
      expect(updatedPaint.paintMatrix[2][2].red, 0);
      expect(paint.paintMatrix[2][2].red, 255);
    });
  });
}

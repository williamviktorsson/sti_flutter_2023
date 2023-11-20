import 'package:game_shared/game_shared.dart';
import 'package:test/test.dart';

void main() {
  group('Board Game Tests', () {
    test('Creation of Player', () {
      final player = Player(id: '1', name: 'John Doe');
      expect(player.id, '1');
      expect(player.name, 'John Doe');
    });

    test('Creation of Board', () {
      final player = Player(id: '1', name: 'John Doe');
      final board = Board(
        id: '1',
        name: 'Test Board',
        description: 'This is a test board',
        width: 5,
        height: 5,
        players: [player],
        player_positions: {'1': Position(x: 0, y: 0)},
      );
      expect(board.width, 5);
      expect(board.height, 5);
      expect(board.players.first.name, 'John Doe');
      expect(board.player_positions['1']?.x, 0);
      expect(board.player_positions['1']?.y, 0);
    });

    test('Update Board using placePlayer', () {
      final player1 = Player(id: '1', name: 'John Doe');
      final player2 = Player(id: '2', name: 'Jane Doe');
      final board = Board(
        id: '1',
        name: 'Test Board',
        description: 'This is a test board',
        width: 5,
        height: 5,
        players: [player1],
        player_positions: {'1': Position(x: 0, y: 0)},
      );

      final updatedBoard = board.placePlayer(x: 2, y: 2, player: player2);
      expect(updatedBoard.player_positions['2']?.x, 2);
      expect(updatedBoard.player_positions['2']?.y, 2);
      expect(board.player_positions['1']?.x, 0);
      expect(board.player_positions['1']?.y, 0);
    });
  });
}
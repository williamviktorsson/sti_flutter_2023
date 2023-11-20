import 'package:game_shared/game_shared.dart';

void main() {
  // Create participants
  final john = Player(id: '1', name: 'John Doe');
  final jane = Player(id: '2', name: 'Jane Smith');

  print('Participants Created:');
  print('Participant 1: ${john.name}');
  print('Participant 2: ${jane.name}');
  print('-----------------------------');

  // Create a Board
  final board = Board(
    id: 'board1',
    name: 'Board Game',
    description: 'A simple board game',
    width: 3,
    height: 3,
    players: [john, jane],
    player_positions: {'1': Position(x: 0, y: 0), '2': Position(x: 1, y: 1)},
  );

  print('Board Game Created:');
  print('Name: ${board.name}');
  print('Description: ${board.description}');
  print('Width x Height: ${board.width}x${board.height}');
  print('Players: ${board.players.map((p) => p.name).join(', ')}');
  print('Player Positions:');
  for (var entry in board.player_positions.entries) {
    print('${board.players.firstWhere((p) => p.id == entry.key).name} is at (${entry.value.x},${entry.value.y})');
  }
  print('-----------------------------');

  // Update Board using placePlayer
  final updatedBoard = board.placePlayer(x: 2, y: 2, player: john);

  print('Board Game Updated:');
  print(
      '${john.name} moved to (${updatedBoard.player_positions[john.id]?.x},${updatedBoard.player_positions[john.id]?.y})');
}
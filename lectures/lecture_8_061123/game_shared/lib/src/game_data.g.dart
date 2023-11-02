// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Player _$$_PlayerFromJson(Map<String, dynamic> json) => _$_Player(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_PlayerToJson(_$_Player instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$_Position _$$_PositionFromJson(Map<String, dynamic> json) => _$_Position(
      x: json['x'] as int,
      y: json['y'] as int,
    );

Map<String, dynamic> _$$_PositionToJson(_$_Position instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };

_$_Board _$$_BoardFromJson(Map<String, dynamic> json) => _$_Board(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      players: (json['players'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      player_positions: (json['player_positions'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Position.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$_BoardToJson(_$_Board instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'width': instance.width,
      'height': instance.height,
      'players': instance.players.map((e) => e.toJson()).toList(),
      'player_positions':
          instance.player_positions.map((k, e) => MapEntry(k, e.toJson())),
    };

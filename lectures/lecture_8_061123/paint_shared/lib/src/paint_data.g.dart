// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paint_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Participant _$$_ParticipantFromJson(Map<String, dynamic> json) =>
    _$_Participant(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_ParticipantToJson(_$_Participant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$_Pixel _$$_PixelFromJson(Map<String, dynamic> json) => _$_Pixel(
      red: json['red'] as int,
      green: json['green'] as int,
      blue: json['blue'] as int,
      alpha: json['alpha'] as int,
      placedBy: Participant.fromJson(json['placedBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PixelToJson(_$_Pixel instance) => <String, dynamic>{
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
      'alpha': instance.alpha,
      'placedBy': instance.placedBy,
    };

_$_Paint _$$_PaintFromJson(Map<String, dynamic> json) => _$_Paint(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      editors: (json['editors'] as List<dynamic>)
          .map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
      paintMatrix: (json['paintMatrix'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => Pixel.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$$_PaintToJson(_$_Paint instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'width': instance.width,
      'height': instance.height,
      'editors': instance.editors.map((e) => e.toJson()).toList(),
      'paintMatrix': instance.paintMatrix
          .map((e) => e.map((e) => e.toJson()).toList())
          .toList(),
    };

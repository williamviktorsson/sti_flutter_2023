// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pixelart_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParticipantImpl _$$ParticipantImplFromJson(Map<String, dynamic> json) =>
    _$ParticipantImpl(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$ParticipantImplToJson(_$ParticipantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$PixelImpl _$$PixelImplFromJson(Map<String, dynamic> json) => _$PixelImpl(
      red: json['red'] as int,
      green: json['green'] as int,
      blue: json['blue'] as int,
      alpha: json['alpha'] as int,
      placedBy: Participant.fromJson(json['placedBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PixelImplToJson(_$PixelImpl instance) =>
    <String, dynamic>{
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
      'alpha': instance.alpha,
      'placedBy': instance.placedBy,
    };

_$PixelArtImpl _$$PixelArtImplFromJson(Map<String, dynamic> json) =>
    _$PixelArtImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      editors: (json['editors'] as List<dynamic>)
          .map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
      pixelMatrix: (json['pixelMatrix'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => Pixel.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$$PixelArtImplToJson(_$PixelArtImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'width': instance.width,
      'height': instance.height,
      'editors': instance.editors.map((e) => e.toJson()).toList(),
      'pixelMatrix': instance.pixelMatrix
          .map((e) => e.map((e) => e.toJson()).toList())
          .toList(),
    };

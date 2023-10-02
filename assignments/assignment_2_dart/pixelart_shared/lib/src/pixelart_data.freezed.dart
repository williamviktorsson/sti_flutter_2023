// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pixelart_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Participant _$ParticipantFromJson(Map<String, dynamic> json) {
  return _Participant.fromJson(json);
}

/// @nodoc
mixin _$Participant {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParticipantCopyWith<Participant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParticipantCopyWith<$Res> {
  factory $ParticipantCopyWith(
          Participant value, $Res Function(Participant) then) =
      _$ParticipantCopyWithImpl<$Res, Participant>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$ParticipantCopyWithImpl<$Res, $Val extends Participant>
    implements $ParticipantCopyWith<$Res> {
  _$ParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParticipantImplCopyWith<$Res>
    implements $ParticipantCopyWith<$Res> {
  factory _$$ParticipantImplCopyWith(
          _$ParticipantImpl value, $Res Function(_$ParticipantImpl) then) =
      __$$ParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$ParticipantImplCopyWithImpl<$Res>
    extends _$ParticipantCopyWithImpl<$Res, _$ParticipantImpl>
    implements _$$ParticipantImplCopyWith<$Res> {
  __$$ParticipantImplCopyWithImpl(
      _$ParticipantImpl _value, $Res Function(_$ParticipantImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$ParticipantImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParticipantImpl implements _Participant {
  const _$ParticipantImpl({required this.id, required this.name});

  factory _$ParticipantImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParticipantImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'Participant(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParticipantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParticipantImplCopyWith<_$ParticipantImpl> get copyWith =>
      __$$ParticipantImplCopyWithImpl<_$ParticipantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParticipantImplToJson(
      this,
    );
  }
}

abstract class _Participant implements Participant {
  const factory _Participant(
      {required final String id,
      required final String name}) = _$ParticipantImpl;

  factory _Participant.fromJson(Map<String, dynamic> json) =
      _$ParticipantImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$ParticipantImplCopyWith<_$ParticipantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Pixel _$PixelFromJson(Map<String, dynamic> json) {
  return _Pixel.fromJson(json);
}

/// @nodoc
mixin _$Pixel {
  int get red => throw _privateConstructorUsedError;
  int get green => throw _privateConstructorUsedError;
  int get blue => throw _privateConstructorUsedError;
  int get alpha => throw _privateConstructorUsedError;
  Participant get placedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PixelCopyWith<Pixel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PixelCopyWith<$Res> {
  factory $PixelCopyWith(Pixel value, $Res Function(Pixel) then) =
      _$PixelCopyWithImpl<$Res, Pixel>;
  @useResult
  $Res call({int red, int green, int blue, int alpha, Participant placedBy});

  $ParticipantCopyWith<$Res> get placedBy;
}

/// @nodoc
class _$PixelCopyWithImpl<$Res, $Val extends Pixel>
    implements $PixelCopyWith<$Res> {
  _$PixelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? red = null,
    Object? green = null,
    Object? blue = null,
    Object? alpha = null,
    Object? placedBy = null,
  }) {
    return _then(_value.copyWith(
      red: null == red
          ? _value.red
          : red // ignore: cast_nullable_to_non_nullable
              as int,
      green: null == green
          ? _value.green
          : green // ignore: cast_nullable_to_non_nullable
              as int,
      blue: null == blue
          ? _value.blue
          : blue // ignore: cast_nullable_to_non_nullable
              as int,
      alpha: null == alpha
          ? _value.alpha
          : alpha // ignore: cast_nullable_to_non_nullable
              as int,
      placedBy: null == placedBy
          ? _value.placedBy
          : placedBy // ignore: cast_nullable_to_non_nullable
              as Participant,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ParticipantCopyWith<$Res> get placedBy {
    return $ParticipantCopyWith<$Res>(_value.placedBy, (value) {
      return _then(_value.copyWith(placedBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PixelImplCopyWith<$Res> implements $PixelCopyWith<$Res> {
  factory _$$PixelImplCopyWith(
          _$PixelImpl value, $Res Function(_$PixelImpl) then) =
      __$$PixelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int red, int green, int blue, int alpha, Participant placedBy});

  @override
  $ParticipantCopyWith<$Res> get placedBy;
}

/// @nodoc
class __$$PixelImplCopyWithImpl<$Res>
    extends _$PixelCopyWithImpl<$Res, _$PixelImpl>
    implements _$$PixelImplCopyWith<$Res> {
  __$$PixelImplCopyWithImpl(
      _$PixelImpl _value, $Res Function(_$PixelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? red = null,
    Object? green = null,
    Object? blue = null,
    Object? alpha = null,
    Object? placedBy = null,
  }) {
    return _then(_$PixelImpl(
      red: null == red
          ? _value.red
          : red // ignore: cast_nullable_to_non_nullable
              as int,
      green: null == green
          ? _value.green
          : green // ignore: cast_nullable_to_non_nullable
              as int,
      blue: null == blue
          ? _value.blue
          : blue // ignore: cast_nullable_to_non_nullable
              as int,
      alpha: null == alpha
          ? _value.alpha
          : alpha // ignore: cast_nullable_to_non_nullable
              as int,
      placedBy: null == placedBy
          ? _value.placedBy
          : placedBy // ignore: cast_nullable_to_non_nullable
              as Participant,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PixelImpl implements _Pixel {
  const _$PixelImpl(
      {required this.red,
      required this.green,
      required this.blue,
      required this.alpha,
      required this.placedBy});

  factory _$PixelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PixelImplFromJson(json);

  @override
  final int red;
  @override
  final int green;
  @override
  final int blue;
  @override
  final int alpha;
  @override
  final Participant placedBy;

  @override
  String toString() {
    return 'Pixel(red: $red, green: $green, blue: $blue, alpha: $alpha, placedBy: $placedBy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PixelImpl &&
            (identical(other.red, red) || other.red == red) &&
            (identical(other.green, green) || other.green == green) &&
            (identical(other.blue, blue) || other.blue == blue) &&
            (identical(other.alpha, alpha) || other.alpha == alpha) &&
            (identical(other.placedBy, placedBy) ||
                other.placedBy == placedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, red, green, blue, alpha, placedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PixelImplCopyWith<_$PixelImpl> get copyWith =>
      __$$PixelImplCopyWithImpl<_$PixelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PixelImplToJson(
      this,
    );
  }
}

abstract class _Pixel implements Pixel {
  const factory _Pixel(
      {required final int red,
      required final int green,
      required final int blue,
      required final int alpha,
      required final Participant placedBy}) = _$PixelImpl;

  factory _Pixel.fromJson(Map<String, dynamic> json) = _$PixelImpl.fromJson;

  @override
  int get red;
  @override
  int get green;
  @override
  int get blue;
  @override
  int get alpha;
  @override
  Participant get placedBy;
  @override
  @JsonKey(ignore: true)
  _$$PixelImplCopyWith<_$PixelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PixelArt _$PixelArtFromJson(Map<String, dynamic> json) {
  return _PixelArt.fromJson(json);
}

/// @nodoc
mixin _$PixelArt {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  List<Participant> get editors => throw _privateConstructorUsedError;
  List<List<Pixel>> get pixelMatrix => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PixelArtCopyWith<PixelArt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PixelArtCopyWith<$Res> {
  factory $PixelArtCopyWith(PixelArt value, $Res Function(PixelArt) then) =
      _$PixelArtCopyWithImpl<$Res, PixelArt>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      int width,
      int height,
      List<Participant> editors,
      List<List<Pixel>> pixelMatrix});
}

/// @nodoc
class _$PixelArtCopyWithImpl<$Res, $Val extends PixelArt>
    implements $PixelArtCopyWith<$Res> {
  _$PixelArtCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? width = null,
    Object? height = null,
    Object? editors = null,
    Object? pixelMatrix = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      editors: null == editors
          ? _value.editors
          : editors // ignore: cast_nullable_to_non_nullable
              as List<Participant>,
      pixelMatrix: null == pixelMatrix
          ? _value.pixelMatrix
          : pixelMatrix // ignore: cast_nullable_to_non_nullable
              as List<List<Pixel>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PixelArtImplCopyWith<$Res>
    implements $PixelArtCopyWith<$Res> {
  factory _$$PixelArtImplCopyWith(
          _$PixelArtImpl value, $Res Function(_$PixelArtImpl) then) =
      __$$PixelArtImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      int width,
      int height,
      List<Participant> editors,
      List<List<Pixel>> pixelMatrix});
}

/// @nodoc
class __$$PixelArtImplCopyWithImpl<$Res>
    extends _$PixelArtCopyWithImpl<$Res, _$PixelArtImpl>
    implements _$$PixelArtImplCopyWith<$Res> {
  __$$PixelArtImplCopyWithImpl(
      _$PixelArtImpl _value, $Res Function(_$PixelArtImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? width = null,
    Object? height = null,
    Object? editors = null,
    Object? pixelMatrix = null,
  }) {
    return _then(_$PixelArtImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      editors: null == editors
          ? _value._editors
          : editors // ignore: cast_nullable_to_non_nullable
              as List<Participant>,
      pixelMatrix: null == pixelMatrix
          ? _value._pixelMatrix
          : pixelMatrix // ignore: cast_nullable_to_non_nullable
              as List<List<Pixel>>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PixelArtImpl extends _PixelArt {
  const _$PixelArtImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.width,
      required this.height,
      required final List<Participant> editors,
      required final List<List<Pixel>> pixelMatrix})
      : _editors = editors,
        _pixelMatrix = pixelMatrix,
        super._();

  factory _$PixelArtImpl.fromJson(Map<String, dynamic> json) =>
      _$$PixelArtImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final int width;
  @override
  final int height;
  final List<Participant> _editors;
  @override
  List<Participant> get editors {
    if (_editors is EqualUnmodifiableListView) return _editors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_editors);
  }

  final List<List<Pixel>> _pixelMatrix;
  @override
  List<List<Pixel>> get pixelMatrix {
    if (_pixelMatrix is EqualUnmodifiableListView) return _pixelMatrix;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pixelMatrix);
  }

  @override
  String toString() {
    return 'PixelArt(id: $id, name: $name, description: $description, width: $width, height: $height, editors: $editors, pixelMatrix: $pixelMatrix)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PixelArtImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            const DeepCollectionEquality().equals(other._editors, _editors) &&
            const DeepCollectionEquality()
                .equals(other._pixelMatrix, _pixelMatrix));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      width,
      height,
      const DeepCollectionEquality().hash(_editors),
      const DeepCollectionEquality().hash(_pixelMatrix));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PixelArtImplCopyWith<_$PixelArtImpl> get copyWith =>
      __$$PixelArtImplCopyWithImpl<_$PixelArtImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PixelArtImplToJson(
      this,
    );
  }
}

abstract class _PixelArt extends PixelArt {
  const factory _PixelArt(
      {required final String id,
      required final String name,
      required final String description,
      required final int width,
      required final int height,
      required final List<Participant> editors,
      required final List<List<Pixel>> pixelMatrix}) = _$PixelArtImpl;
  const _PixelArt._() : super._();

  factory _PixelArt.fromJson(Map<String, dynamic> json) =
      _$PixelArtImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  int get width;
  @override
  int get height;
  @override
  List<Participant> get editors;
  @override
  List<List<Pixel>> get pixelMatrix;
  @override
  @JsonKey(ignore: true)
  _$$PixelArtImplCopyWith<_$PixelArtImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

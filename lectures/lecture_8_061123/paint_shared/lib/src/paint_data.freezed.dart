// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paint_data.dart';

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
abstract class _$$_ParticipantCopyWith<$Res>
    implements $ParticipantCopyWith<$Res> {
  factory _$$_ParticipantCopyWith(
          _$_Participant value, $Res Function(_$_Participant) then) =
      __$$_ParticipantCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$_ParticipantCopyWithImpl<$Res>
    extends _$ParticipantCopyWithImpl<$Res, _$_Participant>
    implements _$$_ParticipantCopyWith<$Res> {
  __$$_ParticipantCopyWithImpl(
      _$_Participant _value, $Res Function(_$_Participant) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$_Participant(
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
class _$_Participant implements _Participant {
  const _$_Participant({required this.id, required this.name});

  factory _$_Participant.fromJson(Map<String, dynamic> json) =>
      _$$_ParticipantFromJson(json);

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
            other is _$_Participant &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ParticipantCopyWith<_$_Participant> get copyWith =>
      __$$_ParticipantCopyWithImpl<_$_Participant>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ParticipantToJson(
      this,
    );
  }
}

abstract class _Participant implements Participant {
  const factory _Participant(
      {required final String id, required final String name}) = _$_Participant;

  factory _Participant.fromJson(Map<String, dynamic> json) =
      _$_Participant.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_ParticipantCopyWith<_$_Participant> get copyWith =>
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
abstract class _$$_PixelCopyWith<$Res> implements $PixelCopyWith<$Res> {
  factory _$$_PixelCopyWith(_$_Pixel value, $Res Function(_$_Pixel) then) =
      __$$_PixelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int red, int green, int blue, int alpha, Participant placedBy});

  @override
  $ParticipantCopyWith<$Res> get placedBy;
}

/// @nodoc
class __$$_PixelCopyWithImpl<$Res> extends _$PixelCopyWithImpl<$Res, _$_Pixel>
    implements _$$_PixelCopyWith<$Res> {
  __$$_PixelCopyWithImpl(_$_Pixel _value, $Res Function(_$_Pixel) _then)
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
    return _then(_$_Pixel(
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
class _$_Pixel implements _Pixel {
  const _$_Pixel(
      {required this.red,
      required this.green,
      required this.blue,
      required this.alpha,
      required this.placedBy});

  factory _$_Pixel.fromJson(Map<String, dynamic> json) =>
      _$$_PixelFromJson(json);

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
            other is _$_Pixel &&
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
  _$$_PixelCopyWith<_$_Pixel> get copyWith =>
      __$$_PixelCopyWithImpl<_$_Pixel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PixelToJson(
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
      required final Participant placedBy}) = _$_Pixel;

  factory _Pixel.fromJson(Map<String, dynamic> json) = _$_Pixel.fromJson;

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
  _$$_PixelCopyWith<_$_Pixel> get copyWith =>
      throw _privateConstructorUsedError;
}

Paint _$PaintFromJson(Map<String, dynamic> json) {
  return _Paint.fromJson(json);
}

/// @nodoc
mixin _$Paint {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  List<Participant> get editors => throw _privateConstructorUsedError;
  List<List<Pixel>> get paintMatrix => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaintCopyWith<Paint> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaintCopyWith<$Res> {
  factory $PaintCopyWith(Paint value, $Res Function(Paint) then) =
      _$PaintCopyWithImpl<$Res, Paint>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      int width,
      int height,
      List<Participant> editors,
      List<List<Pixel>> paintMatrix});
}

/// @nodoc
class _$PaintCopyWithImpl<$Res, $Val extends Paint>
    implements $PaintCopyWith<$Res> {
  _$PaintCopyWithImpl(this._value, this._then);

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
    Object? paintMatrix = null,
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
      paintMatrix: null == paintMatrix
          ? _value.paintMatrix
          : paintMatrix // ignore: cast_nullable_to_non_nullable
              as List<List<Pixel>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaintCopyWith<$Res> implements $PaintCopyWith<$Res> {
  factory _$$_PaintCopyWith(_$_Paint value, $Res Function(_$_Paint) then) =
      __$$_PaintCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      int width,
      int height,
      List<Participant> editors,
      List<List<Pixel>> paintMatrix});
}

/// @nodoc
class __$$_PaintCopyWithImpl<$Res> extends _$PaintCopyWithImpl<$Res, _$_Paint>
    implements _$$_PaintCopyWith<$Res> {
  __$$_PaintCopyWithImpl(_$_Paint _value, $Res Function(_$_Paint) _then)
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
    Object? paintMatrix = null,
  }) {
    return _then(_$_Paint(
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
      paintMatrix: null == paintMatrix
          ? _value._paintMatrix
          : paintMatrix // ignore: cast_nullable_to_non_nullable
              as List<List<Pixel>>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Paint extends _Paint {
  const _$_Paint(
      {required this.id,
      required this.name,
      required this.description,
      required this.width,
      required this.height,
      required final List<Participant> editors,
      required final List<List<Pixel>> paintMatrix})
      : _editors = editors,
        _paintMatrix = paintMatrix,
        super._();

  factory _$_Paint.fromJson(Map<String, dynamic> json) =>
      _$$_PaintFromJson(json);

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

  final List<List<Pixel>> _paintMatrix;
  @override
  List<List<Pixel>> get paintMatrix {
    if (_paintMatrix is EqualUnmodifiableListView) return _paintMatrix;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paintMatrix);
  }

  @override
  String toString() {
    return 'Paint(id: $id, name: $name, description: $description, width: $width, height: $height, editors: $editors, paintMatrix: $paintMatrix)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Paint &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            const DeepCollectionEquality().equals(other._editors, _editors) &&
            const DeepCollectionEquality()
                .equals(other._paintMatrix, _paintMatrix));
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
      const DeepCollectionEquality().hash(_paintMatrix));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaintCopyWith<_$_Paint> get copyWith =>
      __$$_PaintCopyWithImpl<_$_Paint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaintToJson(
      this,
    );
  }
}

abstract class _Paint extends Paint {
  const factory _Paint(
      {required final String id,
      required final String name,
      required final String description,
      required final int width,
      required final int height,
      required final List<Participant> editors,
      required final List<List<Pixel>> paintMatrix}) = _$_Paint;
  const _Paint._() : super._();

  factory _Paint.fromJson(Map<String, dynamic> json) = _$_Paint.fromJson;

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
  List<List<Pixel>> get paintMatrix;
  @override
  @JsonKey(ignore: true)
  _$$_PaintCopyWith<_$_Paint> get copyWith =>
      throw _privateConstructorUsedError;
}

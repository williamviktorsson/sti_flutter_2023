import 'package:firedart/firedart.dart';
import 'package:hive/hive.dart';

/// This is an implementation of a TokenStore which is required by firedart to persist
//  Authentication Tokens.
//  Persists data using Hive.
//  This hopefully does not need touching.
class HiveStore extends TokenStore {
  static const keyToken = "auth_token";

  static Future<HiveStore> create({required String path}) async {
    // Make sure you call both:
     Hive.init(path);
     Hive.registerAdapter(TokenAdapter());

    var box = await Hive.openBox("auth_store",
        compactionStrategy: (entries, deletedEntries) => deletedEntries > 50);
    return HiveStore._internal(box);
  }

  final Box _box;

  HiveStore._internal(this._box);

  @override
  Token? read() => _box.get(keyToken);

  @override
  void write(Token? token) => _box.put(keyToken, token);

  @override
  void delete() => _box.delete(keyToken);
}

class TokenAdapter extends TypeAdapter<Token> {
  @override
  final typeId = 42;

  @override
  void write(BinaryWriter writer, Token token) =>
      writer.writeMap(token.toMap());

  @override
  Token read(BinaryReader reader) =>
      Token.fromMap(reader.readMap().map<String, dynamic>(
          (key, value) => MapEntry<String, dynamic>(key, value)));
}

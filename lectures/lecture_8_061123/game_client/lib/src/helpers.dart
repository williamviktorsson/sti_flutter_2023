import 'package:http/http.dart';
import 'package:game_shared/game_shared.dart';

extension CheckSuccess on Response {
  bool get isSuccess => statusCode.toCRUDStatus == CRUDStatus.Success;
}

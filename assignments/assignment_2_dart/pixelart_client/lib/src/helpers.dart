import 'package:http/http.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

extension CheckSuccess on Response {
  bool get isSuccess => statusCode.toCRUDStatus == CRUDStatus.Success;
}

import 'package:http/http.dart';
import 'package:paint_shared/paint_shared.dart';

extension CheckSuccess on Response {
  bool get isSuccess => statusCode.toCRUDStatus == CRUDStatus.Success;
}

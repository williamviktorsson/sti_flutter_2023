enum CRUDStatus {
  Success(200),
  NotFound(404),
  ValidationFailed(400),
  DatabaseError(503),
  NetworkError(504),
  UnknownError(500),
  ;

  const CRUDStatus(this.code);
  final int code;

  factory CRUDStatus.fromHTTPStatusCode(int? i) {
    if (i != null) {
      for (var element in CRUDStatus.values) {
        if (element.code == i) {
          return element;
        }
      }
    }
    return CRUDStatus.UnknownError;
  }

  int get toHTTPStatusCode {
    return code;
  }
}

extension ToCRUDStatus on int? {
  CRUDStatus get toCRUDStatus => CRUDStatus.fromHTTPStatusCode(this);
}

class CRUDResult<T> {
  final T? value;
  final CRUDStatus status;
  final Object? error;

  CRUDResult.success([this.value])
      : status = CRUDStatus.Success,
        error = null;
  CRUDResult.failure(this.status, [this.error])
      : assert(status != CRUDStatus.Success),
        value = null;

  bool get isSuccess => status == CRUDStatus.Success;
  bool get isFailure => !isSuccess;
}

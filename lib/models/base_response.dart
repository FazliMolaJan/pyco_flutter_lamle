
class BaseResponse {
  bool error;
  dynamic data;
  List<BaseError> errors;

  BaseResponse({
    this.error,
    this.data,
    this.errors,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        error: json["error"],
        data: json["results"],
        errors: json["errors"] != null && (json["errors"] as List).length != 0
            ? List<BaseError>.from(
                json["errors"].map((x) => BaseError.fromJson(x)))
            : <BaseError>[],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "results": data,
        "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
      };
}

class BaseError {
  int code;
  String message;

  BaseError({
    this.code,
    this.message,
  });

  factory BaseError.fromJson(Map<String, dynamic> json) => BaseError(
        code: json["errorCode"],
        message: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "errorCode": code,
        "errorMessage": message,
      };
}
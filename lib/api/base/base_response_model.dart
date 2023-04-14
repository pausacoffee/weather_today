/// 일반적인 응답모델
class BaseResponseModel {
  int statusCode;
  dynamic headers;
  dynamic body;

  BaseResponseModel({
    required this.statusCode,
    this.headers,
    this.body,
  });

  factory BaseResponseModel.fromJson({
    required int statusCode,
    required dynamic headers,
    required dynamic body,
  }) {
    return BaseResponseModel(
      statusCode: statusCode,
      headers: headers,
      body: body,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'header': headers,
      'body': body,
    };
  }
}

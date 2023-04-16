class CommonModel {
  CommonModel({
    required this.errorMessage,
    required this.countPerPage,
    required this.totalCount,
    required this.errorCode,
    required this.currentPage,
  });

  String errorMessage;
  String countPerPage;
  String totalCount;
  String errorCode;
  String currentPage;

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
        errorMessage: json["errorMessage"],
        countPerPage: json["countPerPage"],
        totalCount: json["totalCount"],
        errorCode: json["errorCode"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "errorMessage": errorMessage,
        "countPerPage": countPerPage,
        "totalCount": totalCount,
        "errorCode": errorCode,
        "currentPage": currentPage,
      };
}

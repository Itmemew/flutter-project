class ModelApi {
  int? resultCode;
  String? resultDescription;

  ModelApi({
    this.resultCode,
    this.resultDescription,
  });

  factory ModelApi.fromJson(Map<String, dynamic> json) => ModelApi(
    resultCode: json["resultCode"],
    resultDescription: json["resultDescription"],
  );

  Map<String, dynamic> toJson() => {
    "resultCode": resultCode,
    "resultDescription": resultDescription,
  };
}


class BaseModel<T> {
  int? errorCode;
  String? errorMsg;
  T? data;

  BaseModel.fromJson(Map<String, dynamic> json) {
    errorCode = json["errorCode"];
    errorMsg = json["errorMsg"];
    data = json["data"];
  }
}

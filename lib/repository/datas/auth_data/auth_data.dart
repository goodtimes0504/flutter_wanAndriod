import 'data.dart';

class AuthData {
  Data? data;
  int? errorCode;
  String? errorMsg;

  AuthData({this.data, this.errorCode, this.errorMsg});

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        errorCode: json['errorCode'] as int?,
        errorMsg: json['errorMsg'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'errorCode': errorCode,
        'errorMsg': errorMsg,
      };
}

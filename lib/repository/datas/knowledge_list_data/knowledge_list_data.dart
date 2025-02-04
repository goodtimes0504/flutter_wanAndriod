import 'datum.dart';

class KnowledgeListData {
  List<Datum>? data;
  int? errorCode;
  String? errorMsg;

  KnowledgeListData({this.data, this.errorCode, this.errorMsg});

  factory KnowledgeListData.fromJson(Map<String, dynamic> json) {
    return KnowledgeListData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['errorCode'] as int?,
      errorMsg: json['errorMsg'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
        'errorCode': errorCode,
        'errorMsg': errorMsg,
      };
}

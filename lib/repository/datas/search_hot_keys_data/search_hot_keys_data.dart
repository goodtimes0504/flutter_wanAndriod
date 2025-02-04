import 'hot_key_item.dart';

class SearchHotKeysData {
  List<HotKeyItem>? data;
  int? errorCode;
  String? errorMsg;

  SearchHotKeysData({this.data, this.errorCode, this.errorMsg});

  factory SearchHotKeysData.fromJson(Map<String, dynamic> json) {
    return SearchHotKeysData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HotKeyItem.fromJson(e as Map<String, dynamic>))
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

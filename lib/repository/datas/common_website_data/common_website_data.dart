import 'common_website_item.dart';

class CommonWebsiteData {
  List<CommonWebsiteItem>? data;
  int? errorCode;
  String? errorMsg;

  CommonWebsiteData({this.data, this.errorCode, this.errorMsg});

  factory CommonWebsiteData.fromJson(Map<String, dynamic> json) {
    return CommonWebsiteData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CommonWebsiteItem.fromJson(e as Map<String, dynamic>))
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

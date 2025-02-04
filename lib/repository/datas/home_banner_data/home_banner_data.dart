// 导入datum.dart文件，该文件包含了Datum类的定义
import 'datum.dart';

/// 表示从服务器获取的首页轮播图数据的类。
///
/// 该类包含一个Datum对象列表，以及一个错误码和错误消息，用于表示请求的状态。
class HomeBannerData {
  // 首页轮播图数据列表
  List<Datum>? data;

  /// 构造函数，用于创建HomeBannerData对象。
  ///
  /// @param data 首页轮播图数据列表
  /// @param errorCode 错误码
  /// @param errorMsg 错误消息
  HomeBannerData({this.data});

  /// 工厂方法，用于从JSON数据创建HomeBannerData对象。
  ///
  /// @param json JSON数据
  /// @return HomeBannerData对象
  factory HomeBannerData.fromJson(Map<String, dynamic> json) {
    return HomeBannerData(
      data: (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// 将HomeBannerData对象转换为JSON数据。
  ///
  /// @return JSON数据
  Map<String, dynamic> toJson() => {
        // 将data字段转换为JSON数据
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'HomeBannerData(data: $data)';
  }
}

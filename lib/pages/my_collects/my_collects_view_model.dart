import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_11/repository/api.dart';

import '../../repository/datas/my_collects_model.dart';

// 我的收藏页面逻辑层
class MyCollectsViewModel with ChangeNotifier {
  List<MyCollectItemModel>? dataList = [];
  int _pageCount = 0;

  /// 获取我的收藏列表
  Future getMyCollects(bool loadMore) async {
    if (loadMore) {
      _pageCount++;
    } else {
      _pageCount = 0;
    }

    var list = await Api.instance.getMyCollects("$_pageCount");
    // 对于非加载更多，直接替换列表
    if (!loadMore) {
      dataList = list;
    } else {
      // 加载更多时，将旧数据和新数据合并为一个新的 List
      dataList = [...?dataList, ...?list];
    }
    // 如果加载更多时数据为空，则回退页码
    if (list == null || list.isEmpty) {
      if (loadMore && _pageCount > 0) {
        _pageCount--;
      }
    }
    notifyListeners();
  }

  ///取消收藏文章
  Future cancelCollect(int index, String? id) async {
    bool? success = await Api.instance.unCollectArticle(id ?? "");
    if (success != null && success == true) {
      try {
        dataList?.remove(dataList?[index]);
        notifyListeners();
      } catch (e) {
        log("cancelCollect error=$e");
      }
    }
  }
}

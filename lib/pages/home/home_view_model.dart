import 'package:flutter/material.dart';
import 'package:flutter_application_11/repository/Api.dart';
import 'package:flutter_application_11/repository/datas/home_banner_data/home_banner_data.dart';
import 'package:flutter_application_11/repository/datas/home_list_data/home_list_data.dart';

class HomeViewModel with ChangeNotifier {
  int pageCount = 0;
  HomeBannerData? bannerData;
  // HomeListData? listData;
  List<Datas> listData = [];

// 获取轮播图数据
  Future getBanner() async {
    try {
      bannerData = await Api.instance.getBanner();
      notifyListeners();
    } catch (e) {
      throw Exception('获取banner数据失败: $e');
    }
  }

// 获取首页列表数据
  Future getHomeList(bool isLoadMore) async {
    if (isLoadMore) {
      pageCount++;
    }
    try {
      var response = await Api.instance.getHomeList(pageCount.toString());
      if (isLoadMore) {
        listData.addAll(response.data.datas);
      } else {
        listData = response.data.datas;
      }
      notifyListeners();
    } catch (e) {
      throw Exception('获取列表数据失败: $e');
    }
  }

  // 收藏或者取消收藏文章
  Future<bool?> collectArticle(String id, int index) async {
    bool? success;
    // 获取当前收藏状态，null 时默认为 false
    bool currentCollect = listData[index].collect ?? false;

    if (currentCollect) {
      // 如果已经收藏，调用取消收藏接口
      success = await Api.instance.unCollectArticle(id);
    } else {
      // 如果未收藏，调用收藏接口
      success = await Api.instance.collectArticle(id);
    }

    // 判断 API 调用结果是否合法，这里假设 true 表示成功
    if (success != null && success == true) {
      // 更新本地数据
      listData[index].collect = !currentCollect;
      notifyListeners();
    }

    return success;
  }
}

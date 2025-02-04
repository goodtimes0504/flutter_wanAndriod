import 'package:flutter/material.dart';
import 'package:flutter_application_11/repository/Api.dart';
import 'package:flutter_application_11/repository/datas/common_website_data/common_website_data.dart';
import 'package:flutter_application_11/repository/datas/common_website_data/common_website_item.dart';
import 'package:flutter_application_11/repository/datas/search_hot_keys_data/hot_key_item.dart';
import 'package:flutter_application_11/repository/datas/search_hot_keys_data/search_hot_keys_data.dart';

class HotKeyViewModel extends ChangeNotifier {
  List<HotKeyItem> hotKeyList = [];
  List<CommonWebsiteItem> commonWebsiteList = [];

  Future<void> init() async {
    await getHotKey();
    await getCommonWebsite();
  }

  // 获取热门搜索数据
  Future<void> getHotKey() async {
    try {
      // 调用API获取热门搜索关键词数据
      SearchHotKeysData hotKeyData = await Api.instance.getHotKey();
      // 更新热门关键词列表,如果data为空则使用空列表
      hotKeyList = hotKeyData.data ?? [];
      // 通知监听器数据已更新
      notifyListeners();
    } catch (e) {
      // 错误处理
      print('获取热门搜索数据失败: $e');
      hotKeyList = [];
      notifyListeners();
    }
  }

  // 获取常用网站数据
  Future<void> getCommonWebsite() async {
    try {
      CommonWebsiteData commonWebsiteData =
          await Api.instance.getCommonWebsite();
      commonWebsiteList = commonWebsiteData.data ?? [];
      notifyListeners();
    } catch (e) {
      print('获取常用网站数据失败: $e');
      commonWebsiteList = [];
      notifyListeners();
    }
  }
}

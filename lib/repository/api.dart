import 'package:dio/dio.dart';
import 'package:flutter_application_11/repository/datas/auth_data/auth_data.dart';
import 'package:flutter_application_11/repository/datas/common_website_data/common_website_data.dart';
import 'package:flutter_application_11/repository/datas/home_banner_data/home_banner_data.dart';
import 'package:flutter_application_11/http/dio_instance.dart';
import 'package:flutter_application_11/repository/datas/home_list_data/home_list_data.dart';
import 'package:flutter_application_11/repository/datas/knowledge_list_data/knowledge_list_data.dart';
import 'package:flutter_application_11/repository/datas/search_hot_keys_data/search_hot_keys_data.dart';

class Api {
  static Api instance = Api._();
  Api._();
// 获取轮播图数据
  Future getBanner() async {
    try {
      Response response =
          await DioInstance.getInstance().get(path: "banner/json");
      HomeBannerData bannerData = HomeBannerData.fromJson(response.data);
      return bannerData;
    } catch (e) {
      throw Exception('获取banner数据失败: $e');
    }
  }

// 获取首页列表数据
  Future getHomeList(String pageCount) async {
    try {
      final response = await DioInstance.getInstance()
          .get(path: "article/list/$pageCount/json");

      HomeListData listData = HomeListData.fromJson(response.data);
      return listData;
    } catch (e) {
      throw Exception('获取列表数据错误: $e');
    }
  }

  // 获取热门搜索数据
  Future getHotKey() async {
    try {
      Response response =
          await DioInstance.getInstance().get(path: "hotkey/json");
      SearchHotKeysData hotKeyData = SearchHotKeysData.fromJson(response.data);
      return hotKeyData;
    } catch (e) {
      throw Exception('获取热门搜索数据错误: $e');
    }
  }

// 获取常用网站数据
  Future getCommonWebsite() async {
    try {
      Response response =
          await DioInstance.getInstance().get(path: "friend/json");
      CommonWebsiteData websiteData = CommonWebsiteData.fromJson(response.data);
      return websiteData;
    } catch (e) {
      throw Exception('获取常用网站数据错误: $e');
    }
  }

  // 注册
  Future register(
      {required String username,
      required String password,
      required String repassword}) async {
    Response response = await DioInstance.getInstance().post(
      path: "user/register",
      queryParameters: {
        "username": username,
        "password": password,
        "repassword": repassword,
      },
    );

    return response;
  }

  // 登录
  Future<AuthData> login(
      {required String username, required String password}) async {
    Response response = await DioInstance.getInstance().post(
      path: "user/login",
      queryParameters: {
        "username": username,
        "password": password,
      },
    );
    AuthData authData = AuthData.fromJson(response.data);
    return authData;
  }

  // 获取体系数据
  Future getKnowledgeList() async {
    Response response = await DioInstance.getInstance().get(path: "tree/json");
    KnowledgeListData knowledgeListData =
        KnowledgeListData.fromJson(response.data);
    return knowledgeListData.data;
  }

  // 收藏文章接口
  Future<bool?> collectArticle(String id) async {
    Response response =
        await DioInstance.getInstance().post(path: "lg/collect/$id/json");
    // print("收藏接口返回数据: ${response.data}");
    return response.data;
  }

  // 取消收藏文章接口
  Future<bool?> unCollectArticle(String id) async {
    Response response = await DioInstance.getInstance()
        .post(path: "lg/uncollect_originId/$id/json");
    return response.data;
  }

  // 退出登录
  Future logout() async {
    Response response =
        await DioInstance.getInstance().get(path: "user/logout/json");
    return response.data;
  }
}

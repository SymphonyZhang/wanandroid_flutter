import 'package:dio/dio.dart';
import 'package:wanandroid_flutter/repository/datas/auth_data.dart';
import 'package:wanandroid_flutter/repository/datas/common_website_data.dart';
import 'package:wanandroid_flutter/repository/datas/home_banner_data.dart';
import 'package:wanandroid_flutter/repository/datas/home_list_data.dart';
import 'package:wanandroid_flutter/repository/datas/knowledge_list_data.dart';
import 'package:wanandroid_flutter/repository/datas/search_hot_keys_data.dart';

import '../http/dio_instance.dart';
import 'datas/knowledge_detail_list_data.dart';

class Api {
  static Api? _instance;

  Api._();

  static Api get instance => _instance ??= Api._();

  /// 获取首页banner数据API
  Future<List<BannerItemData>?> getBanner() async {
    Response response = await DioInstance.instance.get(path: 'banner/json');
    HomeBannerListData bannerData = HomeBannerListData.fromJson(response.data);
    return bannerData.data;
  }

  /// 获取首页文章列表API
  Future<List<HomeListItemData>?> getHomeList(int page) async {
    Response response = await DioInstance.instance.get(path: 'article/list/$page/json');
    HomeListData homeData = HomeListData.fromJson(response.data);
    return homeData.datas;
  }

  /// 获取首页最受欢迎模块API - 问答列表 用于模仿置顶功能
  Future<List<HomeListItemData>?> getWendaList() async {
    Response response = await DioInstance.instance.get(path: 'popular/wenda/json');
    HomeWenDaListData wendaDatas = HomeWenDaListData.fromJson(response.data);
    return wendaDatas.wendaList;
  }

  /// 获取搜索热词API
  Future<List<SearchHotKeysData>?> getHotKeyList() async {
    Response response = await DioInstance.instance.get(path: 'hotkey/json');
    SearchHotKeysListData hotKeysListData = SearchHotKeysListData.fromJson(response.data);
    return hotKeysListData.hotKeyList;
  }

  /// 获取常用网站API
  Future<List<CommonWebsiteData>?> getWebsiteList() async {
    Response response = await DioInstance.instance.get(path: 'friend/json');
    CommonWebsiteDataList websiteListData = CommonWebsiteDataList.fromJson(response.data);
    return websiteListData.websiteList;
  }

  /// 注册API
  Future<bool> register({required String? username, required String? password, required String? rePassword}) async {
    Response response =
        await DioInstance.instance.post(path: 'user/register', params: {"username": username, "password": password, "repassword": rePassword});
    if (response.data is bool) {
      return response.data;
    }
    return response.data["username"] == username;
  }

  /// 登录API
  Future<AuthData> login({required String? username, required String? password}) async {
    Response response = await DioInstance.instance.post(path: 'user/login', params: {"username": username, "password": password});
    return AuthData.fromJson(response.data);
  }

  /// 获取体系数据API
  Future<List<KnowledgeListData>?> getKnowledge() async {
    Response response = await DioInstance.instance.get(path: 'tree/json');
    KnowledgeData knowledgeData = KnowledgeData.fromJson(response.data);
    return knowledgeData.list;
  }

  /// 收藏站内文章
  Future<bool?> collect(String? id) async {
    Response response = await DioInstance.instance.post(path: 'lg/collect/$id/json');
    return boolCallback(response.data);
  }

  /// 取消收藏文章
  Future<bool?> unCollect(String? id) async {
    Response response = await DioInstance.instance.post(path: 'lg/uncollect_originId/$id/json');
    return boolCallback(response.data);
  }

  /// 登出
  Future<bool> logout() async {
    Response response = await DioInstance.instance.get(path: 'user/logout/json');
    return boolCallback(response.data);
  }

  /// 获取知识体系文章
  Future<List<KnowledgeDetailData>?> getKnowledgeDetail(int page, String cid) async {
    //Response response = await DioInstance.instance.get(path: 'article/list/$page/json?cid=$cid');
    Response response = await DioInstance.instance.get(path: 'article/list/$page/json?', params: {"cid": cid});
    KnowledgeDetailListData knowledgeDetailListData = KnowledgeDetailListData.fromJson(response.data);
    return knowledgeDetailListData.datas;
  }

  bool boolCallback(dynamic data) {
    if (data != null && data is bool) {
      return data;
    }
    return false;
  }
}

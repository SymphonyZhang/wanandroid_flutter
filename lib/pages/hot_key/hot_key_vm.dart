import 'package:flutter/cupertino.dart';
import 'package:wanandroid_flutter/repository/api.dart';
import 'package:wanandroid_flutter/repository/datas/common_website_data.dart';
import 'package:wanandroid_flutter/repository/datas/search_hot_keys_data.dart';

class HotKeyViewModel with ChangeNotifier {
  List<SearchHotKeysData>? hotKeyList;
  List<CommonWebsiteData>? websiteList;

  // 统一获取数据并刷新界面
  Future initHotKeyPageData() async {
    getHotKeyList().then((value) {
      getWebsiteList().then((value) {
        notifyListeners();
      });
    });
  }

  // 获取搜索热词
  Future getHotKeyList() async {
    hotKeyList = await Api.instance.getHotKeyList();
  }

  // 获取常用网站
  Future getWebsiteList() async {
    websiteList = await Api.instance.getWebsiteList();
  }
}

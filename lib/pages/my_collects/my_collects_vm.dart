import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:wanandroid_flutter/repository/api.dart';
import 'package:wanandroid_flutter/repository/datas/my_collects_data.dart';

class MyCollectsViewModel with ChangeNotifier {

  List<MyCollectItemData> dataList = [];

  int _pageCount = 0;

  /// 初始化收藏列表
  Future initCollectsData() async {
    _pageCount = 0;
    await getCollectsDatas();
  }

  /// 下拉刷新
  Future refreshData() async {
    _pageCount = 0;
    await getCollectsDatas();
  }

  /// 上拉加载
  Future loadMoreData() async {
    await getCollectsDatas();
  }

  /// 根据文章[id]取消收藏文章
  Future cancelCollect(int index,String? id,String? originId) async {
    bool? collect =  await Api.instance.unCollectWithOriginId(id,originId ?? "-1");
    if(collect == true){
      try{
        dataList?.remove(dataList?[index]);
      }catch(e){
        log("cancelCollect error = $e");
      }

    }
    notifyListeners();
  }

  Future getCollectsDatas({bool loadMore = false}) async {
    if (loadMore) {
      _pageCount++;
    }else{
      _pageCount = 0;
      dataList.clear();
    }
    List<MyCollectItemData>? list = await Api.instance.getCollectsList(_pageCount);
    if(loadMore && list!.isEmpty){
      _pageCount--;
      return;
    }
    dataList.addAll(list ?? []);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/repository/api.dart';
import 'package:wanandroid_flutter/repository/datas/knowledge_detail_list_data.dart';
import 'package:wanandroid_flutter/repository/datas/knowledge_list_data.dart';

/// @Author          : Symphony
/// @Email           : 95200261@qq.com
/// @Date            : on 2024/12/25$ 0:16$.
/// @Description     : 描述
class KnowledgeDetailViewModel with ChangeNotifier {
  List<Tab> tabs = [];

  int _pageCount = 0;

  List<KnowledgeDetailItemData> knowledgeDetailItemList = [];


  void initTabs(List<KnowledgeChildren>? tabList) {
    tabList?.forEach((element) {
      tabs.add(Tab(text: element.name ?? ""));
    });
  }

  /// 初始化数据
  Future initDetailListData(String cid) async {
    _pageCount = 0;
    await getDetailList(cid);
  }

  /// 下拉刷新
  Future refreshDetailList(String cid) async {
    _pageCount = 0;
    await initDetailListData(cid);
  }

  /// 上拉加载更多
  Future loadMoreDetailList(String cid) async {
    await getDetailList(cid,loadMore: true);
  }

  /// 根据cid 获取体系详情列表
  Future getDetailList(String cid,{bool loadMore = false}) async {
    if(loadMore){
      _pageCount++;
    }else{
      _pageCount = 0;
      knowledgeDetailItemList.clear();
    }
    List<KnowledgeDetailItemData>? list =await Api.instance.getKnowledgeDetail(_pageCount, cid);
    if(loadMore && list!.isEmpty){
      _pageCount--;
      return;
    }
    knowledgeDetailItemList.addAll(list ?? []);
    notifyListeners();
  }
}

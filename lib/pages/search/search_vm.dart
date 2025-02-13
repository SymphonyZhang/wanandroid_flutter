import 'package:flutter/widgets.dart';
import 'package:wanandroid_flutter/repository/api.dart';
import 'package:wanandroid_flutter/repository/datas/search_data.dart';

class SearchViewModel with ChangeNotifier{

  List<SearchListDatas> searchListDatas = [];

  int _pageCount = 0;

  /// 初始化搜索 无关键字搜索
  Future initSearch(String? keyword) async{
    _pageCount = 0;
    await search(keyword);
  }

  /// 下拉刷新
  Future refreshSearchDatas(String? keyword ) async{
    _pageCount = 0;
    await search(keyword);
  }

  ///上拉加载更多
  Future loadMoreSearchDatas(String? keyword) async {
    await search(keyword,loadMore: true);
  }

  void searchClear(){
    searchListDatas.clear();
    notifyListeners();
  }

  /// 根据keword搜索数据
  Future search(String? keyword,{bool loadMore = false}) async {
    if(loadMore){
      _pageCount++;
    }else{
      _pageCount = 0;
      searchListDatas.clear();
    }
    List<SearchListDatas>? list = await Api.instance.searchWithKeyWord(_pageCount, keyword);
    if(loadMore && list!.isEmpty){
      _pageCount--;
      return;
    }
    searchListDatas.addAll(list ?? []);
    notifyListeners();
  }


}
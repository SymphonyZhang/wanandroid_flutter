import 'package:flutter/cupertino.dart';
import 'package:wanandroid_flutter/repository/api.dart';
import 'package:wanandroid_flutter/repository/datas/home_banner_data.dart';
import 'package:wanandroid_flutter/repository/datas/home_list_data.dart';

class HomeViewModel with ChangeNotifier {
  int pageCount = 0;
  List<BannerItemData>? bannerList;
  List<HomeListItemData>? homeListItemDatas = [];

  /// 获取banner数据
  Future getBanner() async {
    bannerList = await Api.instance.getBanner() ?? [];
    notifyListeners();
  }

  /// 初始化列表数据
  Future initListData() async {
    pageCount = 0;
    await getWendaList();
    await getHomeList();
  }

  /// 下拉刷新
  Future refreshDatas() async{
    pageCount =0;
    await getBanner();
    await initListData();

  }

  /// 上拉加载
  Future loadMoreDatas() async{
    await getHomeList(loadMore: true);
  }

  /// 获取文章列表
  Future getHomeList({bool loadMore = false}) async {
    if(loadMore){
      pageCount+=200;
    }else{
      pageCount=0;
    }
    List<HomeListItemData>? list= await Api.instance.getHomeList(pageCount);
    if(loadMore && list!.isEmpty){
      return;
    }
    homeListItemDatas?.addAll(list ?? []);
    notifyListeners();
  }

  /// 获取首页最受欢迎模块-问答 充当置顶数据
  Future getWendaList() async {
    //List<HomeListItemData>? list = await Api.instance.getWendaList();
    homeListItemDatas?.clear();
    //homeListItemDatas?.addAll(list ?? []);
    homeListItemDatas?.addAll(await Api.instance.getWendaList() ?? []);
  }

  /// 根据文章[id]收藏/取消收藏文章
  Future collect(String? id,int index) async {

    bool? collect;
    if(homeListItemDatas?[index].collect == true){
      collect =  await Api.instance.unCollect(id);
    }else{
      collect =  await Api.instance.collect(id);
    }
    if(collect == true) {
      homeListItemDatas?[index].collect = !(homeListItemDatas?[index].collect ?? false);
    }
    notifyListeners();
  }

  /// 根据文章[id]取消收藏文章
  Future unCollect(String? id,int index) async {
    bool? collect =  await Api.instance.unCollect(id);
    if(collect == true) {
      homeListItemDatas?[index].collect = false;
    }
    notifyListeners();
  }
}

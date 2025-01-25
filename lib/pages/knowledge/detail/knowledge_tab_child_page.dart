import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid_flutter/common_ui/common_widget.dart';
import 'package:wanandroid_flutter/common_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:wanandroid_flutter/pages/knowledge/detail/knowledge_detail_vm.dart';
import 'package:wanandroid_flutter/repository/datas/knowledge_detail_list_data.dart';

class KnowledgeTabChildPage extends StatefulWidget {
  const KnowledgeTabChildPage({super.key, required this.cid});

  final String cid;

  @override
  State<KnowledgeTabChildPage> createState() => _KnowledgeTabChildPageState();
}

class _KnowledgeTabChildPageState extends State<KnowledgeTabChildPage> {
  KnowledgeDetailViewModel viewModel = KnowledgeDetailViewModel();
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    viewModel.initDetailListData(widget.cid);
  }

  void _onLoading() async {
    viewModel.loadMoreDetailList(widget.cid).then((value) {
      _refreshController.loadComplete();
    });
  }

  void _onRefresh() async {
    viewModel.refreshDetailList(widget.cid).then((value) {
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: Consumer<KnowledgeDetailViewModel>(
          builder: (context, vm, child) {
            return SmartRefreshWidget(
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return _item(vm.knowledgeDetailItemList[index],onTap: (){
                      showToast(vm.knowledgeDetailItemList[index].shareUser ?? "I don't know");
                  });
                },
                itemCount: vm.knowledgeDetailItemList.length ?? 0,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _item(KnowledgeDetailItemData item ,{GestureTapCallback? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h,horizontal: 15.w),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(border: Border.all(color: Colors.black12,width: 0.5.r)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                normalText("${item.superChapterName}"),
                Text("${item.niceShareDate}")
              ],
            ),
            Text("${item.title}",style: titleTextStyle15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                normalText("${item.chapterName}"),
                Text("${item.shareUser}")
              ],
            ),
          ],
        ),
      ),
    );
  }
}

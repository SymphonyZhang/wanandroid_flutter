import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/pages/knowledge/detail/knowledge_detail_tab_page.dart';
import 'package:wanandroid_flutter/pages/knowledge/knowledge_vm.dart';
import 'package:wanandroid_flutter/route/route_utils.dart';

import '../../repository/datas/knowledge_list_data.dart';

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  KnowledgeViewModel viewModel = KnowledgeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getKnowledgeList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
            child: Consumer<KnowledgeViewModel>(builder: (context, vm, child) {
              return ListView.builder(
                itemCount: vm.knowledgeList?.length ?? 0,
                itemBuilder: (context, index) {
                  return _knowledgeItemView(vm.knowledgeList?[index]);
                },
              );
            })),
      ),
    );
  }

  Widget _knowledgeItemView(KnowledgeListData? item) {
    return GestureDetector(onTap:(){
      // 进入明细页面
      RouteUtils.push(context,KnowledgeDetailTabPage(tabList: item?.children,));
    },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(5.r),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?.name ?? "",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  Text(
                    viewModel.generalSubTitle(item?.children),
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),);
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/pages/knowledge/detail/knowledge_detail_vm.dart';
import 'package:wanandroid_flutter/pages/knowledge/detail/knowledge_tab_child_page.dart';
import 'package:wanandroid_flutter/repository/datas/knowledge_list_data.dart';

class KnowledgeDetailTabPage extends StatefulWidget {
  const KnowledgeDetailTabPage({super.key, this.tabList});

  final List<KnowledgeChildren>? tabList;

  @override
  State<KnowledgeDetailTabPage> createState() => _KnowledgeDetailTabPageState();
}

class _KnowledgeDetailTabPageState extends State<KnowledgeDetailTabPage> with SingleTickerProviderStateMixin {
  KnowledgeDetailViewModel viewModel = KnowledgeDetailViewModel();

  late TabController tabController;

  List<Widget> children(){
    return widget.tabList?.map((element){
      return KnowledgeTabChildPage();
    }).toList() ?? [];
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.tabList?.length ?? 0, vsync: this);
    viewModel.initTabs(widget.tabList);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: viewModel.tabs,
            controller: tabController,
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            isScrollable: true,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: tabController,
            children: children(),
          ),
        ),
      ),
    );
  }


}

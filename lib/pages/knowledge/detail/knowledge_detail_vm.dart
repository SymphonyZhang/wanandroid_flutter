import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/repository/datas/knowledge_list_data.dart';

/// @Author          : Symphony
/// @Email           : 95200261@qq.com
/// @Date            : on 2024/12/25$ 0:16$.
/// @Description     : 描述
class KnowledgeDetailViewModel with ChangeNotifier {
  List<Tab> tabs = [];

  void initTabs(List<KnowledgeChildren>? tabList) {
    tabList?.forEach((element) {
      tabs.add(Tab(text: element.name ?? ""));
    });
  }
}

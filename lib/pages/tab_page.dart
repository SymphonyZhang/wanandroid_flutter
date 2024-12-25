import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/common_ui/navigation/navigation_bar_widget.dart';
import 'package:wanandroid_flutter/pages/home/home_page.dart';
import 'package:wanandroid_flutter/pages/hot_key/hot_key_page.dart';
import 'package:wanandroid_flutter/pages/knowledge/knowledge_page.dart';
import 'package:wanandroid_flutter/pages/personal/personal_page.dart';
import 'package:wanandroid_flutter/resource/assets.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int currentIndex = 0;

  // 页面数组
  late List<Widget> pages;

  // label数组 底部导航标题
  late List<String> labels;

  // default icons 底部导航栏的默认图标数组 [非选中]
  late List<String> defaultIcons;

  // active icons 底部导航栏的选中图标数组 [选中]
  late List<String> activeIcons;

  void initTabData() {
    pages = [HomePage(), HotKeyPage(), KnowledgePage(), PersonalPage()];
    labels = ['首页', '热点', '体系', '我的'];
    defaultIcons = [R.imagesIconHomeGrey, R.imagesIconHotKeyGrey, R.imagesIconKnowledgeGrey, R.imagesIconPersonalGrey];
    activeIcons = [R.imagesIconHomeSelected, R.imagesIconHotKeySelected, R.imagesIconKnowledgeSelected, R.imagesIconPersonalSelected];
  }

  @override
  void initState() {
    super.initState();
    initTabData();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarWidget(
      currentIndex: currentIndex,
      pages: pages,
      labels: labels,
      defaultIcons: defaultIcons,
      activeIcons: activeIcons,
      onTapChange: (index){
        print("index ===================> $index");
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter/common_ui/navigation/navigation_bar_item.dart';

class NavigationBarWidget extends StatefulWidget {
  NavigationBarWidget({
    super.key,
    required this.pages,
    required this.labels,
    required this.defaultIcons,
    required this.activeIcons,
    this.currentIndex,
    this.onTapChange,
  }) {
    if (pages.length != labels.length || pages.length != defaultIcons.length || pages.length != activeIcons.length) {
      throw Exception("数组长度不一致!");
    }
  }

  // 页面数组
  final List<Widget> pages;

  // label数组 底部导航标题
  final List<String> labels;

  // default icons 底部导航栏的默认图标数组 [非选中]
  final List<String> defaultIcons;

  // active icons 底部导航栏的选中图标数组 [选中]
  final List<String> activeIcons;

  // tab 触发事件
  final ValueChanged<int>? onTapChange;

  int? currentIndex;

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: widget.currentIndex ?? 0,
          children: widget.pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex ?? 0,
        items: _barItemList(),
        onTap: (index) {
          //点击切换页面
          widget.currentIndex = index;
          widget.onTapChange?.call(index);
          setState(() {});
        },
        selectedLabelStyle: TextStyle(fontSize: 13.sp, color: Colors.black),
        unselectedLabelStyle: TextStyle(fontSize: 10.sp, color: Colors.grey),
      ),
    );
  }

  List<BottomNavigationBarItem> _barItemList() {
    List<BottomNavigationBarItem> items = [];
    for (int i = 0; i < widget.labels.length; i++) {
      items.add(
        BottomNavigationBarItem(
            icon: Image.asset(
              widget.defaultIcons[i],
              width: 32.r,
              height: 32.r,
            ),
            label: widget.labels[i],
            activeIcon: NavigationBarItem(builder: (context) {
              return Image.asset(
                widget.activeIcons[i],
                width: 32.r,
                height: 32.r,
              );
            })),
      );
    }
    return items;
  }
}

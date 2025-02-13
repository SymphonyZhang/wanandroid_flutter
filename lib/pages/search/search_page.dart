import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/pages/search/search_vm.dart';
import 'package:wanandroid_flutter/resource/assets.dart';
import 'package:wanandroid_flutter/route/route_utils.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.keyword});

  final String? keyword;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController inputController;
  SearchViewModel viewModel = SearchViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputController = TextEditingController(text: widget.keyword ?? '');
    viewModel.initSearch(widget.keyword);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _searchBar(
                onBack: () {
                  RouteUtils.pop(context);
                },
                onCancel: () {
                  //showToast("Cancel ！！！！");
                  inputController.text = "";
                  viewModel.searchClear();
                  // 隐藏软键盘第二种方式:
                  FocusScope.of(context).unfocus();
                },
                onSubmitted: (value) {
                  //showToast("Go Go object onSubmitted $value");
                  viewModel.search(value);
                  // 隐藏软键盘第一种方式:
                  //SystemChannels.textInput.invokeMethod("TextInput.hide");
                  // 隐藏软键盘第二种方式:
                  FocusScope.of(context).unfocus();
                },
              ),
              Consumer<SearchViewModel>(
                builder: (context, vm, child) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return _listItem(
                            vm.searchListDatas[index].title ?? "", () {});
                      },
                      itemCount: vm.searchListDatas.length ?? 0,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listItem(String? title, GestureTapCallback onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1.r, color: Colors.black12))),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Html(
            data: title ?? '',
            style: {
              'html':Style(fontSize: FontSize(15.sp))
            },
          ),
        ));
  }

  Widget _searchBar(
      {GestureTapCallback? onBack,
      GestureTapCallback? onCancel,
      ValueChanged<String>? onSubmitted}) {
    return Container(
      color: Colors.teal,
      height: 50.h,
      width: double.infinity,
      padding: EdgeInsets.only(left: 5.w, right: 15.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: Image.asset(R.imagesIconBack, width: 35.r, height: 35.r),
          ),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(6.r),
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: onSubmitted,
              keyboardType: TextInputType.text,
              controller: inputController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.only(left: 10.w),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
              ),
            ),
          )),
          SizedBox(
            width: 5.w,
          ),
          GestureDetector(
            onTap: onCancel,
            child: Text(
              '取消',
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
            ),
          )
        ],
      ),
    );
  }
}

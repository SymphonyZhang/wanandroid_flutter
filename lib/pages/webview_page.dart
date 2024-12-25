import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebViewPage extends StatefulWidget {
  final String? title;
  final String? url;

  const WebViewPage({super.key, this.title,this.url});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)?.settings.arguments;
    var name= "";
    if(map is Map){
      name = map["name"];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SafeArea(
          child: Container(
            child: InkWell(onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                width: 200.w,
                height: 50.h,
                child: Text("Back"),
              ),
            ),
      )),
    );
  }
}

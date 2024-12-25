import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonInputFieldWidget extends StatefulWidget {
  const CommonInputFieldWidget({super.key, this.labelText, this.controller, this.onChanged});

  final String? labelText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  State<CommonInputFieldWidget> createState() => _CommonInputFieldWidgetState();
}

class _CommonInputFieldWidgetState extends State<CommonInputFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      maxLines: 1,
      cursorColor: Colors.white,
      decoration: InputDecoration(
          labelText: widget.labelText ?? "请输入",
          labelStyle: TextStyle(color: Colors.white),
          // 为获取焦点前
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.w),
          ),
          // 获取焦点后
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.5.w),
          ),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: _obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility))),
    );
  }
}

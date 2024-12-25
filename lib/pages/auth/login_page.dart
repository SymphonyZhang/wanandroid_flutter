import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/common_ui/common_input_widget.dart';
import 'package:wanandroid_flutter/common_ui/common_widget.dart';
import 'package:wanandroid_flutter/pages/auth/auth_vm.dart';
import 'package:wanandroid_flutter/pages/auth/register_page.dart';
import 'package:wanandroid_flutter/pages/tab_page.dart';
import 'package:wanandroid_flutter/route/route_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthViewModel viewModel = AuthViewModel();
  TextEditingController? nameInputController;
  TextEditingController? passwordInputController;

  @override
  void initState() {
    super.initState();
    nameInputController = TextEditingController();
    passwordInputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                commonInputTextField(labelText: "输入账号", controller: nameInputController),
                SizedBox(height: 20.h),
                CommonInputFieldWidget(
                  labelText: "输入密码",
                  controller: passwordInputController,
                ),
                SizedBox(height: 50.h),
                commonRadiusButton(text: '登录', onTap: () {
                  viewModel.setLoginInfo(username: nameInputController?.text ?? "",password: passwordInputController?.text ?? "");
                  viewModel.login().then((value){
                    if(value){
                      showToast("登录成功!");
                      RouteUtils.pushAndRemoveUntil(context, TabPage());
                    }
                  });
                }),
                SizedBox(height: 5.h),
                _registerButton(
                    label: '注册',
                    onTap: () {
                      RouteUtils.push(context, RegisterPage());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerButton({required String label, GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 100.w,
        height: 45.h,
        child: Text(
          label,
          style: TextStyle(color: Colors.greenAccent, fontSize: 14.sp, decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}

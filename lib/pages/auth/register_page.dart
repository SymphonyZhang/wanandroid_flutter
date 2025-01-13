import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/common_ui/common_input_widget.dart';
import 'package:wanandroid_flutter/common_ui/common_widget.dart';
import 'package:wanandroid_flutter/pages/auth/auth_vm.dart';
import 'package:wanandroid_flutter/route/route_utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthViewModel viewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        backgroundColor: Colors.teal[400],
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            alignment: Alignment.center,
            child: Consumer<AuthViewModel>(
              builder: (context, vm, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    commonInputTextField(labelText: "输入账号", onChanged: (value) {
                      vm.registerInfo.name =value;
                    }),
                    SizedBox(
                      height: 20.h,
                    ),
                    CommonInputFieldWidget(labelText: "输入密码", onChanged: (value) {
                      vm.registerInfo.password = value;
                    }),
                    SizedBox(
                      height: 20.h,
                    ),
                    CommonInputFieldWidget(labelText: "再次输入密码", onChanged: (value) {
                      vm.registerInfo.rePassword = value;
                    }),


                    SizedBox(
                      height: 50.h,
                    ),
                    commonRadiusButton(
                        text: '点我注册',
                        onTap: () {
                          vm.register().then((value){
                            if(value){
                              showToast("注册成功");
                              RouteUtils.pop(context);
                            }
                          });
                        }),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wanandroid_flutter/constants.dart';
import 'package:wanandroid_flutter/repository/api.dart';
import 'package:wanandroid_flutter/repository/datas/auth_data.dart';
import 'package:wanandroid_flutter/utils/sp_utils.dart';

class AuthViewModel with ChangeNotifier {
  RegisterInfo registerInfo = RegisterInfo();
  LoginInfo loginInfo = LoginInfo();

  /// 注册
  Future<bool> register() async {
    if (registerInfo.name == null || registerInfo.name?.isEmpty == true) {
      showToast("用户名不能为空");
      return false;
    }

    if (registerInfo.password == null || registerInfo.password?.isEmpty == true) {
      showToast("密码不能为空");
      return false;
    } else if (registerInfo.password!.length < 6) {
      showToast("密码长度不能小于6");
      return false;
    }

    if (registerInfo.rePassword == null || registerInfo.rePassword?.isEmpty == true) {
      showToast("确认密码不能为空");
      return false;
    }

    if (registerInfo.password != registerInfo.rePassword) {
      showToast("密码与确认密码必须一致");
      return false;
    }
    return await Api.instance.register(username: registerInfo.name, password: registerInfo.password, rePassword: registerInfo.rePassword);
  }

  /// 登录
  Future<bool> login() async {
    if (loginInfo.name == null || loginInfo.name?.isEmpty == true) {
      showToast("用户名不能为空");
      return false;
    }

    if (loginInfo.password == null || loginInfo.password?.isEmpty == true) {
      showToast("密码不能为空");
      return false;
    }

    AuthData data = await Api.instance.login(username: loginInfo.name, password: loginInfo.password);
    if(data.username != null && data.username?.isNotEmpty == true) {
      if(data.username == loginInfo.name) {
        SpUtils.saveString(Constants.SP_USER_NAME, data.username ?? "");
        return true;
      }
      return false;
    }else{
      return false;
    }
  }

  void setLoginInfo({String? username, String? password}) {
    if (username != null) {
      loginInfo.name = username;
    }
    if (password != null) {
      loginInfo.password = password;
    }
  }
}

class RegisterInfo {
  String? name;
  String? password;
  String? rePassword;
}

class LoginInfo {
  String? name;
  String? password;
}

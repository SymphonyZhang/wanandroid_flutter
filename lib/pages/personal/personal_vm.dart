import 'package:flutter/cupertino.dart';
import 'package:wanandroid_flutter/constants.dart';
import 'package:wanandroid_flutter/repository/api.dart';
import 'package:wanandroid_flutter/utils/sp_utils.dart';

/// @Author          : Symphony
/// @Email           : 95200261@qq.com
/// @Date            : on 2024/12/24$ 16:49$.
/// @Description     : 描述
class PersonalViewModel with ChangeNotifier{
  String? username;
  bool shouldLogin = true;

  Future initData() async {
    SpUtils.getString(Constants.SP_USER_NAME).then((value){
      if(value == null || value==""){
        username = "未登录";
        shouldLogin= true;
      }else {
        username = value;
        shouldLogin =false;
      }
      notifyListeners();
    });
  }
  
  Future logout(ValueChanged<bool> callback) async {
    bool success = await Api.instance.logout();
    if(success){
      await SpUtils.removeAll();
      callback.call(true);
    }else{
      callback.call(false);
    }
  }
}
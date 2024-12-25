import 'package:shared_preferences/shared_preferences.dart';

/// 本地持久化存储工具类
class SpUtils {
  /// 构造方法私有化
  SpUtils._();

  /// 根据[key]保存类型为`List<String>` 的数据
  static Future<bool> saveStringList(String key,List<String> values) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setStringList(key,values);
  }

  /// 根据[key]获取类型为`List<String>?` 的数据
  static Future<List<String>?> getStringList(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getStringList(key);
  }

  /// 根据[key]保存类型为`bool` 的数据
  static Future<bool> saveBool(String key,bool value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setBool(key,value);
  }

  /// 根据[key]获取类型为`bool?` 的数据
  static Future<bool?> getBool(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
  }

  /// 根据[key]保存类型为`int` 的数据
  static Future<bool> saveInt(String key,int value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setInt(key,value);
  }

  /// 根据[key]获取类型为`int?` 的数据
  static Future<int?> getInt(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
  }

  /// 根据[key]保存类型为`String` 的数据
  static Future saveString(String key,String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(key,value);
  }

  /// 根据[key]保存类型为`double` 的数据
  static Future saveDouble(String key,double value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setDouble(key,value);
  }

  /// 根据[key]保存类型为`List<String>` 的数据
  static Future saveList(String key,List<String> value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setStringList(key,value);
  }

  /// 根据[key]获取类型为`dynamic`动态类型 的数据
  static Future getDynamic(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key);
  }

  /// 根据[key]获取`String`类型数据
  static Future getString(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  /// 根据[key]获取`double`类型数据
  static Future getDouble(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key);
  }

  /// 根据[key]获取`List<String>?`类型数据
  static Future getList(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(key);
  }

  /// 根据[key]删除数据
  static Future<bool> remove(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }

  /// 清除所有数据
  static Future<bool> removeAll() async {
    final sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
}
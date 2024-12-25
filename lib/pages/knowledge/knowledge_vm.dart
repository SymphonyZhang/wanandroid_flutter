import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/repository/api.dart';
import 'package:wanandroid_flutter/repository/datas/knowledge_list_data.dart';

/// @Author          : Symphony
/// @Email           : 95200261@qq.com
/// @Date            : on 2024/12/23$ 23:18$.
/// @Description     : 描述
class KnowledgeViewModel with ChangeNotifier{

  List<KnowledgeListData>? knowledgeList;

  Future getKnowledgeList() async{
    knowledgeList = await Api.instance.getKnowledge();
    notifyListeners();
  }

  String generalSubTitle(List<KnowledgeChildren>? children){
    if(children == null || children.isEmpty == true){
      return "";
    }
    StringBuffer stringBuffer = StringBuffer("");
    for (var element in children) {
      stringBuffer.write("${element.name}    ");
    }
    return stringBuffer.toString();
  }
}
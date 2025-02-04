import 'package:flutter/material.dart';
import 'package:flutter_application_11/repository/Api.dart';
import 'package:flutter_application_11/repository/datas/knowledge_list_data/datum.dart';

class KnowledgeViewModel extends ChangeNotifier {
  List<Datum> knowledgeList = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // 添加一个方法来拼接 children 名字字符串
  String getConcatenatedChildren(Datum item) {
    return item.children?.map((child) => child.name).join(' ') ?? '';
  }

  Future<void> getKnowledgeList() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await Api.instance.getKnowledgeList();
      if (result != null) {
        knowledgeList = result;
      }
    } catch (e) {
      // 错误处理
      knowledgeList = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

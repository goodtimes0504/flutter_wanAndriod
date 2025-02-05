import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_11/repository/Api.dart';
import 'package:flutter_application_11/repository/datas/knowledge_detail_list_data/knowledge_detail_list.dart'
    as detail;
import 'package:flutter_application_11/repository/datas/knowledge_list_data/child.dart';

class KnowledgeDetailViewModel extends ChangeNotifier {
  List<Tab> tabs = [];
  List<detail.Datas> datas = [];
  int _pageCount = 0;
  void initTabs(List<Child> tabList) {
    for (var e in tabList) {
      tabs.add(Tab(text: e.name ?? ""));
    }
  }

  Future getKnowledgeDetailList(String id, bool loadMore) async {
    if (loadMore) {
      _pageCount++;
    } else {
      _pageCount = 0;
      datas.clear();
    }
    List<detail.Datas> list =
        await Api.instance.getKnowledgeDetailList(id, _pageCount.toString());
    if (list.isNotEmpty) {
      datas.addAll(list);
      notifyListeners();
    } else {
      if (loadMore && _pageCount > 0) {
        _pageCount--;
      }
    }
  }
}

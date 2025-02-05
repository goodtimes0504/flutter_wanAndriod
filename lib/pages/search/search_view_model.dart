import 'package:flutter/material.dart';
import 'package:flutter_application_11/repository/api.dart';
import 'package:flutter_application_11/repository/datas/search_data/search_data.dart';

class SearchViewModel extends ChangeNotifier {
  List<Datas>? searchData;

  Future getSearchData(String keyword) async {
    searchData = await Api.instance.getSearchData(keyword);
    notifyListeners();
  }

  void clear() {
    searchData?.clear();
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_11/constants.dart';
import 'package:flutter_application_11/repository/Api.dart';
import 'package:flutter_application_11/utils/sp_utils.dart';

class PersonViewModel extends ChangeNotifier {
  String? userName;
  bool isLogin = false;
  Future initData() async {
    userName = await SpUtils.getString(Constants.SP_User_Name);
    if (userName == null || userName == "") {
      userName = "未登录";
      isLogin = false;
    } else {
      isLogin = true;
    }
    notifyListeners();
  }

  Future logout(ValueChanged<bool> callBack) async {
    bool? success = await Api.instance.logout();
    if (success == true) {
      SpUtils.removeAll();
      isLogin = false;
      notifyListeners();
      callBack(true);
    } else {
      callBack(false);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_11/constants.dart';
import 'package:flutter_application_11/repository/Api.dart';
import 'package:flutter_application_11/repository/datas/auth_data/auth_data.dart';
import 'package:flutter_application_11/utils/sp_utils.dart';
import 'package:oktoast/oktoast.dart';

class AuthViewModel extends ChangeNotifier {
  RegisterInfo registerInfo = RegisterInfo();
  LoginInfo loginInfo = LoginInfo();

  // 添加加载状态变量
  bool _isLoading = false;
  bool get isLoading => _isLoading;
// 注册
  Future<void> register() async {
    if (registerInfo.username == null ||
        registerInfo.password == null ||
        registerInfo.repassword == null) {
      showToast('请输入完整信息');
      return;
    }
    if (registerInfo.password != registerInfo.repassword) {
      showToast('两次密码不一致');
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await Api.instance.register(
        username: registerInfo.username!,
        password: registerInfo.password!,
        repassword: registerInfo.repassword!,
      );
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 登录
  Future<bool?> login() async {
    if (loginInfo.username == null || loginInfo.password == null) {
      showToast('请输入完整信息');
      return false;
    }
    _isLoading = true;
    notifyListeners();
    try {
      AuthData authData = await Api.instance.login(
        username: loginInfo.username!,
        password: loginInfo.password!,
      );
      if (authData.data?.username == null) {
        showToast('登录失败，请重新登录');
        return false;
      }
      // 保存用户名
      SpUtils.saveString(Constants.SP_User_Name, authData.data!.username!);
      return true;
    } catch (e) {
      // 使用 rethrow 来保留原始异常信息
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setLoginInfo({String? username, String? password}) {
    loginInfo.username = username;
    loginInfo.password = password;
  }
}

class RegisterInfo {
  String? username;
  String? password;
  String? repassword;
}

class LoginInfo {
  String? username;
  String? password;
}

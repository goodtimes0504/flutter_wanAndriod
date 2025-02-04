import 'package:flutter/material.dart';
import 'package:flutter_application_11/common_ui/common_style.dart';
import 'package:flutter_application_11/pages/auth/auth_view_model.dart';
import 'package:flutter_application_11/pages/auth/register_page.dart';
import 'package:flutter_application_11/pages/tab_page.dart';
import 'package:flutter_application_11/route/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthViewModel authViewModel = AuthViewModel();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => authViewModel,
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              commonInput(
                labelText: '请输入账号',
                controller: usernameController,
              ),
              SizedBox(height: 10.h),
              commonInput(
                labelText: '请输入密码',
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 50.h),
              whiteBorderButton(
                text: '登录',
                onTap: () async {
                  authViewModel.setLoginInfo(
                      username: usernameController.text,
                      password: passwordController.text);
                  var result = await authViewModel.login();
                  if (result == true) {
                    if (mounted) {
                      showToast('登录成功');
                      RouteUtils.pushAndRemoveUntil(context, TabPage());
                    }
                  }
                },
              ),
              SizedBox(height: 10.h),
              // 注册
              whiteBorderButton(
                  text: '注册',
                  onTap: () {
                    RouteUtils.push(context, RegisterPage());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

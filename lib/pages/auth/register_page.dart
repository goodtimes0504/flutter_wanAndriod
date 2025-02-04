import 'package:flutter/material.dart';
import 'package:flutter_application_11/common_ui/common_style.dart';
import 'package:flutter_application_11/pages/auth/auth_view_model.dart';
import 'package:flutter_application_11/route/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthViewModel authViewModel = AuthViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => authViewModel,
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Consumer<AuthViewModel>(
            builder: (context, authViewModel, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  commonInput(
                    labelText: '请输入账号',
                    onChanged: (value) {
                      authViewModel.registerInfo.username = value;
                    },
                  ),
                  SizedBox(height: 10.h),
                  commonInput(
                    labelText: '请输入密码',
                    onChanged: (value) {
                      authViewModel.registerInfo.password = value;
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 10.h),
                  commonInput(
                    labelText: '请再次输入密码',
                    onChanged: (value) {
                      authViewModel.registerInfo.repassword = value;
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 50.h),
                  authViewModel.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : whiteBorderButton(
                          text: '注册',
                          onTap: () async {
                            await authViewModel.register();
                            if (!mounted) return;
                            showToast('注册成功');
                            // ignore: use_build_context_synchronously
                            RouteUtils.pop(context);
                          },
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

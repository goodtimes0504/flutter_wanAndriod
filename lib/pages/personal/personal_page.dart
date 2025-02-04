import 'package:flutter/material.dart';
import 'package:flutter_application_11/pages/auth/login_page.dart';
import 'package:flutter_application_11/pages/personal/person_view_model.dart';
import 'package:flutter_application_11/route/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  PersonViewModel personViewModel = PersonViewModel();
  @override
  void initState() {
    super.initState();
    personViewModel.initData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => personViewModel,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _header(),
              _settingsItem('我的收藏', () {}),
              _settingsItem('检查更新', () {}),
              _settingsItem('关于我们', () {}),
              Consumer<PersonViewModel>(
                  builder: (context, personViewModel, child) {
                if (!personViewModel.isLogin) {
                  return SizedBox.shrink();
                }
                return _settingsItem('退出登录', () {
                  personViewModel.logout((success) {
                    if (success) {
                      RouteUtils.pushAndRemoveUntil(context, LoginPage());
                    } else {
                      showToast('退出登录失败');
                    }
                  });
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingsItem(String? title, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.r),
        width: double.infinity,
        height: 45.r,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title ?? ''),
            Image.asset('assets/images/img_arrow_right.png',
                height: 20.r, width: 20.r),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      color: Colors.teal,
      height: 200.r,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40.r),
            child: Image.asset('assets/images/logo.png',
                height: 80.r, width: 80.r),
          ),
          SizedBox(height: 6.r),
          Consumer<PersonViewModel>(builder: (context, personViewModel, child) {
            return GestureDetector(
              onTap: () {
                if (!personViewModel.isLogin) {
                  RouteUtils.push(context, LoginPage());
                }
              },
              child: Text(
                  personViewModel.isLogin
                      ? personViewModel.userName ?? ''
                      : '未登录',
                  style: TextStyle(fontSize: 13.sp, color: Colors.white)),
            );
          }),
        ],
      ),
    );
  }
}

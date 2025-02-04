import 'package:flutter/material.dart';
import 'package:flutter_application_11/common_ui/navigation/navigation_bar_widget.dart';
import 'package:flutter_application_11/pages/home/home_page.dart';
import 'package:flutter_application_11/pages/hot_key/hot_key_page.dart';
import 'package:flutter_application_11/pages/knowledge/knowledge_page.dart';
import 'package:flutter_application_11/pages/personal/personal_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int currentIndex = 0;
  // 页面数组
  late List<Widget> pages;
  // 底部镖旗
  late List<String> labels;
  // 导航栏的icon数组:切换前
  late List<Widget> icons;
  // 导航栏的icon数组:切换后
  late List<Widget> activeIcons;

  void initTabData() {
    pages = [
      const HomePage(),
      const HotKeyPage(),
      const KnowledgePage(),
      const PersonalPage(),
    ];
    labels = ['首页', '热点', '知识', '我的'];
    icons = [
      Image.asset('assets/images/icon_home_grey.png',
          width: 32.r, height: 32.r),
      Image.asset('assets/images/icon_hot_key_grey.png',
          width: 32.r, height: 32.r),
      Image.asset('assets/images/icon_knowledge_grey.png',
          width: 32.r, height: 32.r),
      Image.asset('assets/images/icon_personal_grey.png',
          width: 32.r, height: 32.r),
    ];
    activeIcons = [
      Image.asset('assets/images/icon_home_selected.png',
          width: 32.r, height: 32.r),
      Image.asset('assets/images/icon_hot_key_selected.png',
          width: 32.r, height: 32.r),
      Image.asset('assets/images/icon_knowledge_selected.png',
          width: 32.r, height: 32.r),
      Image.asset('assets/images/icon_personal_selected.png',
          width: 32.r, height: 32.r),
    ];
  }

  @override
  void initState() {
    super.initState();
    initTabData();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarWidget(
      pages: pages,
      labels: labels,
      icons: icons,
      activeIcons: activeIcons,
      onTapChange: (index) {
        print('index: $index');
      },
    );
  }
}

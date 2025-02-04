import 'package:flutter/material.dart';
import 'package:flutter_application_11/common_ui/navigation/navigation_bar_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget(
      {super.key,
      required this.pages,
      required this.labels,
      required this.icons,
      required this.activeIcons,
      this.onTapChange,
      this.initialIndex = 0});
  // 页面数组
  final List<Widget> pages;
  // 底部镖旗
  final List<String> labels;
  // 导航栏的icon数组:切换前
  final List<Widget> icons;
  // 导航栏的icon数组:切换后
  final List<Widget> activeIcons;
  // 切换页面的回调
  final ValueChanged<int>? onTapChange;
  // 当前选中的index
  final int initialIndex;

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: currentIndex, children: widget.pages),
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(fontSize: 14.sp),
            unselectedLabelStyle: TextStyle(fontSize: 14.sp),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: _barItemList(),
            currentIndex: currentIndex,
            onTap: (index) {
              widget.onTapChange?.call(index);
              setState(() {
                currentIndex = index;
              });
            },
          )),
    );
  }

  List<BottomNavigationBarItem> _barItemList() {
    List<BottomNavigationBarItem> barItemList = [];
    for (int i = 0; i < widget.labels.length; i++) {
      barItemList.add(BottomNavigationBarItem(
        icon: widget.icons[i],
        activeIcon:
            NavigationBarItem(builder: (context) => widget.activeIcons[i]),
        label: widget.labels[i],
      ));
    }
    return barItemList;
  }
}

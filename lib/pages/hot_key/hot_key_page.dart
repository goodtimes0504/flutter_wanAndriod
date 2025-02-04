import 'package:flutter/material.dart';
import 'package:flutter_application_11/pages/hot_key/hot_key_view_model.dart';
import 'package:flutter_application_11/pages/web_view_page.dart';
import 'package:flutter_application_11/route/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});

  @override
  State<HotKeyPage> createState() => _HotKeyPageState();
}

class _HotKeyPageState extends State<HotKeyPage> {
  final HotKeyViewModel hotKeyViewModel = HotKeyViewModel();

  @override
  void initState() {
    super.initState();
    hotKeyViewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => hotKeyViewModel,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: 10.r,
                    right: 10.r,
                    top: 10.r,
                    bottom: 10.r,
                  ),
                  padding: EdgeInsets.only(left: 10.r, right: 10.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '热门搜索',
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      ),
                      Image.asset(
                        "assets/images/icon_search.png",
                        width: 30.r,
                        height: 30.r,
                      ),
                    ],
                  ),
                ),
                // 热门搜索列表
                Container(
                  // 移除固定高度
                  padding: EdgeInsets.only(
                      left: 10.r, right: 10.r, top: 10.r, bottom: 10.r),
                  child: GridView.builder(
                    // 启用收缩包裹
                    shrinkWrap: true,
                    // 禁用滚动
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 120.w,
                      mainAxisSpacing: 10.r,
                      crossAxisSpacing: 10.r,
                      mainAxisExtent: 40.r,
                    ),
                    itemCount: hotKeyViewModel.hotKeyList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        // 添加边框和圆角
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        // 添加内边距
                        padding: EdgeInsets.symmetric(horizontal: 8.r),
                        // 居中对齐
                        alignment: Alignment.center,
                        child: Text(
                          hotKeyViewModel.hotKeyList[index].name ?? '',
                          style: TextStyle(fontSize: 12.sp),
                          // 文本溢出处理
                          overflow: TextOverflow.ellipsis, // 超出部分显示省略号
                          maxLines: 1, // 限制为单行
                          textAlign: TextAlign.center, // 文本居中对齐
                        ),
                      );
                    },
                  ),
                ),
                Divider(
                  height: 10.r,
                  color: Colors.grey,
                ),
                Container(
                  height: 25,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: 10.r,
                    right: 10.r,
                    top: 10.r,
                    bottom: 10.r,
                  ),
                  child: Text('常用网站'),
                ),
                Divider(
                  height: 10.r,
                  color: Colors.grey,
                ),
                // 常用网站列表
                Consumer<HotKeyViewModel>(
                  builder: (context, hotKeyViewModel, child) {
                    return Container(
                      // 移除固定高度
                      padding: EdgeInsets.only(
                          left: 10.r, right: 10.r, top: 10.r, bottom: 10.r),
                      child: GridView.builder(
                        // 启用收缩包裹，让高度自适应内容
                        shrinkWrap: true,
                        // 禁用GridView自身的滚动
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 120.w,
                          mainAxisSpacing: 10.r,
                          crossAxisSpacing: 10.r,
                          mainAxisExtent: 40.r,
                        ),
                        itemCount: hotKeyViewModel.commonWebsiteList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              // 点击事件
                              print(
                                  '点击了 ${hotKeyViewModel.commonWebsiteList[index].name}');
                              RouteUtils.push(
                                context,
                                WebViewPage(
                                    title: hotKeyViewModel
                                        .commonWebsiteList[index].name,
                                    url: hotKeyViewModel
                                        .commonWebsiteList[index].link),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8.r),
                              alignment: Alignment.center,
                              child: Text(
                                hotKeyViewModel.commonWebsiteList[index].name ??
                                    '',
                                style: TextStyle(fontSize: 12.sp),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

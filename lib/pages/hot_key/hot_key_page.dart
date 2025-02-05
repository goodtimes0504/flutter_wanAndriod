import 'package:flutter/material.dart';
import 'package:flutter_application_11/common_ui/web/webview_page.dart';
import 'package:flutter_application_11/common_ui/web/webview_widget.dart';
import 'package:flutter_application_11/pages/hot_key/hot_key_view_model.dart';
import 'package:flutter_application_11/pages/search/search_page.dart';
import 'package:flutter_application_11/route/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});

  @override
  State<HotKeyPage> createState() => _HotKeyPageState();
}

class _HotKeyPageState extends State<HotKeyPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HotKeyViewModel>(
      create: (context) {
        final hotKeyViewModel = HotKeyViewModel();
        hotKeyViewModel.init();
        return hotKeyViewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: Consumer<HotKeyViewModel>(
            builder: (context, hotKeyViewModel, child) {
              return SingleChildScrollView(
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
                      child: GestureDetector(
                        onTap: () {
                          RouteUtils.push(context, SearchPage());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '热门搜索',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.black),
                            ),
                            Image.asset(
                              "assets/images/icon_search.png",
                              width: 30.r,
                              height: 30.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 热门搜索列表
                    Container(
                      padding: EdgeInsets.only(
                          left: 10.r, right: 10.r, top: 10.r, bottom: 10.r),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 120.w,
                          mainAxisSpacing: 10.r,
                          crossAxisSpacing: 10.r,
                          mainAxisExtent: 40.r,
                        ),
                        itemCount: hotKeyViewModel.hotKeyList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              RouteUtils.push(
                                context,
                                SearchPage(
                                    keyword:
                                        hotKeyViewModel.hotKeyList[index].name),
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
                                hotKeyViewModel.hotKeyList[index].name ?? '',
                                style: TextStyle(fontSize: 12.sp),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
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
                    Container(
                      padding: EdgeInsets.only(
                          left: 10.r, right: 10.r, top: 10.r, bottom: 10.r),
                      child: GridView.builder(
                        shrinkWrap: true,
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
                              // 跳转到webview页面
                              RouteUtils.push(
                                context,
                                WebViewPage(
                                  loadResource: hotKeyViewModel
                                          .commonWebsiteList[index].link ??
                                      '',
                                  webViewType: WebViewType.URL,
                                  showTitle: true,
                                  title: hotKeyViewModel
                                      .commonWebsiteList[index].name,
                                ),
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
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

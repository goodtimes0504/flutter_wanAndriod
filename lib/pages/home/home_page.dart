import "package:flutter/material.dart";
import 'package:flutter_application_11/common_ui/web/webview_page.dart';
import 'package:flutter_application_11/common_ui/web/webview_widget.dart';
import 'package:flutter_application_11/repository/datas/home_list_data/home_list_data.dart';
// import 'package:flutter_application_11/datas/home_banner_data/home_banner_data.dart';
import 'package:flutter_application_11/pages/home/home_view_model.dart';
import 'package:flutter_application_11/route/route_utils.dart';
// import 'package:flutter_application_11/pages/web_view_page.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel homeViewModel = HomeViewModel();
  RefreshController refreshController = RefreshController();
  // 定义一个颜色数组
  // final List<Map<String, dynamic>> slides = [
  //   {
  //     'color': [Colors.blue, Colors.lightBlue],
  //     'title': '第一页',
  //     'subtitle': '这是蓝色页面'
  //   },
  //   {
  //     'color': [Colors.red, Colors.pink],
  //     'title': '第二页',
  //     'subtitle': '这是红色页面'
  //   },
  //   {
  //     'color': [Colors.green, Colors.lightGreen],
  //     'title': '第三页',
  //     'subtitle': '这是绿色页面'
  //   },
  //   {
  //     'color': [Colors.orange, Colors.pink],
  //     'title': '第四页',
  //     'subtitle': '这是橙色页面'
  //   },
  //   {
  //     'color': [Colors.purple, Colors.brown],
  //     'title': '第五页',
  //     'subtitle': '这是紫色页面'
  //   },
  //   {
  //     'color': [Colors.brown, Colors.cyan],
  //     'title': '第六页',
  //     'subtitle': '这是棕色页面'
  //   },
  //   {
  //     'color': [Colors.cyan, Colors.purple],
  //     'title': '第七页',
  //     'subtitle': '这是青色页面'
  //   },
  //   // ... 更多项
  // ];
  @override
  void initState() {
    super.initState();
    // 延迟执行，等当前 build 完成后再调用 getHomeList
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeViewModel.getBanner();
      homeViewModel.getHomeList(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return homeViewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: ClassicFooter(),
            // 上拉加载
            onLoading: () async {
              homeViewModel.getHomeList(true);
              refreshController.loadComplete();
            },
            // 下拉刷新
            onRefresh: () async {
              await homeViewModel.getBanner();
              await homeViewModel.getHomeList(false);
              refreshController.refreshCompleted();
            },
            child: CustomScrollView(
              slivers: [
                // 轮播图部分
                SliverToBoxAdapter(
                  child: _banner(),
                ),
                // 使用 SliverPadding 包裹 SliverList
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 15.r),
                  sliver: Consumer<HomeViewModel>(
                    builder: (context, homeViewModel, child) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return _listItemView2(
                                context, homeViewModel.listData[index], index);
                          },
                          childCount: homeViewModel.listData.length,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _banner() {
  return Consumer<HomeViewModel>(
    builder: (context, homeViewModel, child) {
      return Container(
        height: 200.h,
        margin: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          // color: Colors.lightBlue,
        ),
        // 使用 ClipRRect 包裹 Swiper 以确保内容始终保持圆角
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Swiper(
            indicatorLayout: PageIndicatorLayout.COLOR,
            autoplay: true,
            pagination: SwiperPagination(),
            control: SwiperControl(),
            // 使用颜色数组的长度作为轮播项数量
            itemCount: homeViewModel.bannerData?.data?.length ?? 0,
            itemBuilder: (BuildContext context, index) {
              return Image.network(
                homeViewModel.bannerData?.data?[index].imagePath ?? "",
                fit: BoxFit.fill,
              );
            },
          ),
        ),
      );
    },
  );
}

Widget _listItemView2(BuildContext context, Datas? data, int index) {
  return GestureDetector(
    onTap: () {
      // 跳转到webview页面
      RouteUtils.push(
        context,
        WebViewPage(
          loadResource: data?.link ?? "",
          webViewType: WebViewType.URL,
          showTitle: true,
          title: data?.title ?? "",
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 10.r),
      padding:
          EdgeInsets.only(left: 15.r, right: 15.r, top: 20.r, bottom: 20.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            width: 1.r,
            color: Colors.black12,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRect(
            clipBehavior: Clip.hardEdge,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.network(
                    "https://img.doooor.com/img/forum/202004/17/213152vgnothbnez8r6f6w.jpg",
                    width: 30.r,
                    height: 30.r,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(width: 6.w), // 作者左边的间隔
                SizedBox(
                  width: 110.w, // 使用 ScreenUtil 的宽度适配
                  child: Text(
                      (data?.author?.isEmpty ?? true)
                          ? (data?.shareUser ?? "")
                          : (data?.author ?? ""),
                      style: TextStyle(fontSize: 14.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1),
                ),
                Expanded(child: SizedBox()),
                Text(data?.niceShareDate ?? "",
                    style: TextStyle(fontSize: 12.sp)),
                SizedBox(width: 10.w), // 时间右边的间隔
                Text("置顶",
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.r, bottom: 10.r),
            child: Text(data?.title ?? "", style: TextStyle(fontSize: 15.sp)),
          ),
          Row(
            children: [
              Text(data?.chapterName ?? "",
                  style: TextStyle(fontSize: 14.sp, color: Colors.green)),
              Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  Provider.of<HomeViewModel>(context, listen: false)
                      .collectArticle(data?.id.toString() ?? "", index);
                },
                child: Image.asset(
                  data?.collect ?? false
                      ? "assets/images/img_collect.png"
                      : "assets/images/img_collect_grey.png",
                  width: 30.r,
                  height: 30.r,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/repository/datas/my_collects_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_application_11/common_ui/smart_refresh/smart_refresh_widget.dart';

import '../../common_ui/common_style.dart';
import '../../common_ui/web/webview_page.dart';
import '../../common_ui/web/webview_widget.dart';
import '../../route/route_utils.dart';
import 'my_collects_view_model.dart';

///我的收藏页面
class MyCollectsPage extends StatefulWidget {
  const MyCollectsPage({super.key});

  @override
  State<StatefulWidget> createState() => _MyCollectsPageState();
}

class _MyCollectsPageState extends State<MyCollectsPage> {
  var model = MyCollectsViewModel();
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    // 同步初始化控制器
    _refreshController = RefreshController(initialRefresh: false);
    // 延迟执行数据请求，保证 build 已完成后再更新状态
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshOrLoad(false);
    });
  }

  void refreshOrLoad(bool loadMore) {
    model.getMyCollects(loadMore).then((value) {
      if (loadMore) {
        _refreshController.loadComplete();
      } else {
        _refreshController.refreshCompleted();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Selector<MyCollectsViewModel, List<MyCollectItemModel>?>(
            selector: (context, vm) => vm.dataList,
            builder: (context, list, child) {
              return SmartRefreshWidget(
                controller: _refreshController,
                onRefresh: () => refreshOrLoad(false),
                onLoading: () => refreshOrLoad(true),
                child: (list == null || list.isEmpty)
                    ? Center(child: Text("暂无收藏"))
                    : ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return _collectItem(
                            list[index],
                            onTap: () {
                              // 取消收藏
                              model.cancelCollect(index, "${list[index].id}");
                            },
                            itemClick: () {
                              // 进入网页
                              RouteUtils.push(
                                context,
                                WebViewPage(
                                  loadResource: list[index].link ?? "",
                                  webViewType: WebViewType.URL,
                                  showTitle: true,
                                  title: list[index].title,
                                ),
                              );
                            },
                          );
                        },
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _collectItem(MyCollectItemModel item,
      {GestureTapCallback? onTap, GestureTapCallback? itemClick}) {
    return GestureDetector(
      onTap: itemClick,
      child: Container(
        margin: EdgeInsets.all(10.r),
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text("作者: ${item.author}"),
                ),
                Text("时间: ${item.niceDate}"),
              ],
            ),
            SizedBox(height: 6.h),
            Text("${item.title}", style: titleTextStyle15),
            Row(
              children: [
                Expanded(child: Text("分类: ${item.chapterName}")),
                collectImage(true, onTap: onTap),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

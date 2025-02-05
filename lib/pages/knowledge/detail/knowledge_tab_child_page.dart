import 'package:flutter/material.dart';
import 'package:flutter_application_11/common_ui/common_style.dart';
import 'package:flutter_application_11/common_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:flutter_application_11/common_ui/web/webview_page.dart';
import 'package:flutter_application_11/common_ui/web/webview_widget.dart';
import 'package:flutter_application_11/pages/knowledge/detail/knowledge_detail_view_model.dart';
import 'package:flutter_application_11/repository/datas/knowledge_detail_list_data/knowledge_detail_list.dart';
import 'package:flutter_application_11/route/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../repository/datas/knowledge_detail_list_data/knowledge_detail_list.dart';

class KnowledgeTabChildPage extends StatefulWidget {
  final String id;
  const KnowledgeTabChildPage({super.key, required this.id});

  @override
  State<KnowledgeTabChildPage> createState() => _KnowledgeTabChildPageState();
}

class _KnowledgeTabChildPageState extends State<KnowledgeTabChildPage> {
  final KnowledgeDetailViewModel _viewModel = KnowledgeDetailViewModel();
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    super.initState();
    refreshOrLoad(false);
  }

  void refreshOrLoad(bool loadMore) {
    _viewModel.getKnowledgeDetailList(widget.id, loadMore).then((value) {
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
      create: (context) {
        return _viewModel;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<KnowledgeDetailViewModel>(
          builder: (context, viewModel, child) {
            return SmartRefreshWidget(
              controller: _refreshController,
              onRefresh: () {
                refreshOrLoad(false);
              },
              onLoading: () {
                refreshOrLoad(true);
              },
              child: ListView.builder(
                itemCount: viewModel.datas.length,
                itemBuilder: (context, index) {
                  return _item(viewModel.datas[index], onTap: () {
                    RouteUtils.push(
                      context,
                      WebViewPage(
                          loadResource: viewModel.datas[index].link ?? "",
                          webViewType: WebViewType.URL,
                          showTitle: true,
                          title: viewModel.datas[index].title ?? ""),
                    );
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _item(Datas item, {GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.r, horizontal: 15.w),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 0.5.r),
        ),
        child: Column(
          children: [
            Row(
              children: [
                normalText(item.superChapterName),
                Expanded(child: SizedBox()),
                Text("${item.niceShareDate}"),
              ],
            ),
            Text("${item.title}", style: titleTextStyle15),
            Row(
              children: [
                normalText(item.chapterName),
                Expanded(child: SizedBox()),
                Text("${item.shareUser}"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

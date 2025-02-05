import 'package:flutter/material.dart';
import 'package:flutter_application_11/common_ui/web/webview_page.dart';
import 'package:flutter_application_11/common_ui/web/webview_widget.dart';
import 'package:flutter_application_11/pages/search/search_view_model.dart';
import 'package:flutter_application_11/route/route_utils.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.keyword});
  final String? keyword;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _editController;
  late SearchViewModel _searchViewModel;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.keyword ?? "");
    _searchViewModel = SearchViewModel();
    _searchViewModel.getSearchData(widget.keyword ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _searchViewModel,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _searchBar(
                onBack: () {
                  Navigator.pop(context);
                },
                onCancel: () {
                  _editController.clear();
                  _searchViewModel.clear();
                  // 让软键盘消失
                  FocusScope.of(context).unfocus();
                },
                onSubmitted: (value) {
                  _searchViewModel.getSearchData(value);
                },
              ),
              Expanded(
                child: Consumer<SearchViewModel>(
                  builder: (context, viewModel, child) {
                    return ListView.builder(
                      itemCount: viewModel.searchData?.length ?? 0,
                      itemBuilder: (context, index) {
                        return _listItem(
                            viewModel.searchData?[index].title ?? "", () {
                          RouteUtils.push(
                            context,
                            WebViewPage(
                              loadResource:
                                  viewModel.searchData?[index].link ?? "",
                              webViewType: WebViewType.URL,
                              showTitle: true,
                              title: viewModel.searchData?[index].title ?? "",
                            ),
                          );
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listItem(String title, GestureTapCallback? onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
          child: Html(
            data: title,
            style: {'html': Style(fontSize: FontSize(15.sp))},
          ),
        ));
  }

  Widget _searchBar(
      {GestureTapCallback? onBack,
      GestureTapCallback? onCancel,
      ValueChanged<String>? onSubmitted}) {
    return Container(
      color: Colors.teal,
      height: 50.h,
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(width: 10.r),
          GestureDetector(
            onTap: onBack,
            child: Image.asset(
              "assets/images/icon_back.png",
              width: 30.r,
              height: 30.r,
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
            child: TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              onSubmitted: onSubmitted,
              controller: _editController,
              decoration: InputDecoration(
                hintText: "请输入搜索内容",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                hintStyle: TextStyle(fontSize: 15.sp, color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          )),
          GestureDetector(
              onTap: onCancel,
              child: Text("取消",
                  style: TextStyle(fontSize: 15.sp, color: Colors.white))),
          SizedBox(width: 10.r),
        ],
      ),
    );
  }
}

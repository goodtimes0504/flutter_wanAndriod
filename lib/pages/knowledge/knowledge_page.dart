import 'package:flutter/material.dart';
import 'package:flutter_application_11/pages/knowledge/detail/knowledge_detail_tab_page.dart';
import 'package:flutter_application_11/pages/knowledge/knowledge_view_model.dart';
import 'package:flutter_application_11/repository/datas/knowledge_list_data/child.dart';
import 'package:flutter_application_11/repository/datas/knowledge_list_data/datum.dart';
import 'package:flutter_application_11/route/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  final KnowledgeViewModel _viewModel = KnowledgeViewModel();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _viewModel.getKnowledgeList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        body: Consumer<KnowledgeViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (viewModel.knowledgeList.isEmpty) {
              return const Center(
                child: Text('暂无数据'),
              );
            }

            return ListView.builder(
              itemCount: viewModel.knowledgeList.length,
              itemBuilder: (context, index) {
                final Datum item = viewModel.knowledgeList[index];
                // 调用 ViewModel 中的方法来获得拼接后的字符串
                final childrenContent =
                    _viewModel.getConcatenatedChildren(item);

                return _buildKnowledgeItem(
                  item.name ?? '',
                  childrenContent,
                  item.children ?? [],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildKnowledgeItem(
      String title, String content, List<Child> children) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: 处理点击事件，导航到详情页面
            RouteUtils.push(context, KnowledgeDetailTabPage(tabList: children));
          },
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16.r,
                      color: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

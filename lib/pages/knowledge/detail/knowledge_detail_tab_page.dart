import 'package:flutter/material.dart';
import 'package:flutter_application_11/pages/knowledge/detail/knowledge_detail_view_model.dart';
import 'package:flutter_application_11/repository/datas/knowledge_list_data/child.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_11/pages/knowledge/detail/knowledge_tab_child_page.dart';

class KnowledgeDetailTabPage extends StatefulWidget {
  const KnowledgeDetailTabPage({super.key, this.tabList});
  final List<Child>? tabList;

  @override
  State<KnowledgeDetailTabPage> createState() => _KnowledgeDetailTabPageState();
}

class _KnowledgeDetailTabPageState extends State<KnowledgeDetailTabPage>
    with SingleTickerProviderStateMixin {
  final KnowledgeDetailViewModel _viewModel = KnowledgeDetailViewModel();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.tabList?.length ?? 0, vsync: this);
    _viewModel.initTabs(widget.tabList ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          title: TabBar(
            tabs: _viewModel.tabs,
            controller: _tabController,
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            isScrollable: true,
            // 让tabbar标签整体左对齐
            tabAlignment: TabAlignment.start,
            // labelPadding: EdgeInsets.zero, // 移除标签默认的内边距
            // indicatorPadding: EdgeInsets.zero, // 移除指示器默认的内边距
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: _buildTabBarView(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabBarView() {
    List<Widget> list = [];
    for (var child in widget.tabList ?? []) {
      list.add(KnowledgeTabChildPage(id: child.id.toString()));
    }
    return list;
  }
}

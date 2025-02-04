import 'package:flutter/material.dart';

class WebViewPage extends StatefulWidget {
  final String? title;
  final String? url;

  const WebViewPage({
    super.key,
    this.title,
    this.url,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  String? name;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 在这里获取路由参数
    var map = ModalRoute.of(context)?.settings.arguments;
    if (map is Map) {
      setState(() {
        name = map['name'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name ?? ''),
      ),
      body: SafeArea(
        child: Center(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text("返回"),
          ),
        ),
      ),
    );
  }
}

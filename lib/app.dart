// 导入Flutter Material组件库
import 'package:flutter/material.dart';
import 'package:flutter_application_11/route/route_utils.dart';
import 'package:flutter_application_11/route/routes.dart';
// 导入屏幕适配工具库
import 'package:flutter_screenutil/flutter_screenutil.dart';
// 导入Toast提示库
import 'package:oktoast/oktoast.dart';
// import './pages/home_page.dart';

/// 获取设计尺寸
/// 计算逻辑屏幕尺寸并应用缩放因子
// 获取设计尺寸的方法
Size get designSize {
  // 获取第一个视图
  final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
  // 计算逻辑短边（考虑设备像素密度）
  final logicalShortestSide =
      firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
  // 计算逻辑长边（考虑设备像素密度）
  final logicalLongestSide =
      firstView.physicalSize.longestSide / firstView.devicePixelRatio;
  // 定义缩放比例（0.95表示缩小5%，元素会显得更大）
  const scaleFactor = 0.95;
  // 返回缩放后的逻辑尺寸
  return Size(
      logicalShortestSide * scaleFactor, logicalLongestSide * scaleFactor);
}

// 主应用组件
class MyApp extends StatelessWidget {
  // 构造函数
  const MyApp({super.key});

  // 重写build方法
  @override
  // 构建应用界面
  Widget build(BuildContext context) {
    // 使用OKToast包裹应用，使其支持Toast提示
    // Toast提示必须作为应用的顶层组件
    return OKToast(
        // 使用ScreenUtilInit进行屏幕适配
        // 作为屏幕适配的父组件
        child: ScreenUtilInit(
      // 设置设计尺寸
      designSize: designSize,
      // 构建MaterialApp
      builder: (context, child) {
        return MaterialApp(
          // 应用标题
          title: 'Flutter Demo',
          // 应用主题
          theme: ThemeData(
            // 颜色方案，使用深紫色作为种子颜色
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            // 使用Material 3设计
            useMaterial3: true,
          ),
          // 设置路由
          onGenerateRoute: Routes.generateRoute,
          navigatorKey: RouteUtils.navigatorKey,
          initialRoute: RoutePath.tab,
          // 设置首页
          // home: const HomePage(),
        );
      },
    ));
  }
}

// 首页组件
// class MyHomePage extends StatefulWidget {
//   // 构造函数，接收标题参数
//   const MyHomePage({super.key, required this.title});

//   // 页面标题
//   final String title;

//   // 重写createState方法
//   @override
//   // 创建状态对象
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// // 首页状态类
// class _MyHomePageState extends State<MyHomePage> {
// 计数器变量
//   int _counter = 0;

//   // 增加计数器的方法
//   void _incrementCounter() {
//     // 更新状态
//     setState(() {
//       _counter++;
//     });
//   }

//   // 重写build方法
//   @override
//   // 构建页面UI
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // 应用栏
//       appBar: AppBar(
//         // 设置背景颜色为主题的反色
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // 设置标题
//         title: Text(widget.title),
//       ),
//       // 页面主体内容
//       body: Center(
//         // 使用垂直布局
//         child: Column(
//           // 内容垂直居中
//           mainAxisAlignment: MainAxisAlignment.center,
//           // 子组件列表
//           children: <Widget>[
//             // 提示文本
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             // 显示计数器值
//             Text(
//               '$_counter',
//               // 使用主题中的大标题样式
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       // 悬浮操作按钮
//       floatingActionButton: FloatingActionButton(
//         // 点击事件绑定
//         onPressed: _incrementCounter,
//         // 提示文本
//         tooltip: 'Increment',
//         // 添加图标
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

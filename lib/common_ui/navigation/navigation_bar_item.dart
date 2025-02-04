import 'package:flutter/material.dart';

/// 底部导航栏按钮组件
/// 实现了一个带有缩放动画效果的导航栏按钮
class NavigationBarItem extends StatefulWidget {
  // 构造函数，要求传入一个builder函数来构建按钮的具体内容
  const NavigationBarItem({super.key, required this.builder});

  // builder函数用于构建按钮的具体UI内容
  // WidgetBuilder 是一个函数类型，接收 BuildContext 并返回 Widget
  final WidgetBuilder builder;

  @override
  // 创建与此widget关联的状态类
  State createState() => _NavigationBarItemState();
}

/// 导航栏按钮的状态类
/// 使用 TickerProviderStateMixin 来提供动画所需的 vsync
class _NavigationBarItemState extends State<NavigationBarItem>
    with TickerProviderStateMixin {
  // 动画控制器，用于控制缩放动画的执行
  late AnimationController controller;
  // 动画对象，定义了缩放的具体数值变化
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    // 初始化动画控制器，设置动画时长为300毫秒
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    // 启动动画
    controller.forward();
    // 创建从0.8到1.0的缩放动画
    animation = Tween<double>(begin: 0.8, end: 1).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    // 使用ScaleTransition实现缩放动画效果
    // scale参数使用我们定义的animation
    // child使用builder函数构建具体的按钮内容
    return ScaleTransition(scale: animation, child: widget.builder(context));
  }

  @override
  void dispose() {
    // 在组件销毁时释放动画控制器资源
    controller.dispose();
    super.dispose();
  }
}

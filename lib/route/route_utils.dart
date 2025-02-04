// 导入Flutter的材料设计库，提供了导航相关的核心功能
import 'package:flutter/material.dart';

/// 这是一个路由工具类，用于简化页面导航操作
class RouteUtils {
  // 私有构造函数，防止类被实例化
  RouteUtils._();

  // 创建一个全局的导航器key，用于在任何地方都能访问导航器
  static final navigatorKey = GlobalKey<NavigatorState>();

  // 获取应用程序的根Context，用于在没有context的地方进行导航
  static BuildContext get context => navigatorKey.currentContext!;

  // 获取导航器状态，用于执行导航操作
  static NavigatorState get navigator => navigatorKey.currentState!;

  /// 普通页面跳转方法
  /// @param context - 构建上下文
  /// @param page - 要跳转到的页面Widget
  /// @param fullscreenDialog - 是否以全屏对话框方式打开
  /// @param settings - 路由设置
  /// @param maintainState - 是否保持页面状态
  static Future push(
    BuildContext context,
    Widget page, {
    bool? fullscreenDialog,
    RouteSettings? settings,
    bool maintainState = true,
  }) {
    // 使用Navigator.push方法进行页面跳转
    // MaterialPageRoute是MaterialPageRoute的一个实现，用于创建一个新的路由
    return Navigator.push(
        context,
        MaterialPageRoute(
          // builder是一个回调函数，用于创建新的页面
          builder: (_) => page,
          // fullscreenDialog表示是否以全屏对话框方式打开
          fullscreenDialog: fullscreenDialog ?? false,
          // settings是路由设置
          settings: settings,
          // maintainState表示是否保持页面状态
          maintainState: maintainState,
        ));
  }

  /// 使用命名路由进行页面跳转
  /// @param context - 构建上下文
  /// @param name - 路由名称
  /// @param arguments - 传递给新页面的参数
  static Future pushForNamed(
    BuildContext context,
    String name, {
    Object? arguments,
  }) {
    // 使用Navigator.pushNamed方法进行命名路由跳转
    return Navigator.pushNamed(context, name, arguments: arguments);
  }

  /// 使用自定义路由进行页面跳转
  /// @param context - 构建上下文
  /// @param route - 自定义的路由对象
  static Future pushForPageRoute(BuildContext context, Route route) {
    // 使用Navigator.push方法进行自定义路由跳转
    return Navigator.push(context, route);
  }

  /// 清空导航栈并跳转到指定命名路由
  /// @param context - 构建上下文
  /// @param name - 路由名称
  /// @param arguments - 传递给新页面的参数
  static Future pushNamedAndRemoveUntil(
    BuildContext context,
    String name, {
    Object? arguments,
  }) {
    // route => false 表示清空所有之前的路由
    // Navigator.pushNamedAndRemoveUntil方法用于清空导航栈并跳转到指定命名路由
    return Navigator.pushNamedAndRemoveUntil(context, name, (route) => false,
        arguments: arguments);
  }

  /// 清空导航栈并跳转到指定页面
  /// @param context - 构建上下文
  /// @param page - 要跳转到的页面Widget
  /// @param fullscreenDialog - 是否以全屏对话框方式打开
  /// @param settings - 路由设置
  /// @param maintainState - 是否保持页面状态
  static Future pushAndRemoveUntil(
    BuildContext context,
    Widget page, {
    bool? fullscreenDialog,
    RouteSettings? settings,
    bool maintainState = true,
  }) {
    // Navigator.pushAndRemoveUntil方法用于清空导航栈并跳转到指定页面
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => page,
          fullscreenDialog: fullscreenDialog ?? false,
          settings: settings,
          maintainState: maintainState,
        ),
        (route) => false);
  }

  /// 替换当前路由为新的自定义路由
  /// @param context - 构建上下文
  /// @param route - 新的路由对象
  /// @param result - 返回给上一个页面的结果
  static Future pushReplacement(BuildContext context, Route route,
      {Object? result}) {
    // Navigator.pushReplacement方法用于替换当前路由为新的自定义路由
    return Navigator.pushReplacement(context, route, result: result);
  }

  /// 替换当前路由为新的命名路由
  /// @param context - 构建上下文
  /// @param name - 新路由的名称
  /// @param result - 返回给上一个页面的结果
  /// @param arguments - 传递给新页面的参数
  static Future pushReplacementNamed(
    BuildContext context,
    String name, {
    Object? result,
    Object? arguments,
  }) {
    // Navigator.pushReplacementNamed方法用于替换当前路由为新的命名路由
    return Navigator.pushReplacementNamed(context, name,
        arguments: arguments, result: result);
  }

  /// 关闭当前页面
  /// @param context - 构建上下文
  static void pop(BuildContext context) {
    // Navigator.pop方法用于关闭当前页面
    Navigator.pop(context);
  }

  /// 关闭当前页面并返回数据
  /// @param context - 构建上下文
  /// @param data - 要返回给上一个页面的数据
  static void popOfData<T extends Object?>(BuildContext context, {T? data}) {
    // Navigator.of(context).pop方法用于关闭当前页面并返回数据
    Navigator.of(context).pop(data);
  }
}

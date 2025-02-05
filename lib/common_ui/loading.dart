import 'package:flutter/cupertino.dart'; // 导入Flutter中的Cupertino组件库，提供iOS风格的界面组件
import 'package:flutter/material.dart'; // 导入Flutter中的Material组件库，提供Material Design风格的界面组件
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 导入屏幕适配库，用于动态适配不同屏幕尺寸
import 'package:oktoast/oktoast.dart'; // 导入oktoast库，用于显示Toast通知

class Loading {
  // 定义一个名为Loading的类，用于管理加载动画的显示与消失
  Loading._(); // 定义私有构造函数，防止该类被实例化，从而确保只能通过静态方法调用

  static Future showLoading({Duration? duration}) async {
    // 定义一个静态异步方法showLoading，可选传入duration参数以设定加载显示的时长
    showToastWidget(
        // 调用oktoast提供的showToastWidget方法来显示一个自定义的Toast组件
        Container(
          // 创建一个容器，用来构建Toast的整体布局
          color: Colors.transparent, // 设置这个容器的背景颜色为透明
          constraints: const BoxConstraints.expand(), // 设置容器的尺寸约束，扩展到全屏大小
          child: Align(
            // 使用Align组件，将内部子组件居中对齐
            child: Container(
              // 再创建一个内部容器，用于包裹加载动画
              padding:
                  EdgeInsets.all(20.w), // 设置内边距，使用flutter_screenutil包中的适配宽度值
              decoration: BoxDecoration(
                // 定义容器的装饰效果
                color: Colors.black54, // 设置容器背景为半透明黑色，以便突出加载动画
                borderRadius:
                    BorderRadius.circular(10.r), // 设置容器的圆角效果，角度值也通过适配获得
              ),
              child: CircularProgressIndicator(
                // 使用圆形进度指示器显示加载中的动画
                strokeWidth: 2.w, // 设置进度指示器的线宽，使用适配宽度值
                valueColor: const AlwaysStoppedAnimation(
                    Colors.white), // 设置进度指示器动画的颜色为白色，并保持不变
              ),
            ),
          ),
        ),
        handleTouch: true, // 设置Toast处理触摸事件为启用状态，允许用户交互
        duration: duration ?? const Duration(days: 1)); // 如果未指定持续时间，则默认持续显示1天
  }

  static void dismissAll() {
    // 定义一个静态方法dismissAll，用于关闭所有当前显示的Toast
    dismissAllToast(); // 调用oktoast提供的dismissAllToast方法，实现关闭所有Toast的功能
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 输入框
Widget commonInput(
    {String? labelText,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    bool? obscureText}) {
  return TextField(
    obscureText: obscureText ?? false,
    controller: controller,
    onChanged: onChanged,
    style: TextStyle(color: Colors.white, fontSize: 16.sp),
    cursorColor: Colors.white,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
  );
}

// 白色边框按钮
Widget whiteBorderButton({GestureTapCallback? onTap, required String? text}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 50.h,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 45.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        text ?? '',
        style: TextStyle(
          color: Colors.teal,
          fontSize: 16.sp,
        ),
      ),
    ),
  );
}

// 标题文本15号
TextStyle titleTextStyle15 = TextStyle(fontSize: 15.sp);
// 普通字体
TextStyle normalTextStyle15 = TextStyle(fontSize: 15.sp);

//白色字体14号
TextStyle whiteTextStyle14 = TextStyle(color: Colors.white, fontSize: 14.sp);
//白色字体15号
TextStyle whiteTextStyle15 = TextStyle(color: Colors.white, fontSize: 15.sp);

//黑色字体13号
TextStyle blackTextStyle13 = TextStyle(fontSize: 13.sp, color: Colors.black);
//普通字体，只做判空处理
Text normalText(String? text) {
  return Text(
    text ?? "",
    style: titleTextStyle15,
  );
}

TextField commonInputText(
    {TextEditingController? controller,
    required String labelText,
    ValueChanged<String>? onChanged,
    TextStyle? style,
    bool? obscureText,
    Color? cursorColor}) {
  return TextField(
      onChanged: onChanged,
      controller: controller,
      style: style ?? TextStyle(color: Colors.white, fontSize: 14.sp),
      obscureText: obscureText ?? false,
      cursorColor: cursorColor ?? Colors.white,
      decoration: InputDecoration(
          enabledBorder: commonOutLine(width: 0.5.r),
          focusedBorder: commonOutLine(width: 1.r),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white)));
}

OutlineInputBorder commonOutLine({double? width, Color? color}) {
  return OutlineInputBorder(
      borderSide:
          BorderSide(color: color ?? Colors.white, width: width ?? 1.r));
}

//白色边框白色字体按钮
Widget outlineWhiteButton(String title, {GestureTapCallback? onTap}) {
  return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        width: double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.r),
            borderRadius: BorderRadius.all(Radius.circular(25.r))),
        child: Text(
          title,
          style: whiteTextStyle15,
        ),
      ));
}

//收藏按钮
Widget collectImage(bool? collect, {GestureTapCallback? onTap}) {
  return GestureDetector(
      onTap: onTap,
      child: Image.asset(
          collect == true
              ? "assets/images/img_collect"
                  ".png"
              : "assets/images/img_collect_grey.png",
          width: 25.r,
          height: 25.r));
}

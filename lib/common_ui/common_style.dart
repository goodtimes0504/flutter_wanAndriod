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

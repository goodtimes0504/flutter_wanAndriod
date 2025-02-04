import 'package:flutter/material.dart';
import 'package:flutter_application_11/http/dio_instance.dart';

import 'app.dart';

void main() {
  DioInstance.getInstance().initDio(baseUrl: "https://www.wanandroid.com/");
  runApp(const MyApp());
}

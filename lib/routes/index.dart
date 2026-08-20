// 注释: 路由管理
import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Login/index.dart';
import 'package:hm_shop/pages/Main/index.dart';

// 返回App根级组件
Widget getRootWidget() {
  return MaterialApp(
    initialRoute: "/",
    // 命名路由
    routes: getRootRoutes(),
  );
}

// 返回该App的路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    "/": (context) => MainPage(), // 主页路由
    "/login": (p0) => LoginPage(), // 登陆路由
  };
}

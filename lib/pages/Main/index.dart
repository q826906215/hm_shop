import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 定义数据 根据数据进行渲染4个导航
  // 一般应用程序的导航是固定的
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/tabbar/unselect-data.png", // 正常显示的图标
      "active_icon": "lib/assets/tabbar/select-data.png", //激活显示的图标
      "name": "首页",
    },
    {
      "icon": "lib/assets/tabbar/unselect-ai.png", // 正常显示的图标
      "active_icon": "lib/assets/tabbar/select-ai.png", //激活显示的图标
      "name": "AI",
    },
    {
      "icon": "lib/assets/tabbar/unselect-monitor.png", // 正常显示的图标
      "active_icon": "lib/assets/tabbar/select-monitor.png", //激活显示的图标
      "name": "购物车",
    },
    {
      "icon": "lib/assets/tabbar/unselect-user.png", // 正常显示的图标
      "active_icon": "lib/assets/tabbar/select-user.png", //激活显示的图标
      "name": "我的",
    },
  ];

  int _currentIndex = 0;

  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabList[index]["active_icon"]!,
          width: 30,
          height: 30,
        ),
        label: _tabList[index]["name"],
      );
    });
  }

  // 注释: tabbar页面List
  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  void initState() {
    super.initState();
    // 初始化用户信息
    _initUser();
  }

  final UserController _userController = Get.put(UserController());
  Future<void> _initUser() async {
    await tokenManager.init(); // 初始化token管理器
    if (tokenManager.getToken().isNotEmpty) {
      // 如果token存在 则获取用户信息
      _userController.updateUserInfo(await profileAPI());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("主页")),
      // SafeArea 避开安全区组件
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _getChildren(), //放置几个组件
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          debugPrint("$value");
          _currentIndex = value;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: _getTabBarWidget(),
      ),
    );
  }
}

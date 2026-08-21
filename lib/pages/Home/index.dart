import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/component/Home/HmCategory.dart';
import 'package:hm_shop/component/Home/HmHot.dart';
import 'package:hm_shop/component/Home/HmMoreList.dart';
import 'package:hm_shop/component/Home/HmSlider.dart';
import 'package:hm_shop/component/Home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 注释: 轮播图数据
  List<BannerItem> _bannerList = [];

  // 注释: 分类列表
  List<CategoryItem> _categoryList = [];

  // 注释: 获取滚动容器的内容
  List<Widget> _getScrollChildern() {
    return [
      // 包裹普通widget的sliver家族的组件
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)), // 轮播图组件
      // 放置分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: HmCategrory(categoryList: _categoryList),
      ), // 分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(child: HmSuggestion()),
      // SliverGrid SliverList只能纵向排列
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // ListView
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: Hmhot()),
              SizedBox(width: 10),
              Expanded(child: Hmhot()),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(),
    ];
  }

  @override
  void initState() {
    super.initState();
    _getBannderList();
    _getCategoryList();
  }

  // 注释: 获取轮播图列表
  void _getBannderList() async {
    _bannerList = await getBannerListAPI();
    setState(() {});
  }

  // 注释: 获取分类列表
  void _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildern()); // sliver家族内容
  }
}

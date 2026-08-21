import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final List<BannerItem> _bannerItem = [
    BannerItem(
      id: "1",
      imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg",
    ),
    BannerItem(
      id: "2",
      imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png",
    ),
    BannerItem(
      id: "3",
      imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg",
    ),
  ];

  // 注释: 获取滚动容器的内容
  List<Widget> _getScrollChildern() {
    return [
      // 包裹普通widget的sliver家族的组件
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerItem)), // 轮播图组件
      // 放置分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(child: HmCategrory()), // 分类组件
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
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildern()); // sliver家族内容
  }
}

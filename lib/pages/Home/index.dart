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
  // 注释: 特惠推荐列表
  RecommendResult _recommendResult = RecommendResult(id: "", title: "");
  // 注释: 热门推荐列表
  RecommendResult _hotInVogueResult = RecommendResult(id: "", title: "");
  // 注释: 一站式推荐列表
  RecommendResult _hotOneStopResult = RecommendResult(id: "", title: "");

  // 注释: 新鲜好物列表
  List<FreshGoodsItem> _freshGoodsItem = [];
  // 注释: 10条数据页码
  int _page = 1;
  // 注释: 是否正在加载更多数据
  bool _isLoading = false;
  // 注释: 是否还有更多数据
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _getBannderList();
    _getCategoryList();
    _getHotPreferenceList();
    _getHotInVogueList();
    _getHotOneStopList();
    _getRecommendList();

    _registerEvent();
  }

  // 注释: 注册监听滚动到底部的事件
  void _registerEvent() {
    _scrollController.addListener(() {
      // 滚动时触发
      debugPrint("滚动事件触发");
      // 滚动到底部时触发
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        // 加载更多数据
        _getRecommendList();
      }
    });
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

  // 注释: 获取特惠推荐列表
  void _getHotPreferenceList() async {
    _recommendResult = await getHotPreferenceListAPI();
    setState(() {});
  }

  // 注释: 获取热门推荐列表
  void _getHotInVogueList() async {
    _hotInVogueResult = await getHotInVogueListAPI();
    setState(() {});
  }

  // 注释: 获取一站式推荐列表
  void _getHotOneStopList() async {
    _hotOneStopResult = await getHotOneStopListAPI();
    setState(() {});
  }

  // 注释: 获取推荐列表
  void _getRecommendList() async {
    // 加载更多数据时，判断是否正在加载更多数据或是否还有更多数据 就放弃请求
    if (_isLoading || !_hasMore) {
      return;
    }
    // 加载更多数据时，设置正在加载更多数据为true
    _isLoading = true;
    int requestLimit = _page * 8;
    _freshGoodsItem = await getRecommendListAPI(
      queryParameters: {"limit": requestLimit},
    );
    // 加载更多数据时，设置正在加载更多数据为false
    _isLoading = false;
    setState(() {});
    // 我要10条 你给10条 说明我要的你都给了 接着认为还有下一页
    if (_freshGoodsItem.length < requestLimit) {
      _hasMore = false;
      return;
    }
    _page++;
  }

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

      SliverToBoxAdapter(
        child: HmSuggestion(recommendResult: _recommendResult),
      ),
      // SliverGrid SliverList只能纵向排列
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // ListView
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Hmhot(recommendResult: _hotInVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Hmhot(recommendResult: _hotOneStopResult, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(freshGoodsItemList: _freshGoodsItem),
    ];
  }

  // 注释: 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController, // 绑定滚动控制器
      slivers: _getScrollChildern(),
    ); // sliver家族内容
  }
}

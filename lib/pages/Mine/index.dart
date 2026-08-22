import 'package:flutter/material.dart';
import 'package:hm_shop/api/Mine.dart';
import 'package:hm_shop/component/Home/HmMoreList.dart';
import 'package:hm_shop/component/Mine/Guess.dart';
import 'package:hm_shop/component/Mine/LoginHeader.dart';
import 'package:hm_shop/component/Mine/OrderSection.dart';
import 'package:hm_shop/component/Mine/QuickActions.dart';
import 'package:hm_shop/viewmodels/Mine.dart';
import 'package:hm_shop/viewmodels/home.dart';

class MineView extends StatefulWidget {
  MineView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  List<FreshGoodsItem> _guessList = [];

  Map<String, dynamic>? _params = {"page": 1, "pageSize": 10};

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getGuessList();
    _registerEvent();
  }

  void _registerEvent() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        // 上拉加载更多
        // _params?["page"]++;
        _getGuessList();
      }
    });
  }

  bool _isLoading = false; // 是否正在加载中
  bool _hasMore = true; // 是否还有更多数据

  Future<void> _getGuessList() async {
    if (_isLoading || !_hasMore) {
      // 加载中 或 没有更多数据了
      return;
    }
    _isLoading = true;
    final guessListItems = await getGuessListAPI(queryParameters: _params);
    _isLoading = false;
    _guessList.addAll(guessListItems.items ?? []);
    if (_params?["page"] >= guessListItems.pages) {
      _hasMore = false; // 没有更多数据了
      return;
    }

    _params?["page"]++;
    // 刷新界面
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(child: LoginHeaderView()),
        SliverToBoxAdapter(child: QuickActionsView()),
        SliverToBoxAdapter(child: OrderSectionView()),
        SliverPersistentHeader(delegate: GuessView(), pinned: true),
        //猜你喜欢
        HmMoreList(freshGoodsItemList: _guessList), //上拉加载更多
      ],
    );
  }
}

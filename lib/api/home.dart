// 封装一个api 目的是返回业务侧要的数据结构
import 'package:flutter/material.dart';
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  // 返回请求
  return await dioRequest.get(HttpConstants.BANNER_LIST).then((onValue) {
    final list = (onValue as List).map((item) => BannerItem.fromJSON(item));
    return list.toList();
  });
}

// 获取分类列表
Future<List<CategoryItem>> getCategoryListAPI() async {
  // 返回请求
  return await dioRequest.get(HttpConstants.CATEGORY_HEAD_LIST).then((onValue) {
    final list = (onValue as List).map((item) => CategoryItem.fromJSON(item));
    return list.toList();
  });
}

// 获取特惠推荐列表
Future<RecommendResult> getHotPreferenceListAPI() async {
  // 返回请求
  return await dioRequest.get(HttpConstants.HOT_PREFERENCE_LIST).then((
    onValue,
  ) {
    // 解析数据
    return RecommendResult.fromJSON(onValue);
  });
}

// 获取热门推荐列表
Future<RecommendResult> getHotInVogueListAPI() async {
  // 返回请求
  return await dioRequest.get(HttpConstants.HOT_IN_VOGUE_LIST).then((onValue) {
    // 解析数据
    return RecommendResult.fromJSON(onValue);
  });
}

// 获取一站式推荐列表
Future<RecommendResult> getHotOneStopListAPI() async {
  // 返回请求
  return await dioRequest.get(HttpConstants.HOT_ONE_STOP_LIST).then((onValue) {
    // 解析数据
    return RecommendResult.fromJSON(onValue);
  });
}

// 获取推荐列表
Future<List<FreshGoodsItem>> getRecommendListAPI({
  Map<String, dynamic>? queryParameters,
}) async {
  // 返回请求
  return await dioRequest
      .get(HttpConstants.RECOMMEND_LIST, params: queryParameters)
      .then((onValue) {
        debugPrint("数据----------$onValue");
        // 解析数据
        final list = (onValue as List).map(
          (item) => FreshGoodsItem.fromJSON(item),
        );

        debugPrint("数据hahahaha----------${list.toList()}");
        return list.toList();
      });
}

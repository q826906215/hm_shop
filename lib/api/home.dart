// 封装一个api 目的是返回业务侧要的数据结构
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  // 返回请求
  return await dioRequest.get(HttpConstants.BANNER_LIST).then((onValue) {
    print(onValue);
    final list = (onValue as List).map((item) {
      return BannerItem.fromJSON(item);
    });
    return list.toList();
  });
}

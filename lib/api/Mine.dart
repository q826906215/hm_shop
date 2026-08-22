import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/Mine.dart';

// 获取猜你喜欢商品分页列表
Future<GoodsDetailsItems> getGuessListAPI({
  Map<String, dynamic>? queryParameters,
}) async {
  // 返回请求
  return await dioRequest.get(HttpConstants.GUESS_LIST).then((onValue) {
    // 解析数据
    return GoodsDetailsItems.fromJSON(onValue);
  });
}

import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';

Future<UserInfo> loginAPI({required Map<String, dynamic> data}) async {
  // TODO: 调用登录接口
  return await dioRequest.post(HttpConstants.LOGIN, data: data).then((onValue) {
    // 解析数据
    return UserInfo.fromJson(onValue);
  });
}

Future<UserInfo> profileAPI() async {
  // TODO: 调用用户信息接口
  return await dioRequest.get(HttpConstants.PROFILE).then((onValue) {
    // 解析数据
    return UserInfo.fromJson(onValue);
  });
}

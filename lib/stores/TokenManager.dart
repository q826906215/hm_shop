import 'package:hm_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance(); // 获取SharedPreferences实例
  }

  String _token = "";

  // 注释: 初始化TokenManager
  Future<void> init() async {
    // 从SharedPreferences获取token
    final prefs = await _getInstance();
    // 如果token不存在, 则返回空字符串
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  // 注释: 保存token到SharedPreferences
  Future<void> setToken(String val) async {
    //1. 获取SharedPreferences实例
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, val); // 保存token写入持久化 磁盘
    _token = val;
  }

  // 注释: 从SharedPreferences获取token
  String getToken() {
    return _token;
  }

  // 注释: 从SharedPreferences移除token
  Future<void> removeToken() async {
    // 从SharedPreferences移除token
    final prefs = await _getInstance();
    await prefs.remove(GlobalConstants.TOKEN_KEY); // 磁盘
    _token = ""; // 内存
  }
}

final TokenManager tokenManager = TokenManager();

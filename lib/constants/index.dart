// 存放全局的常量
class GlobalConstants {
  static const String BASE_URL = "https://meikou-api.itheima.net"; // 基础地址

  static const int TIME_OUT = 10; // 超时时间

  static const String SUCCESS_CODE = "1"; // 成功状态
}

// 存放请求接口地址接口的常量
class HttpConstants {
  static const String BANNER_LIST = "/home/banner"; // 轮播图列表
  static const String CATEGORY_HEAD_LIST = "/home/category/head"; // 分类列表
  static const String HOT_PREFERENCE_LIST = "/hot/preference"; // 特惠推荐列表
  static const String HOT_IN_VOGUE_LIST = "/hot/inVogue"; // 热门推荐列表
  static const String HOT_ONE_STOP_LIST = "/hot/oneStop"; // 一站式推荐列表
  static const String RECOMMEND_LIST = "/home/recommend"; // 推荐列表
}

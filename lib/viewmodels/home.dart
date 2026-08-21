class BannerItem {
  String? id;
  String? imgUrl;
  BannerItem({required this.id, required this.imgUrl});

  // 扩展一个工厂函数 一般用factory来声明 一般用来创建实例对象
  factory BannerItem.fromJSON(Map<String, dynamic> json) {
    // 必须返回一个BannerItem对象
    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");
  }
}

// 分类项
class CategoryItem {
  String? id;
  String? name;
  String? picture;
  List<CategoryItem>? children;
  String? goods;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
    this.goods,
  });
  // 工厂转化函数 从json转换为分类项 递归处理子分类
  factory CategoryItem.fromJSON(Map<String, dynamic> json) {
    return CategoryItem(
      id: json["id"],
      name: json["name"],
      picture: json["picture"],
      children: json["children"] != null
          ? (json["children"] as List)
                .map((item) => CategoryItem.fromJSON(item))
                .toList()
          : null,
      goods: json["goods"] ?? "", // 商品列表 逗号分隔
    );
  }
}

// 特惠推荐商品项
class GoodsItem {
  String? id;
  String? name;
  String? desc;
  String? price;
  String? picture;
  int? orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });
  factory GoodsItem.fromJSON(Map<String, dynamic> json) {
    return GoodsItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      desc: json["desc"] ?? "",
      price: json["price"] ?? "",
      picture: json["picture"] ?? "",
      orderNum: json["orderNum"] ?? 0,
    );
  }
}

// 特惠推荐商品分页列表
class GoodsItems {
  int? counts;
  int? pageSize;
  int? pages;
  int? page;
  List<GoodsItem>? items;
  GoodsItems({this.counts, this.pageSize, this.pages, this.page, this.items});
  factory GoodsItems.fromJSON(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 0,
      items: json["items"] != null
          ? (json["items"] as List)
                .map((item) => GoodsItem.fromJSON(item))
                .toList()
          : null,
    );
  }
}

// 特惠推荐子分类
class SubType {
  String? id;
  String? title;
  GoodsItems? goodsItems;
  SubType({required this.id, required this.title, this.goodsItems});
  factory SubType.fromJSON(Map<String, dynamic> json) {
    return SubType(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      goodsItems: json["goodsItems"] != null
          ? GoodsItems.fromJSON(json["goodsItems"])
          : null,
    );
  }
}

// 特惠推荐结果
class RecommendResult {
  String? id;
  String? title;
  List<SubType>? subTypes;
  RecommendResult({required this.id, required this.title, this.subTypes});
  factory RecommendResult.fromJSON(Map<String, dynamic> json) {
    return RecommendResult(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      subTypes: json["subTypes"] != null
          ? (json["subTypes"] as List)
                .map((item) => SubType.fromJSON(item))
                .toList()
          : null,
    );
  }
}

// 新鲜好物商品项 扁平结构 无嵌套
class FreshGoodsItem {
  String? id;
  String? name;
  num? price; // JSON 中可能为 int 或 double 使用 num 兜底
  String? picture;
  int? payCount;
  FreshGoodsItem({this.id, this.name, this.price, this.picture, this.payCount});
  factory FreshGoodsItem.fromJSON(Map<String, dynamic> json) {
    return FreshGoodsItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      price: json["price"] ?? 0,
      picture: json["picture"] ?? "",
      payCount: json["payCount"] ?? 0,
    );
  }
}

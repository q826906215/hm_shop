// 猜你喜欢商品分页列表
import 'package:hm_shop/viewmodels/home.dart';

class GoodsDetailsItems {
  int? counts;
  int? pageSize;
  int? pages;
  int? page;
  List<FreshGoodsItem>? items;
  GoodsDetailsItems({
    this.counts,
    this.pageSize,
    this.pages,
    this.page,
    this.items,
  });
  factory GoodsDetailsItems.fromJSON(Map<String, dynamic> json) {
    return GoodsDetailsItems(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 0,
      items: json["items"] != null
          ? (json["items"] as List)
                .map((item) => FreshGoodsItem.fromJSON(item))
                .toList()
          : null,
    );
  }
}

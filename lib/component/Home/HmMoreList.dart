import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmMoreList extends StatefulWidget {
  final List<FreshGoodsItem> freshGoodsItemList;
  HmMoreList({Key? key, required this.freshGoodsItemList}) : super(key: key);

  @override
  _HmMoreListState createState() => _HmMoreListState();
}

class _HmMoreListState extends State<HmMoreList> {
  @override
  void initState() {
    super.initState();
  }

  // 商品项
  Widget _getChildren({required int index}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              errorBuilder: (context, error, stackTrace) {
                // 返回一个新的部件替换原有图片
                return Container(width: double.infinity);
              },
              widget.freshGoodsItemList[index].picture ?? "",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 6),
        Text(
          widget.freshGoodsItemList[index].name ?? "",
          style: TextStyle(
            fontSize: 18,
            overflow: TextOverflow.ellipsis,
            color: const Color.fromARGB(255, 86, 24, 20),
          ),
          maxLines: 2,
          // overflow: TextOverflow.ellipsis,
        ),
        _getPrice(index: index),
      ],
    );
  }

  // 价格和付款人数
  Widget _getPrice({required int index}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            text: "¥${widget.freshGoodsItemList[index].price}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
            children: [
              WidgetSpan(child: SizedBox(width: 5)),
              TextSpan(
                text: "${widget.freshGoodsItemList[index].price}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: "${widget.freshGoodsItemList[index].payCount}人付款",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // 必须Sliver家族的组件
    return SliverGrid.builder(
      // 网格是两列
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: widget.freshGoodsItemList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: _getChildren(index: index),
        );
      },
    );
  }
}

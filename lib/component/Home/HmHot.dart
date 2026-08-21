import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hmhot extends StatefulWidget {
  final RecommendResult recommendResult;
  final String? type;
  Hmhot({Key? key, required this.recommendResult, this.type}) : super(key: key);

  @override
  _HmhotState createState() => _HmhotState();
}

class _HmhotState extends State<Hmhot> {
  // 取前2条数据
  List<GoodsItem> get _items {
    List<SubType> list = widget.recommendResult.subTypes ?? [];
    SubType map = list.isNotEmpty ? list.first : SubType(id: '', title: '');
    List<GoodsItem> goodsItemList = map.goodsItems?.items ?? [];
    return goodsItemList.length >= 2 ? goodsItemList.take(2).toList() : [];
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.type == "hot" ? "爆款推荐" : "一站买全",
          style: TextStyle(
            color: Color.fromARGB(255, 86, 24, 10),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          widget.type == "hot" ? "最受欢迎" : "精心优选",
          style: TextStyle(
            color: Color.fromARGB(255, 101, 55, 45),
            fontSize: 12,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // 左侧结构
  List<Widget> _getChildrenList() {
    return _items.map((item) {
      return Container(
        width: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                // color: Colors.white,
                errorBuilder: (context, error, stackTrace) {
                  // 返回一个新的部件替换原有图片
                  return Container(color: Colors.white, width: 80, height: 100);
                },
                item.picture ?? "",
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "¥ ${item.price}",
              style: TextStyle(
                fontSize: 12,
                color: const Color.fromARGB(255, 86, 24, 20),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  // 完成渲染
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.type == "hot"
              ? Color.fromARGB(255, 235, 215, 215)
              : Color.fromARGB(255, 247, 247, 212),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            //顶部内容
            _buildHeader(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _getChildrenList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

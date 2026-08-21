import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSuggestion extends StatefulWidget {
  // 注释: 特惠推荐结果
  final RecommendResult recommendResult;
  HmSuggestion({Key? key, required this.recommendResult}) : super(key: key);

  @override
  _HmSuggestionState createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  // 取前3条数据
  List<GoodsItem> _getDisplayItems() {
    List<SubType> list = widget.recommendResult.subTypes ?? [];
    SubType map = list.isNotEmpty ? list.first : SubType(id: '', title: '');
    List<GoodsItem> goodsItemList = map.goodsItems?.items ?? [];
    return goodsItemList.length >= 3 ? goodsItemList.take(3).toList() : [];
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: TextStyle(
            color: Color.fromARGB(255, 86, 24, 10),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "精选省攻略",
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
  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("lib/assets/discount/share_home_bg.png"),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  // 右侧结构
  List<Widget> _getChildrenList() {
    List<GoodsItem> list = _getDisplayItems(); // 取到前3条数据
    return List.generate(list.length, (index) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              // color: Colors.white,
              errorBuilder: (context, error, stackTrace) {
                // 返回一个新的部件替换原有图片
                return Container(color: Colors.white, width: 100, height: 140);
              },
              list[index].picture ?? "",
              width: 100,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(188, 62, 80, 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "¥ ${list[index].price}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    });
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
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage("lib/assets/discount/gold_vip_back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            //顶部内容
            _buildHeader(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLeft(),
                SizedBox(width: 10),
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

import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmCategrory extends StatefulWidget {
  // 注释: 分类列表
  final List<CategoryItem> categoryList;
  // 注释: 构造函数
  const HmCategrory({super.key, required this.categoryList});

  @override
  _HmCategroryState createState() => _HmCategroryState();
}

class _HmCategroryState extends State<HmCategrory> {
  @override
  Widget build(BuildContext context) {
    // 返回一个横向滚动的组件
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: widget.categoryList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // 注释: 分类列表
          final category = widget.categoryList[index];
          return Container(
            width: 80,
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(category.picture ?? "", width: 40, height: 40),
                // 注释: 分类名称
                Text(
                  category.name ?? "",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

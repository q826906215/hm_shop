import 'package:flutter/material.dart';

class HmCategrory extends StatefulWidget {
  HmCategrory({Key? key}) : super(key: key);

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
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blue,
            width: 80,
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            child: Text("分类$index", style: TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  List<BannerItem> bannerList;
  HmSlider({super.key, required this.bannerList});

  @override
  State<StatefulWidget> createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  Widget _getSlider() {
    // 在Flutter中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width; // 屏幕宽度
    // 返回轮播图插件
    // 根据数据渲染不同的轮播选项
    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (index) {
        return Image.network(
          widget.bannerList[index].imgUrl ?? "",
          fit: BoxFit.cover,
          width: screenWidth,
        );
      }),
      options: CarouselOptions(
        height: 300,
        autoPlay: true, // 自动播放
        viewportFraction: 1, // 视窗比例
        autoPlayInterval: Duration(seconds: 5), // 自动播放时间
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // stack -> 轮播图 搜索框 指示灯导航
    return Stack(children: [_getSlider()]);
    // return Container(
    //   height: 300,
    //   color: Colors.blue,
    //   alignment: Alignment.center,
    //   child: Text("轮播图", style: TextStyle(color: Colors.white, fontSize: 20)),
    // );
  }
}

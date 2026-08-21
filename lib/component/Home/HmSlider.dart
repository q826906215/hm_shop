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
  /// 注释: CarouselSlider的Controller声明
  /// 控制轮播图跳转的控制器
  final CarouselSliderController _controller = CarouselSliderController();

  /// 注释: 轮播图索引
  int _currentIndex = 0;

  /// 注释:轮播图样式
  Widget _getSlider() {
    /// 注释:在Flutter中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width; // 屏幕宽度
    /// 返回轮播图插件
    /// 根据数据渲染不同的轮播选项
    return CarouselSlider(
      carouselController: _controller, // 绑定controller对象
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
        onPageChanged: (index, reason) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }

  /// 注释: 导航搜索栏
  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: 50,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            "搜索...",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
      // child: TextField(
      //   style: TextStyle(color: Colors.white),
      //   decoration: InputDecoration(
      //     filled: true,
      //     hintText: "搜索内容",
      //     hintStyle: TextStyle(color: Colors.white),
      //     fillColor: Colors.black54,
      //     contentPadding: EdgeInsets.all(20),
      //     border: OutlineInputBorder(
      //       borderSide: BorderSide.none,
      //       borderRadius: BorderRadius.circular(25),
      //     ),
      //   ),
      // ),
    );
  }

  /// 注释: 返回指示灯导航部件
  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerList.length, (index) {
            return GestureDetector(
              onTap: () {
                _currentIndex = index;
                _controller.animateToPage(_currentIndex);
                setState(() {});
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: index == _currentIndex ? 40 : 20,
                height: 6,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == _currentIndex
                      ? Colors.white
                      : Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // stack -> 轮播图 搜索框 指示灯导航
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);
    // return Container(
    //   height: 300,
    //   color: Colors.blue,
    //   alignment: Alignment.center,
    //   child: Text("轮播图", style: TextStyle(color: Colors.white, fontSize: 20)),
    // );
  }
}

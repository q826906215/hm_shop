import 'package:flutter/material.dart';

class Hmhot extends StatefulWidget {
  Hmhot({Key? key}) : super(key: key);

  @override
  _HmhotState createState() => _HmhotState();
}

class _HmhotState extends State<Hmhot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 200,
      alignment: Alignment.center,
      child: Text("爆款推荐", style: TextStyle(color: Colors.white)),
    );
  }
}

import 'package:flutter/material.dart';

class MineView extends StatefulWidget {
  MineView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("我的"));
  }
}

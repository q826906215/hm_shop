import 'package:flutter/material.dart';

class QuickActionsView extends StatefulWidget {
  QuickActionsView({Key? key}) : super(key: key);

  @override
  _QuickActionsViewState createState() => _QuickActionsViewState();
}

class _QuickActionsViewState extends State<QuickActionsView> {
  // 注释: 快捷入口项
  final List<Map<String, dynamic>> _quickList = [
    {"icon": Icons.star, "text": "我的收藏"},
    {"icon": Icons.favorite, "text": "我的足迹"},
    {"icon": Icons.chat, "text": "我的客服"},
  ];

  @override
  Widget build(BuildContext context) {
    return _buildQuickActions();
  }

  // 快捷入口 我的收藏/我的足迹/我的客服
  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_quickList.length, (index) {
          return _buildQuickItem(
            _quickList[index]["icon"],
            Colors.pinkAccent,
            _quickList[index]["text"],
          );
        }),
      ),
    );
  }

  // 快捷入口项
  Widget _buildQuickItem(IconData icon, Color color, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
      ],
    );
  }
}

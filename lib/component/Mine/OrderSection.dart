import 'package:flutter/material.dart';

class OrderSectionView extends StatefulWidget {
  OrderSectionView({Key? key}) : super(key: key);

  @override
  _OrderSectionViewState createState() => _OrderSectionViewState();
}

class _OrderSectionViewState extends State<OrderSectionView> {
  // 注释: 订单项
  final List<Map<String, dynamic>> _orderList = [
    {"icon": Icons.article, "text": "全部订单"},
    {"icon": Icons.wallet, "text": "待付款"},
    {"icon": Icons.local_shipping, "text": "待发货"},
    {"icon": Icons.inbox, "text": "待收货"},
    {"icon": Icons.rate_review, "text": "待评价"},
  ];
  @override
  Widget build(BuildContext context) {
    return _buildOrderSection();
  }

  // 我的订单区
  Widget _buildOrderSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 12),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "我的订单",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_orderList.length, (index) {
              Map<String, dynamic> item = _orderList[index];
              return _buildOrderItem(
                item["icon"],
                Colors.redAccent,
                item["text"],
              );
            }),
          ),
        ],
      ),
    );
  }

  // 订单项
  Widget _buildOrderItem(IconData icon, Color color, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }
}

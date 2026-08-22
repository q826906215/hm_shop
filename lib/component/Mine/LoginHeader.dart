import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';
import 'package:hm_shop/viewmodels/user.dart';

class LoginHeaderView extends StatefulWidget {
  final UserInfo data;
  LoginHeaderView({Key? key, required this.data}) : super(key: key);

  @override
  _LoginHeaderViewState createState() => _LoginHeaderViewState();
}

class _LoginHeaderViewState extends State<LoginHeaderView> {
  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(children: [_buildLoginHeader(), _buildVipBanner()]);
  }

  // 顶部登录区 渐变背景
  Widget _buildLoginHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 60, 16, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF3F4), Color(0xFFFFE8E0)],
        ),
      ),
      child: Row(
        children: [
          widget.data.id != null
              ? CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(widget.data.avatar ?? ""),
                  radius: 28,
                )
              : Container(
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pink[100],
                  ),
                  child: Icon(Icons.person, color: Colors.pink[300], size: 36),
                ), // 头像占位
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (widget.data.id?.isEmpty ?? true) {
                      // 未登录，跳转到登录页
                      Navigator.pushNamed(context, "/login");
                    }
                  },
                  child: Text(
                    widget.data.id != null ? widget.data.account ?? "" : "立即登录",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          widget.data.id != null
              ? GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("确认退出登录吗？"),
                          content: const Text("退出登录后，将无法继续使用美装商城"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("取消"),
                            ),
                            TextButton(
                              onPressed: () async {
                                // 清除token
                                await tokenManager.removeToken();
                                userController.updateUserInfo(UserInfo());
                                Navigator.pop(context);
                              },
                              child: const Text("确认"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    "退出",
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  // 会员横幅
  Widget _buildVipBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE9B88C),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.verified, color: Colors.brown[700], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "升级美装商城会员，尊享无限免邮",
              style: TextStyle(fontSize: 13, color: Colors.brown[900]),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6D2E1E),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              textStyle: const TextStyle(fontSize: 13),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text("立即开通"),
          ),
        ],
      ),
    );
  }
}

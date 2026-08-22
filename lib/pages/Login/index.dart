import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';
import 'package:hm_shop/utils/LoadingDialog.dart';
import 'package:hm_shop/utils/ToastUtils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 控制器
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();

  // 状态
  bool _agreed = false; // 是否同意协议
  bool _obscureText = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UserController userController = Get.find();

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 顶部导航栏
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 24),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        "惠多美登录",
        style: TextStyle(
          color: Colors.black87,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // 账号密码登录标题
  Widget _buildSectionTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
      child: const Text(
        "账号密码登录",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // 输入框
  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
    Widget? suffixIcon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: TextFormField(
        validator: (value) {
          // 验证非空
          if (value == null || value.isEmpty) {
            return hint;
          }
          if (controller == _accountController) {
            // 验证手机号格式
            if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
              return "请输入正确的手机号";
            }
          } else if (controller == _passwordController) {
            // 验证密码格式，只能包含字母、数字和下划线
            if (!RegExp(r'^[a-zA-Z0-9_]{6,16}$').hasMatch(value)) {
              return "密码长度必须在6-16位, 且只能包含字母、数字和下划线";
            }
          }
          return null;
        },
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(fontSize: 15, color: Colors.black87),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
          filled: true,
          fillColor: Color.fromRGBO(243, 243, 243, 1),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  // 协议勾选
  Widget _buildAgreement() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _agreed = !_agreed;
              });
            },
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _agreed ? Colors.black : Colors.transparent,
                border: Border.all(
                  color: _agreed ? Colors.black : Colors.grey,
                  width: 1.5,
                ),
              ),
              child: _agreed
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 8),
          Text.rich(
            TextSpan(
              text: "查看并同意",
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              children: [
                TextSpan(
                  text: "《隐私条款》",
                  style: const TextStyle(fontSize: 12, color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      debugPrint("隐私条款");
                    },
                ),
                TextSpan(
                  text: "和",
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                TextSpan(
                  text: "《用户协议》",
                  style: const TextStyle(fontSize: 12, color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      debugPrint("用户协议");
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 登录按钮
  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: () {
        _handleLogin();
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(24, 28, 24, 0),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: const Text(
          "登录",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // 登录处理
  Future<void> _login() async {
    Loadingdialog.showLoadingDialog(context, message: "登录中...");
    // 调用登录接口
    await loginAPI(
          data: {
            "account": _accountController.text,
            "password": _passwordController.text,
          },
        )
        .then((value) {
          // 登录成功后, 保存用户信息到UserController
          userController.updateUserInfo(value);
          tokenManager.setToken(value.token ?? ""); // 保存token到TokenManager
          Loadingdialog.hideLoadingDialog(context);
          // 登录成功后返回
          Navigator.pop(context);
        })
        .catchError((error) {
          Loadingdialog.hideLoadingDialog(context);
          // 提示登录失败
          ToastUtils.showTost(context, error.message as String);
        });
  }

  // 登录处理
  void _handleLogin() {
    // 校验表单
    if (_formKey.currentState!.validate()) {
      if (_agreed) {
        // 校验通过, 登录
        _login();
      } else {
        // 提示请勾选用户协议
        ToastUtils.showTost(context, "请勾选用户协议");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle(),
              _buildTextField(hint: "请输入账号", controller: _accountController),
              _buildTextField(
                hint: "请输入密码",
                controller: _passwordController,
                obscure: _obscureText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                    size: 22,
                  ),
                ),
              ),
              _buildAgreement(),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

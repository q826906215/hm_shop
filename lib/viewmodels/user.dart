import 'dart:async';

class UserInfo {
  String? account;
  String? avatar;
  String? birthday;
  String? cityCode;
  String? gender;
  String? id;
  String? mobile;
  String? nickname;
  String? profession;
  String? provinceCode;
  String? token;

  UserInfo({
    this.account,
    this.avatar,
    this.birthday,
    this.cityCode,
    this.gender,
    this.id,
    this.mobile,
    this.nickname,
    this.profession,
    this.provinceCode,
    this.token,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    account = json["account"] ?? '';
    avatar = json["avatar"] ?? '';
    birthday = json["birthday"] ?? '';
    cityCode = json["cityCode"] ?? '';
    gender = json["gender"] ?? '';
    id = json["id"] ?? '';
    mobile = json["mobile"] ?? '';
    nickname = json["nickname"] ?? '';
    profession = json["profession"] ?? '';
    provinceCode = json["provinceCode"] ?? '';
    token = json["token"] ?? '';
  }
}

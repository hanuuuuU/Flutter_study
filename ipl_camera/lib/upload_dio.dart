import 'dart:io';

class CameraSend {
  String usermail = 'admin@admin.com';
  String username = 'admin';
  String desc = 'test upload';
  String? access;
  File? img;

  CameraSend(
      {required this.usermail,
      required this.username,
      required this.desc,
      this.access,
      this.img});

  Map<String, dynamic> toJson() =>
      {"usermail": usermail, "username": username, "image": img};
}

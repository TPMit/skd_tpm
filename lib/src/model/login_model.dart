import 'package:flutter/material.dart';

class LoginModel {
  bool isloading = false;
  bool isSuccess = false;
  bool isErrorUsername = false;
  bool isErrorPassword = false;
  String usernameLabel = "Username";
  String passwordLabel = "Password";
  String usernameError = "";
  String passwordError = "";
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
}

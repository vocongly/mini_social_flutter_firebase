import 'package:flutter/material.dart';
import 'package:flutter_mini_social/pages/login_page.dart';
import 'package:flutter_mini_social/pages/resiger_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool showLogin = true;

  void togglePages(){
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLogin){
      return LoginPage(onTap: togglePages,);
    }else{
      return RegisterPage(onTap: togglePages,);
    }
  }
}
import 'package:flutter/material.dart';
import 'package:we_blog/auth_screens/login_page.dart';
import 'package:we_blog/auth_screens/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially show login page

  void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  bool showLoginPage = true;
  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(showRegisterPage: toggleScreens);
    } else{
      return RegisterPage(showLoginPage: toggleScreens );
    }
    
  }
}
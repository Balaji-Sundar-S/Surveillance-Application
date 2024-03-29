import 'package:flutter/material.dart';
import 'package:login_page/login_page.dart';
import 'package:login_page/signup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreens() {
    showLoginPage = !showLoginPage;
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreens);
    } else {
      return SignUserUp(showLoginPage: toggleScreens);
    }
  }
}

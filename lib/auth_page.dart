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

  toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreens());
    } else {
      return SignUserUp(showLoginPage: toggleScreens());
    }

    // return Scaffold(
    //   body: StreamBuilder<User?>(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         if (kDebugMode) {
    //           print("success");
    //         }
    //         return const HomePage();
    //       }
    //       else {
    //         return const LoginPage();
    //       }
    //     }
    //   ),
    // );
  }
}


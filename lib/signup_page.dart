import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/login_page.dart';
import 'color.dart' as Color;

class SignUserUp extends StatefulWidget {
  final VoidCallback showLoginPage;

  const SignUserUp({super.key, required this.showLoginPage});

  @override
  State<SignUserUp> createState() => _SignUserUpState();
}

class _SignUserUpState extends State<SignUserUp> {
  final email = TextEditingController();
  final pwd = TextEditingController();
  final confirmpwd = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    email.dispose();
    pwd.dispose();
    confirmpwd.dispose();
    super.dispose();
  }

  Future signUserUp() async {
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text.trim(), password: pwd.text.trim());
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop();
        displayMessage(e.code);
      }
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  bool passwordConfirmed() {
    if (pwd.text.trim() == confirmpwd.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.AppColor.homePageBackground,
        appBar: AppBar(
          backgroundColor: Color.AppColor.circuitsColor,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Register below with your Details :)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 25.0),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    fillColor: Color.AppColor.secondPageTopIconColor,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(20.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(20.0)),
                    prefixIcon: const Icon(Icons.account_circle_sharp),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                child: TextField(
                  controller: pwd,
                  obscureText: _obscureText,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    fillColor: Color.AppColor.secondPageTopIconColor,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(20.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(20.0)),
                    prefixIcon: const Icon(Icons.password),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 25.0),
                child: TextField(
                  controller: confirmpwd,
                  obscureText: _obscureText,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    fillColor: Color.AppColor.secondPageTopIconColor,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(20.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(20.0)),
                    prefixIcon: const Icon(Icons.password),
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: GestureDetector(
                  onTap: signUserUp,
                  child: Container(
                    height: 55.0,
                    width: 360.0,
                    decoration: BoxDecoration(
                      color: Color.AppColor.circuitsColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already having an account? "),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginPage(showRegisterPage: () {});
                              }));
                            },
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Color.AppColor
                                    .secondPageContainerGradient2ndColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ],
          )),
        ));
  }
}

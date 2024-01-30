import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/forgot_password_page.dart';
import 'package:login_page/signup_page.dart';
import 'color.dart' as color;

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final pwd = TextEditingController();
  var hintTextEmail = 'Enter Your Mail Id';
  var hintTextPassword = 'Enter Your Password';
  bool _obscureText = true;

  Future signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: pwd.text.trim());
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  @override
  void dispose() {
    email.dispose();
    pwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      appBar: AppBar(
        title: const Text('LogIn Page'),
        backgroundColor: color.AppColor.circuitsColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                const Icon(Icons.lock, size: 180.0),
                const Text(
                  'Enter Your Credentials to LogIn',
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
                      fillColor: color.AppColor.secondPageTopIconColor,
                      filled: true,
                      hintText: hintTextEmail,
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 25.0),
                  child: TextField(
                    controller: pwd,
                    enableSuggestions: true,
                    obscureText: _obscureText,
                    autocorrect: false,
                    decoration: InputDecoration(
                      fillColor: color.AppColor.secondPageTopIconColor,
                      hintText: hintTextPassword,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(20.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(20.0)),
                      prefixIcon: const Icon(Icons.password),
                      labelText: 'password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                const SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: GestureDetector(
                    onTap: signUserIn,
                    child: Container(
                      // padding: const EdgeInsets.all(15.0),
                      height: 55.0,
                      width: 360.0,
                      decoration: BoxDecoration(
                        color: color.AppColor.circuitsColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ForgotPassword();
                            }));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 17.0,
                              color: color
                                  .AppColor.secondPageContainerGradient2ndColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 180.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignUserUp(
                                    showLoginPage: () {},
                                  );
                                }));
                              },
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: color.AppColor
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
            ),
          ),
        ),
      ),
    );
  }
}

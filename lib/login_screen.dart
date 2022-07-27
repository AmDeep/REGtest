import 'firebase_service.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'user.dart' as user;
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = "";

  // final dbHelper = DbService.instance;
  final _fbService = FbService.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: screenHeight * 0.450,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/signIn.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 25, right: 20),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: const Center(
                      child: Text(
                        "CBX",
                        style: TextStyle(
                            color: AppColors.appLighBlueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Welcome back to CBX!",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              errorMessage.length > 2
                  ? Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // TextFormField(
                          //   controller: _nameController,
                          //   decoration: InputDecoration(
                          //     border: InputBorder.none,
                          //     hintText: 'Name',
                          //     filled: true,
                          //     fillColor:
                          //         AppColors.appLighBlueColor.withOpacity(0.3),
                          //     contentPadding: const EdgeInsets.only(
                          //       left: 14.0,
                          //       bottom: 6.0,
                          //       top: 8.0,
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: const BorderSide(
                          //           color: AppColors.appLighBlueColor),
                          //       borderRadius: BorderRadius.circular(10.0),
                          //     ),
                          //     enabledBorder: UnderlineInputBorder(
                          //       borderSide: const BorderSide(
                          //           color: AppColors.appLighBlueColor),
                          //       borderRadius: BorderRadius.circular(10.0),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              filled: true,
                              fillColor:
                                  AppColors.appLighBlueColor.withOpacity(0.3),
                              contentPadding: const EdgeInsets.only(
                                left: 14.0,
                                bottom: 6.0,
                                top: 8.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.appLighBlueColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.appLighBlueColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          // TextFormField(
                          //   controller: _passwordController,
                          //   obscureText: true,
                          //   decoration: InputDecoration(
                          //     border: InputBorder.none,
                          //     hintText: 'Password',
                          //     filled: true,
                          //     fillColor:
                          //         AppColors.appLighBlueColor.withOpacity(0.3),
                          //     contentPadding: const EdgeInsets.only(
                          //       left: 14.0,
                          //       bottom: 6.0,
                          //       top: 8.0,
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: const BorderSide(
                          //           color: AppColors.appLighBlueColor),
                          //       borderRadius: BorderRadius.circular(10.0),
                          //     ),
                          //     enabledBorder: UnderlineInputBorder(
                          //       borderSide: const BorderSide(
                          //           color: AppColors.appLighBlueColor),
                          //       borderRadius: BorderRadius.circular(10.0),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                if (_emailController.text != null &&
                                    // _nameController.text.isNotEmpty &&
                                    _emailController.text.isNotEmpty) {
                                  //do the logging here
                                  setState(() {
                                    errorMessage = "";
                                    isLoading = true;
                                  });

                                  try {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await _fbService.signInWithEmailAndPassword(
                                        _emailController.text.trim(),
                                        "1234567*8");
                                    if (_fbService.currentUser != null) {
                                      setState(() {
                                        isLoading = false;
                                      });

                                      await prefs.setBool("IS_LOGGED_IN", true);
                                      await prefs.setString("USER_ID",
                                          _fbService.currentUser!.uid);
                                      await prefs.setString("EMAIL",
                                          _emailController.text.trim());

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen(),
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                        errorMessage =
                                            "No User found, Please register first!";
                                      });
                                    }
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                      errorMessage = "Error: $e";
                                    });
                                  }
                                } else {
                                  setState(() {
                                    errorMessage =
                                        "Please enter all required inputs.";
                                  });
                                }
                              } else {
                                setState(() {
                                  _formKey.currentState?.reset();
                                });
                              }
                            },
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.appLighBlueColor),
                              child: const Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "You dont have account yet?, Create one",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  void _showMessageInScaffold(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}

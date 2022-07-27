import 'package:purityapp/firebase_service.dart';

import 'user.dart';
import 'login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = "";
  bool isLoading = false;
  final _fbService = FbService.instance;

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
                height: screenHeight * 0.45,
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
                  "Register",
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
                  "Welcome to CBX!",
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
                  ? const Center(child: CircularProgressIndicator())
                  : Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name',
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
                          const SizedBox(height: 20),
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
                          const SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                if (_nameController.text != null &&
                                    _emailController.text != null &&
                                    _nameController.text.isNotEmpty &&
                                    _emailController.text.isNotEmpty) {
                                  try {
                                    setState(() {
                                      errorMessage = "";
                                      isLoading = true;
                                    });
                                    await _fbService.signUpFirebaseUser(
                                        _nameController.text.trim(),
                                        _emailController.text.trim(),
                                        "1234567*8");
                                    if (_fbService.userid != null) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()));
                                    } else {
                                      print("HERE ${_fbService.userid}");
                                      setState(() {
                                        isLoading = false;
                                        errorMessage = "Please,try again";
                                      });
                                    }
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    _showMessageInScaffold("Error: $e");
                                  }
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
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
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          )
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

import 'dart:ui';
import 'app_colors.dart';
import 'login_screen.dart';
import 'firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FbService _fbService = FbService.instance;

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("IS_LOGGED_IN", false);
    await _fbService.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "CBX",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.appLighBlueColor,
            fontSize: 20,
          ),
        ),
        leading: Container(),
        iconTheme: const IconThemeData(color: Colors.black45),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    'Home'.toUpperCase(),
                  )),
              PopupMenuItem<int>(
                  value: 1,
                  child: Text(
                    'My Listings'.toUpperCase(),
                  )),
              PopupMenuItem<int>(
                  value: 2,
                  child: Text(
                    'My Escrows'.toUpperCase(),
                  )),
              PopupMenuItem<int>(
                value: 3,
                child: Text(
                  'Closed deals'.toUpperCase(),
                ),
              ),
              PopupMenuItem<int>(
                  value: 4,
                  child: Text(
                    'Directory'.toUpperCase(),
                  )),
              PopupMenuItem<int>(
                value: 5,
                child: Text(
                  'Logout'.toUpperCase(),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: const Text(
                "Home",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: AppColors.appLighBlueColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.appLighBlueColor, width: 0.8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "My Listings",
                      style: TextStyle(
                        color: AppColors.appLighBlueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      color: AppColors.appLighBlueColor,
                      size: 35,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: AppColors.appLighBlueColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.appLighBlueColor, width: 0.8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "My Escrows",
                      style: TextStyle(
                        color: AppColors.appLighBlueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      color: AppColors.appLighBlueColor,
                      size: 35,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: AppColors.appLighBlueColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.appLighBlueColor, width: 0.8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "Closed Deals",
                      style: TextStyle(
                        color: AppColors.appLighBlueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      color: AppColors.appLighBlueColor,
                      size: 35,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}

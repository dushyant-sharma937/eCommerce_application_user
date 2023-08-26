import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/auth_screen/phone_auth_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets/app_logo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changeScreen() {
    Future.delayed(const Duration(seconds: 5), () {
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const PhoneAuthScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: Dimensions.hundredW * 3,
              ),
            ),
            Dimensions.twentyH.heightBox,
            appLogoWidget(),
            Dimensions.tenH.heightBox,
            appname.text.fontFamily(bold).size(Dimensions.font22).white.make(),
            (Dimensions.tenH * 0.5).heightBox,
            appversion.text.white.make(),
          ],
        ),
      ),
    );
  }
}

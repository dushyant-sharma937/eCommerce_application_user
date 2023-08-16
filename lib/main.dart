import 'package:emart_app/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'consts/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: darkFontGrey),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}

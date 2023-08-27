import 'package:emart_app/views/auth_screen/provider/internet_provider.dart';
import 'package:emart_app/views/auth_screen/provider/sign_in_provider.dart';
import 'package:emart_app/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'consts/consts.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => SignInProvider())),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: appname,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          brightness: Brightness.light,
          colorScheme: const ColorScheme.light(
              background: whiteColor,
              primary: Color.fromARGB(255, 91, 180, 137)),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: darkFontGrey),
            backgroundColor: whiteColor,
            // backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          fontFamily: regular,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

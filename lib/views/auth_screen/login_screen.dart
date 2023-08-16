import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/views/auth_screen/signup_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets/app_logo_widget.dart';
import 'package:emart_app/widgets/bg_widgets.dart';
import 'package:emart_app/widgets/custom_button.dart';
import 'package:emart_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Column(
                children: [
                  10.heightBox,
                  customTextField(hint: emailHint, title: email),
                  10.heightBox,
                  customTextField(hint: passwordHint, title: password),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: "Forgot Password".text.make()),
                  ),
                  5.heightBox,
                  customButton(
                    color: redColor,
                    title: "Login",
                    textColor: whiteColor,
                    onPress: () {
                      Get.to(() => const Home());
                    },
                  ).box.width(context.screenWidth - 70).make(),
                  5.heightBox,
                  "Create a new account".text.color(fontGrey).make(),
                  5.heightBox,
                  customButton(
                    color: lightGolden,
                    title: "Sign up",
                    textColor: redColor,
                    onPress: () {
                      Get.to(() => const SignUpScreen());
                    },
                  ).box.width(context.screenWidth - 70).make(),
                  10.heightBox,
                  "Login with".text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconList[index],
                                  width: 30,
                                ),
                              ),
                            )),
                  ),
                  10.heightBox,
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(8))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}

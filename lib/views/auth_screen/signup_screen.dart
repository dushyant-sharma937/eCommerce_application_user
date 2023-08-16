import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets/app_logo_widget.dart';
import 'package:emart_app/widgets/bg_widgets.dart';
import 'package:emart_app/widgets/custom_button.dart';
import 'package:emart_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isChecked = false;
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
              "Join the $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Column(
                children: [
                  10.heightBox,
                  customTextField(hint: "admin", title: "Name"),
                  10.heightBox,
                  customTextField(hint: emailHint, title: email),
                  10.heightBox,
                  customTextField(hint: passwordHint, title: password),
                  10.heightBox,
                  customTextField(hint: passwordHint, title: "Retype Password"),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: "Forgot Password".text.make()),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (newValue) {
                          setState(() {
                            isChecked = newValue;
                          });
                        },
                        checkColor: redColor,
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: "Terms and Conditions",
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            ),
                          ),
                          TextSpan(
                            text: " & ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            ),
                          ),
                        ])),
                      )
                    ],
                  ),
                  5.heightBox,
                  customButton(
                    color: isChecked == true ? redColor : lightGrey,
                    title: "Sign up",
                    textColor: isChecked == true ? whiteColor : fontGrey,
                    onPress: () {},
                  ).box.width(context.screenWidth - 70).make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Already have an account? ".text.color(fontGrey).make(),
                      "Log in".text.color(redColor).make().onTap(() {
                        Get.back();
                      })
                    ],
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

import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget appLogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(Dimensions.hundredH * 2, Dimensions.hundredH * 2)
      .padding(EdgeInsets.all(Dimensions.eightH))
      .make();
}

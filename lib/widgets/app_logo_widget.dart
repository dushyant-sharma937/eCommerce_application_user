import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget appLogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(Dimensions.tenH * 7.7, Dimensions.tenW * 7.7)
      .padding(EdgeInsets.all(Dimensions.eightH))
      .make();
}

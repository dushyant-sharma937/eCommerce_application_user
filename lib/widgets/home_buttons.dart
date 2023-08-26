import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget homeButton({width, height, icon, String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: Dimensions.tenW * 2.6,
      ),
      Dimensions.tenH.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.rounded.white.size(width, height).make().onTap(onPress);
}

import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget homeButton({width, height, icon, String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: Dimensions.tenW * 3,
      ),
      Dimensions.tenH.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .roundedFull
      // .padding(EdgeInsets.all(8))
      .white
      .size(width, height)
      .make()
      .onTap(onPress);
}

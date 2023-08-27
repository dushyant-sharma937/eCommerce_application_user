import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget featuredRow({String? title, icon, imgColor, onPress}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Dimensions.tenW.widthBox,
      Image.asset(
        icon,
        width: Dimensions.tenW * 3,
        fit: BoxFit.fill,
        color: imgColor,
      ),
      Dimensions.tenW.widthBox,
      title!.text
          .fontFamily(semibold)
          .size(Dimensions.font14)
          .color(darkFontGrey)
          .make(),
      Dimensions.tenW.widthBox,
    ],
  )
      .box
      .width(Dimensions.hundredW * 1.8)
      .height(Dimensions.hundredH * 0.8)
      .margin(EdgeInsets.symmetric(horizontal: Dimensions.twoW * 2))
      .padding(EdgeInsets.all(Dimensions.twoW * 2))
      .white
      .roundedSM
      .outerShadowSm
      .make()
      .onTap(onPress);
}

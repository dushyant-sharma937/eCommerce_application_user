import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget featuredRow({String? title, icon}) {
  return Row(
    children: [
      Image.asset(icon, width: Dimensions.tenW * 6, fit: BoxFit.fill),
      Dimensions.tenW.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(Dimensions.hundredW * 2)
      .margin(EdgeInsets.symmetric(horizontal: Dimensions.twoW * 2))
      .padding(EdgeInsets.all(Dimensions.twoW * 2))
      .white
      .roundedSM
      .outerShadowSm
      .make();
}

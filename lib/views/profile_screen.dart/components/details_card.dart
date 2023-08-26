import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text
          .fontFamily(bold)
          .color(darkFontGrey)
          .size(Dimensions.font16)
          .make(),
      (Dimensions.tenH * 0.5).heightBox,
      title!.text.color(darkFontGrey).make()
    ],
  )
      .box
      .white
      .rounded
      .width(width)
      .height(Dimensions.hundredH * 0.8)
      .padding(EdgeInsets.all(Dimensions.twoH * 2))
      .make();
}

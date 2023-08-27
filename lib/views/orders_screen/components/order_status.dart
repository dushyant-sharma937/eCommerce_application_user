import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return Card(
    color: Colors.grey.shade100,
    // margin: EdgeInsets.all(8),
    elevation: 2,
    shadowColor: redColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          icon,
          color: color,
          size: Dimensions.tenH * 3,
        )
            .box
            .border(color: color)
            .roundedSM
            .padding(EdgeInsets.all(Dimensions.twoH * 2))
            .make(),
        // Spacer(),
        SizedBox(
          height: Dimensions.hundredH * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              "$title".text.color(darkFontGrey).size(Dimensions.font18).make(),
              Dimensions.tenW.widthBox,
              showDone
                  ? const Icon(
                      Icons.done,
                      color: Colors.red,
                    )
                  : Container()
            ],
          ).box.make(),
        ),
      ],
    ).paddingAll(8),
  );
}

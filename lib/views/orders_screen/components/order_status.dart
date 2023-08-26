import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    tileColor: Colors.grey.withOpacity(0.1),
    contentPadding: EdgeInsets.only(
        top: Dimensions.eightH,
        bottom: Dimensions.eightH,
        left: Dimensions.eightW,
        right: Dimensions.eightW),
    leading: Icon(
      icon,
      color: color,
      size: Dimensions.tenH * 3,
    )
        .box
        .border(color: color)
        .roundedSM
        .padding(EdgeInsets.all(Dimensions.twoH * 2))
        .make(),
    trailing: SizedBox(
      height: Dimensions.hundredH,
      width: Dimensions.hundredW * 1.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).size(Dimensions.font18).make(),
          showDone
              ? const Icon(
                  Icons.done,
                  color: Colors.red,
                )
              : Container()
        ],
      ),
    ),
  );
}

import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    tileColor: Colors.grey.withOpacity(0.1),
    contentPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
    leading: Icon(
      icon,
      color: color,
      size: 30,
    )
        .box
        .border(color: color)
        .roundedSM
        .padding(const EdgeInsets.all(4))
        .make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).size(18).make(),
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

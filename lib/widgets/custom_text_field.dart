import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget customTextField(
    {String? title,
    String? hint,
    controller,
    bool? isPass,
    TextInputType type = TextInputType.text}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text
          .color(redColor)
          .fontFamily(semibold)
          .size(Dimensions.sixteenH)
          .make(),
      (Dimensions.tenH * 0.5).heightBox,
      TextFormField(
        obscureText: isPass!,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
            hintText: hint!,
            hintStyle: const TextStyle(
              fontFamily: semibold,
              color: textfieldGrey,
            ),
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: redColor))),
      )
    ],
  );
}

import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDialogueBox extends StatelessWidget {
  final String text;
  final BuildContext context;
  const CustomDialogueBox(
      {super.key, required this.text, required this.context});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: context.screenHeight * 0.18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Confirm".text.fontFamily(bold).black.size(18).make(),
            10.heightBox,
            text.text.fontFamily(semibold).size(16).black.make(),
            10.heightBox,
            Row(
              children: [
                const Spacer(),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: "No"
                              .text
                              .fontFamily(bold)
                              .color(Colors.green)
                              .make()),
                      10.widthBox,
                      TextButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          child: "Yes"
                              .text
                              .fontFamily(bold)
                              .color(Colors.red)
                              .make()),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

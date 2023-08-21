import 'package:flutter/material.dart';

import '../../../consts/consts.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(children: [
        "Messages here............".text.white.size(16).make(),
        10.heightBox,
        "09:45".text.color(whiteColor.withOpacity(0.5)).make(),
      ]),
    );
  }
}

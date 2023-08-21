import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

import 'components/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Title".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.teal,
                child: ListView(
                  children: const [
                    ChatBubble(),
                    ChatBubble(),
                  ],
                ),
              ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Send a message to the Seller",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                )),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: redColor,
                  ),
                ),
              ],
            )
                .box
                .margin(const EdgeInsets.symmetric(vertical: 4, horizontal: 8))
                .height(60)
                .make(),
          ],
        ),
      ),
    );
  }
}

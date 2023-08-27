import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/chats_controller.dart';
import 'package:emart_app/services/firebase_services.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            "${controller.friendName}".text.white.fontFamily(semibold).make(),
        backgroundColor: redColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.font12),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: LoadingIndicator(),
                    )
                  : Expanded(
                      child: StreamBuilder(
                        stream: FirestoreServices.getAllMessages(
                            controller.chatDocId),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: LoadingIndicator(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return "You have no chat history, Send a message to initiate the chat"
                                .text
                                .makeCentered();
                          } else {
                            return ListView(
                              reverse: true,
                              shrinkWrap: true,
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                return Align(
                                    alignment: data['uid'] == currentUser!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: ChatBubble(data: data));
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ),
            ),
            Dimensions.tenH.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.msgController,
                  decoration: InputDecoration(
                    hintText: "Send a message to the Seller",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.twentyH))),
                  ),
                )),
                IconButton(
                  onPressed: () {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: redColor,
                  ),
                ),
              ],
            )
                .box
                .margin(EdgeInsets.symmetric(
                    vertical: Dimensions.twoH * 2,
                    horizontal: Dimensions.eightW))
                .height(Dimensions.tenH * 6)
                .make(),
          ],
        ),
      ),
    );
  }
}

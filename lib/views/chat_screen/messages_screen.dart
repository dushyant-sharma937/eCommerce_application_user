import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firebase_services.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Messages".text.white.fontFamily(semibold).make(),
        backgroundColor: redColor,
        foregroundColor: whiteColor,
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getChatMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: LoadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No messages yet!".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: EdgeInsets.all(Dimensions.eightH),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 2,
                            shadowColor: redColor,
                            color: Colors.grey.shade100,
                            child: ListTile(
                              onTap: () {
                                Get.to(() => const ChatScreen(), arguments: [
                                  data[index]['friend_name'],
                                  data[index]['toId'],
                                ]);
                              },
                              leading: const CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              title: "${data[index]['friend_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              subtitle:
                                  "${data[index]['last_msg']}".text.make(),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

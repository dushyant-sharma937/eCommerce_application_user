import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  User? currentUser = auth.currentUser;
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatCollections);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.find<HomeController>().username;

  var msgController = TextEditingController();

  var isLoading = false.obs;

  dynamic chatDocId;

  getChatId() async {
    isLoading.value = true;
    await chats
        .where('users', isEqualTo: {
          friendId: null,
          currentUser!.uid: null,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': "",
              'users': {friendId: null, currentUser!.uid: null},
              'toId': "",
              'fromId': "",
              'friend_name': friendName,
              'sender_name': senderName,
            }).then((value) => chatDocId = value.id);
          }
        });
    isLoading.value = false;
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentUser!.uid,
      });

      chats.doc(chatDocId).collection(messagesCollections).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentUser!.uid,
      });
    }
  }
}

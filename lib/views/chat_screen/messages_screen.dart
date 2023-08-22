import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firebase_services.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
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
            return Container();
          }
        },
      ),
    );
  }
}

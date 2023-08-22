import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firebase_services.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: LoadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No item are added yet!"
                .text
                .color(darkFontGrey)
                .makeCentered();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

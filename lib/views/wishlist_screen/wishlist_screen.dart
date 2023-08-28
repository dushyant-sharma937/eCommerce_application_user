import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firebase_services.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? currentUser = auth.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "My Wishlist".text.color(whiteColor).fontFamily(semibold).make(),
        backgroundColor: redColor,
        foregroundColor: whiteColor,
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
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Image.network(
                              "${data[index]['p_imgs'][0]}",
                              height: Dimensions.hundredH * 0.5,
                              width: Dimensions.hundredW * 0.5,
                              fit: BoxFit.cover,
                            ),
                            title: "${data[index]['p_name']}"
                                .text
                                .fontFamily(semibold)
                                .make(),
                            subtitle: "${data[index]['p_price']}"
                                .numCurrency
                                .text
                                .color(Colors.red)
                                .fontFamily(semibold)
                                .make(),
                            trailing: IconButton(
                              onPressed: () async {
                                await firestore
                                    .collection(productCollections)
                                    .doc(data[index].id)
                                    .set({
                                  'p_wishlist':
                                      FieldValue.arrayRemove([currentUser!.uid])
                                }, SetOptions(merge: true));
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ));
                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

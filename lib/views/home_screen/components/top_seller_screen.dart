import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/firebase_services.dart';

class TopSellerScreen extends StatelessWidget {
  const TopSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Top Sellers".text.bold.white.make(),
        backgroundColor: redColor,
        foregroundColor: whiteColor,
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllProducts(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                color: redColor,
              ));
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child: "There are no popular products right now"
                      .text
                      .bold
                      .black
                      .make());
            } else {
              var data = snapshot.data!.docs;
              data = data.sortedBy((a, b) =>
                  b['p_wishlist'].length.compareTo(a['p_wishlist'].length));

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Popular Products"
                            .text
                            .black
                            .size(Dimensions.font16)
                            .make(),
                        ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: List.generate(data.length, (index) {
                            return data[index]['p_wishlist'].length == 0
                                ? const SizedBox()
                                : Card(
                                    margin: const EdgeInsets.all(8),
                                    color: Colors.grey.shade100,
                                    child: ListTile(
                                      onTap: () {
                                        Get.to(() => ItemDetails(
                                              title: data[index]['p_name'],
                                              data: data[index],
                                            ));
                                      },
                                      leading: Image.network(
                                          data[index]['p_imgs'][0],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover),
                                      title: "${data[index]['p_name']}"
                                          .text
                                          .black
                                          .bold
                                          .make(),
                                      subtitle: "${data[index]['p_price']}"
                                          .text
                                          .color(Colors.red)
                                          .make(),
                                    ),
                                  );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}

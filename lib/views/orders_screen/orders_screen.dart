import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firebase_services.dart';
import 'package:emart_app/views/orders_screen/orders_details.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: redColor,
        title: "My Orders".text.white.fontFamily(semibold).make(),
        foregroundColor: whiteColor,
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: LoadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Orders yet!".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            data = data
                .sortedBy((a, b) => b['order_code'].compareTo(a['order_code']));
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: SizedBox(
                      width: Dimensions.hundredW,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "${index + 1}."
                              .text
                              .fontFamily(bold)
                              .color(darkFontGrey)
                              .make(),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black54),
                            ),
                            child: Image.network(
                              "${data[index]['orders'][0]['img']}",
                              fit: BoxFit.fill,
                              width: Dimensions.hundredW * 0.8,
                              height: Dimensions.hundredH * 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: data[index]['order_code']
                        .toString()
                        .text
                        .color(redColor)
                        .fontFamily(semibold)
                        .make(),
                    subtitle: data[index]['total_amount']
                        .toString()
                        .numCurrency
                        .text
                        .fontFamily(bold)
                        .make(),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Get.to(() => OrdersDetails(data: data[index]));
                    },
                  );
                });
          }
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/services/firebase_services.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: redColor,
        automaticallyImplyLeading: false,
        title: "Your Cart".text.white.fontFamily(bold).size(22).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getCartProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: LoadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "The Cart is Empty"
                    .text
                    .fontFamily(semibold)
                    .size(18)
                    .color(darkFontGrey)
                    .make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculatePrice(data);
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Image.network(
                                  "${data[index]['img']}",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: "${data[index]['title']}"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                subtitle:
                                    "${data[index]['tprice'] / data[index]['quantity']}"
                                        .numCurrency
                                        .text
                                        .color(Colors.red)
                                        .fontFamily(semibold)
                                        .make(),
                                trailing: SizedBox(
                                  width: context.width * 0.4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      "x${data[index]['quantity']}"
                                          .text
                                          .fontFamily(semibold)
                                          .make(),
                                      IconButton(
                                        onPressed: () {
                                          FirestoreServices.deleteCartProduct(
                                              data[index].id);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })),
                    Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: lightGolden,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: context.height * 0.05,
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Total"
                                .text
                                .black
                                .fontFamily(semibold)
                                .size(18)
                                .make(),
                            "${controller.tprice.value}"
                                .numCurrency
                                .text
                                .black
                                .fontFamily(semibold)
                                .size(18)
                                .make(),
                          ],
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.red,
                      minWidth: context.width * 0.9,
                      elevation: 2,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: "Proceed to shipping"
                          .text
                          .size(18)
                          .white
                          .fontFamily(semibold)
                          .make(),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}

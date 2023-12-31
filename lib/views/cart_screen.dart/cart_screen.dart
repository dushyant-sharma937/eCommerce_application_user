import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/services/firebase_services.dart';
import 'package:emart_app/views/cart_screen.dart/shipping_screen.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? currentUser = auth.currentUser;
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: redColor,
        automaticallyImplyLeading: false,
        title: "Your Cart"
            .text
            .white
            .fontFamily(bold)
            .size(Dimensions.font22)
            .make(),
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
                    .size(Dimensions.font18)
                    .color(darkFontGrey)
                    .make(),
              );
            } else {
              // prod data

              var data = snapshot.data!.docs;
              controller.calculatePrice(data);
              controller.productSnapshot = data;
              return Padding(
                padding: EdgeInsets.all(Dimensions.twelveH),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Image.network(
                                  "${data[index]['img']}",
                                  height: Dimensions.tenH * 5,
                                  width: Dimensions.tenW * 5,
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
                                        onPressed: () async {
                                          await controller
                                              .deleteCartProduct(data[index]);
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
                      margin: EdgeInsets.all(Dimensions.twoH * 2),
                      padding: EdgeInsets.all(Dimensions.twoH * 2),
                      decoration: BoxDecoration(
                        color: lightGolden,
                        borderRadius:
                            BorderRadius.circular(Dimensions.tenH * 0.5),
                      ),
                      height: context.height * 0.05,
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Total : "
                                .text
                                .black
                                .fontFamily(semibold)
                                .size(Dimensions.font18)
                                .make(),
                            "${controller.tprice.value}"
                                .numCurrency
                                .text
                                .black
                                .fontFamily(semibold)
                                .size(Dimensions.font18)
                                .make(),
                          ],
                        ),
                      ),
                    ),
                    Dimensions.twelveH.heightBox,
                    MaterialButton(
                      onPressed: () async {
                        await controller.getAddress();
                        Get.to(() => const ShippingScreen());
                      },
                      color: Colors.red,
                      minWidth: context.width,
                      height: Dimensions.tenH * 6,
                      elevation: 2,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimensions.tenH)),
                      child: "Proceed to shipping"
                          .text
                          .size(Dimensions.font18)
                          .white
                          .fontFamily(semibold)
                          .make(),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}

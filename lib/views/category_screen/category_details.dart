import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/services/firebase_services.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:emart_app/widgets/bg_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/loading_indicator.dart';

class CategoryDetails extends StatefulWidget {
  final String title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  var controller = Get.find<ProductController>();
  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: redColor,
              title: widget.title.text.fontFamily(bold).white.make(),
              iconTheme: const IconThemeData(color: whiteColor),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dimensions.tenH.heightBox,
                StreamBuilder(
                    stream: FirestoreServices.getCategoryProducts(widget.title),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: LoadingIndicator());
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: "No products available".text.white.make(),
                        );
                      } else {
                        var data = snapshot.data!.docs;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dimensions.twelveH),
                            child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        mainAxisExtent: 250),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        "${data[index]['p_imgs'][0]}",
                                        width: Dimensions.hundredW * 2,
                                        height: Dimensions.hundredH * 1.5,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      const Divider(
                                        thickness: 2,
                                        color: Colors.black45,
                                      ),
                                      "${data[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      Dimensions.tenH.heightBox,
                                      "${data[index]['p_price']}"
                                          .numCurrency
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .make(),
                                    ],
                                  )
                                      .box
                                      .margin(EdgeInsets.symmetric(
                                          horizontal: Dimensions.twoW * 2))
                                      .white
                                      .roundedSM
                                      .outerShadowSm
                                      .padding(
                                          EdgeInsets.all(Dimensions.twelveH))
                                      .make()
                                      .onTap(() {
                                    Get.to(() => ItemDetails(
                                          title: "${data[index]['p_name']}",
                                          data: data[index],
                                        ));
                                  });
                                }),
                          ),
                        );
                      }
                    }),
              ],
            )));
  }
}

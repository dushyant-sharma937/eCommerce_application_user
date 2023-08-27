import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:emart_app/services/firebase_services.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../category_screen/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String searchText;
  const SearchScreen({super.key, required this.searchText});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            searchText.text.color(Colors.black87).fontFamily(semibold).make(),
        leading: IconButton(
            onPressed: () {
              Get.back();
              controller.searchController.clear();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: FirestoreServices.getSearchedProducts(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: LoadingIndicator());
              } else {
                var data = snapshot.data!.docs;
                var filteredData = data
                    .where((element) => element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                    .toList();
                return Padding(
                  padding: EdgeInsets.all(Dimensions.eightH),
                  child: filteredData.isEmpty
                      ? "No products found from your search!\nTry changing the spelling"
                          .text
                          .fontFamily(semibold)
                          .color(fontGrey)
                          .size(Dimensions.font18)
                          .align(TextAlign.center)
                          .makeCentered()
                      : GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  mainAxisExtent: 300),
                          children: filteredData
                              .mapIndexed((currentValue, index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        filteredData[index]['p_imgs'][0],
                                        width: Dimensions.hundredW * 2,
                                        height: Dimensions.hundredH * 2,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      const Spacer(),
                                      "${filteredData[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      Dimensions.tenH.heightBox,
                                      "${filteredData[index]['p_price']}"
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
                                      .outerShadowMd
                                      .padding(
                                          EdgeInsets.all(Dimensions.twelveH))
                                      .make()
                                      .onTap(() {
                                    Get.to(() => ItemDetails(
                                        title: filteredData[index]['p_name'],
                                        data: filteredData[index]));
                                  }))
                              .toList(),
                        ),
                );
              }
            }),
      ),
    );
  }
}

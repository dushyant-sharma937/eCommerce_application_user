import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: searchText.text.color(darkFontGrey).fontFamily(semibold).make(),
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
                  padding: const EdgeInsets.all(8.0),
                  child: filteredData.isEmpty
                      ? "No products found from your search!\nTry changing the spelling"
                          .text
                          .fontFamily(semibold)
                          .color(fontGrey)
                          .size(18)
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
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      const Spacer(),
                                      "${filteredData[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "${filteredData[index]['p_price']}"
                                          .numCurrency
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .make(),
                                    ],
                                  )
                                      .box
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .white
                                      .roundedSM
                                      .outerShadowMd
                                      .padding(const EdgeInsets.all(12))
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

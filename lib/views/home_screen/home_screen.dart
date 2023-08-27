import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:emart_app/services/firebase_services.dart';
import 'package:emart_app/views/category_screen/category_screen.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:emart_app/views/home_screen/components/search_screen.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/featured_button.dart';
import 'components/top_seller_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: "E-Mart Application".text.bold.make(),
        automaticallyImplyLeading: false,
        backgroundColor: redColor,
      ),
      body: Container(
        color: lightGrey,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
            child: Column(
          children: [
            // search bar
            Container(
              height: Dimensions.tenH * 6,
              alignment: Alignment.center,
              width: double.infinity,
              color: redColor,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: whiteColor,
                  filled: true,
                  hintText: searchAnything,
                  hintStyle: const TextStyle(
                    color: fontGrey,
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: fontGrey,
                  ).onTap(() {
                    if (controller.searchController.text
                        .trim()
                        .isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            searchText: controller.searchController.text.trim(),
                          ));
                    }
                  }),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // swipers brands
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        height: Dimensions.tenH * 25,
                        enlargeCenterPage: true,
                        itemCount: slidersList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            slidersList[index],
                            fit: BoxFit.cover,
                          )
                              .box
                              .color(redColor)
                              .width(Dimensions.screenWidth)
                              .clip(Clip.antiAlias)
                              .make();
                        }),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Dimensions.tenH.heightBox,

                        // top category tiles
                        Align(
                            alignment: Alignment.centerLeft,
                            child: featuredCategories.text
                                .color(darkFontGrey)
                                .size(Dimensions.font18)
                                .fontFamily(semibold)
                                .make()),
                        Dimensions.twentyH.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            featuredRow(
                                icon: icCategories,
                                title: topCategories,
                                imgColor: Colors.red,
                                onPress: () {
                                  Get.to(() => const CategoryScreen());
                                }),
                            Dimensions.tenH.heightBox,
                            featuredRow(
                                icon: icTopSeller,
                                title: topSeller,
                                imgColor: golden,
                                onPress: () {
                                  Get.to(() => const TopSellerScreen());
                                }),
                            Dimensions.tenH.heightBox,
                          ]).paddingSymmetric(horizontal: 8),
                        ),

                        Dimensions.tenH.heightBox,
                        Dimensions.tenH.heightBox,
                        featuredProduct.text.black
                            .fontFamily(bold)
                            .align(TextAlign.start)
                            .size(Dimensions.font18)
                            .make(),
                        (Dimensions.tenH * 0.5).heightBox,
                        // featured products
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.twelveH,
                              horizontal: Dimensions.twoW * 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.eightW)),
                              image: const DecorationImage(
                                  image: AssetImage(icSplashBgCropTwo),
                                  // image: AssetImage(icSplashBgCrop),
                                  fit: BoxFit.fill)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: StreamBuilder(
                                    stream:
                                        FirestoreServices.getFeaturedProducts(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                            child: LoadingIndicator());
                                      } else if (snapshot.data!.docs.isEmpty) {
                                        return "No featured products are available right now"
                                            .text
                                            .white
                                            .make();
                                      } else {
                                        var featuredProductData =
                                            snapshot.data!.docs;
                                        return Row(
                                          children: List.generate(
                                              featuredProductData.length,
                                              (index) => Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.network(
                                                        "${featuredProductData[index]['p_imgs'][0]}",
                                                        width: Dimensions
                                                                .hundredW *
                                                            1.5,
                                                        height: Dimensions
                                                                .hundredH *
                                                            1.2,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      Dimensions.tenH.heightBox,
                                                      "${featuredProductData[index]['p_name']}"
                                                          .text
                                                          .fontFamily(semibold)
                                                          .color(darkFontGrey)
                                                          .make(),
                                                      Dimensions.tenH.heightBox,
                                                      "${featuredProductData[index]['p_price']}"
                                                          .text
                                                          .color(redColor)
                                                          .fontFamily(bold)
                                                          .make(),
                                                    ],
                                                  )
                                                      .box
                                                      .margin(EdgeInsets.symmetric(
                                                          horizontal: Dimensions
                                                                  .twelveW *
                                                              2))
                                                      .white
                                                      .roundedSM
                                                      .padding(
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  Dimensions
                                                                      .eightW,
                                                              vertical:
                                                                  Dimensions
                                                                      .eightH))
                                                      .make()
                                                      .onTap(() {
                                                    Get.to(() => ItemDetails(
                                                        title:
                                                            "${featuredProductData[index]['p_name']}",
                                                        data:
                                                            featuredProductData[
                                                                index]));
                                                  })),
                                        );
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),

                        // all products section
                        Dimensions.twentyH.heightBox,
                        StreamBuilder(
                            stream: FirestoreServices.getAllProducts(),
                            builder: ((BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(child: LoadingIndicator());
                              } else {
                                var allProduct = snapshot.data!.docs;
                                return GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: allProduct.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 12,
                                            mainAxisSpacing: 12,
                                            mainAxisExtent: 300),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            allProduct[index]['p_imgs'][0],
                                            width: Dimensions.hundredW * 2,
                                            height: Dimensions.hundredH * 2,
                                            fit: BoxFit.fitWidth,
                                          ),
                                          const Spacer(),
                                          "${allProduct[index]['p_name']}"
                                              .text
                                              .fontFamily(semibold)
                                              .color(darkFontGrey)
                                              .make(),
                                          Dimensions.tenH.heightBox,
                                          "${allProduct[index]['p_price']}"
                                              .numCurrency
                                              .text
                                              .color(redColor)
                                              .fontFamily(bold)
                                              .make(),
                                        ],
                                      )
                                          .box
                                          .margin(EdgeInsets.symmetric(
                                              horizontal: Dimensions.twoH * 2))
                                          .white
                                          .roundedSM
                                          .padding(EdgeInsets.symmetric(
                                              horizontal: Dimensions.twelveW,
                                              vertical: Dimensions.twelveH))
                                          .make()
                                          .onTap(() {
                                        Get.to(() => ItemDetails(
                                            title: allProduct[index]['p_name'],
                                            data: allProduct[index]));
                                      });
                                    });
                              }
                            }))
                      ],
                    ).paddingAll(Dimensions.eightH),
                    // category buttons
                  ],
                ),
              ),
            )
          ],
        )),
      ).onTap(() {
        FocusManager.instance.primaryFocus?.unfocus();
      }),
    );
  }
}

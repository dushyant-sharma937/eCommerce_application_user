import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:emart_app/services/firebase_services.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:emart_app/views/home_screen/components/featured_button.dart';
import 'package:emart_app/views/home_screen/components/search_screen.dart';
import 'package:emart_app/widgets/home_buttons.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
      color: lightGrey,
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.twelveH, vertical: Dimensions.twelveW),
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          // search bar
          Container(
            height: Dimensions.tenH * 6,
            alignment: Alignment.center,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: whiteColor,
                filled: true,
                hintText: searchAnything,
                hintStyle: const TextStyle(
                  color: Colors.black54,
                ),
                suffixIcon: const Icon(Icons.search).onTap(() {
                  if (controller.searchController.text
                      .trim()
                      .isNotEmptyAndNotNull) {
                    Get.to(() => SearchScreen(
                          searchText: controller.searchController.text.trim(),
                        ));
                    controller.searchController.clear();
                  }
                }),
              ),
            ),
          ),

          Dimensions.tenH.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // swipers brands
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: Dimensions.tenH * 15,
                      enlargeCenterPage: true,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(EdgeInsets.symmetric(
                                horizontal: Dimensions.eightW))
                            .make();
                      }),

                  Dimensions.tenH.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButton(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 2.5,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              title: index == 0 ? todaysDeal : flashSale,
                            )),
                  ),
                  // 2nd swiper
                  Dimensions.tenH.heightBox,
                  // swiper brands
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: Dimensions.hundredH * 1.5,
                      enlargeCenterPage: true,
                      itemCount: secondSlidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSlidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(EdgeInsets.symmetric(
                                horizontal: Dimensions.eightW))
                            .make();
                      }),

                  // category buttons
                  Dimensions.tenH.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => homeButton(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 3.5,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title: index == 0
                                  ? topCategories
                                  : index == 1
                                      ? brand
                                      : topSeller,
                            )),
                  ),

                  // featured Categories
                  Dimensions.twentyH.heightBox,
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
                    child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredRow(
                                        icon: featuredImages1[index],
                                        title: featuredTitles1[index]),
                                    Dimensions.tenH.heightBox,
                                    featuredRow(
                                        icon: featuredImages2[index],
                                        title: featuredTitles2[index]),
                                  ],
                                ))),
                  ),

                  // featured products
                  Dimensions.twentyH.heightBox,
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.twelveH,
                        horizontal: Dimensions.twoW * 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.eightW)),
                        image: const DecorationImage(
                            image: AssetImage(icSplashBgCrop),
                            fit: BoxFit.fill)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text.white
                            .fontFamily(bold)
                            .size(Dimensions.font18)
                            .make(),
                        Dimensions.tenH.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: StreamBuilder(
                              stream: FirestoreServices.getFeaturedProducts(),
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
                                  var featuredProductData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                        featuredProductData.length,
                                        (index) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  "${featuredProductData[index]['p_imgs'][0]}",
                                                  width:
                                                      Dimensions.hundredW * 1.5,
                                                  height:
                                                      Dimensions.hundredH * 1.2,
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
                                                    horizontal:
                                                        Dimensions.twelveW * 2))
                                                .white
                                                .roundedSM
                                                .padding(EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimensions.eightW,
                                                    vertical:
                                                        Dimensions.eightH))
                                                .make()
                                                .onTap(() {
                                              Get.to(() => ItemDetails(
                                                  title:
                                                      "${featuredProductData[index]['p_name']}",
                                                  data: featuredProductData[
                                                      index]));
                                            })),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),

                  // third swiper
                  Dimensions.twentyH.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: Dimensions.hundredH * 1.5,
                      enlargeCenterPage: true,
                      itemCount: secondSlidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSlidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(EdgeInsets.symmetric(
                                horizontal: Dimensions.eightW))
                            .make();
                      }),

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
                              physics: const NeverScrollableScrollPhysics(),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
              ),
            ),
          )
        ],
      )),
    );
  }
}

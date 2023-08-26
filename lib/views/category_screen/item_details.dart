import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        controller.quantity(0);
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  controller.quantity(0);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            title: title.text.color(darkFontGrey).fontFamily(bold).make(),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                  )),
              IconButton(
                  onPressed: () async {
                    if (controller.isFav.value) {
                      await controller.removeFromWishlist(data.id, context);
                    } else {
                      await controller.addToWishlist(data.id, context);
                    }
                  },
                  icon: Icon(
                    // controller.isFav.value
                    data['p_wishlist'].length > 0
                        ? Icons.favorite
                        : Icons.favorite_outline_rounded,
                    color: data['p_wishlist'].length > 0
                        ? Colors.red
                        : Colors.black,
                  )),
            ]),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(Dimensions.eightH),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // swiper Section
                      VxSwiper.builder(
                          height: Dimensions.hundredH * 3.5,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          itemCount: data['p_imgs'].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data['p_imgs'][index],
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                            );
                          }),
                      Dimensions.tenH.heightBox,
                      // title and details section
                      title.text
                          .size(Dimensions.font16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),

                      Dimensions.tenH.heightBox,
                      "Effective price: ${data['p_price']}"
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(Dimensions.font18)
                          .make(),
                      Dimensions.tenH.heightBox,
                      "Mrp: 16000"
                          .text
                          .color(Colors.red)
                          .fontFamily(semibold)
                          .size(Dimensions.font14)
                          .make(),
                      Dimensions.tenH.heightBox,
                      VxRating(
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: Dimensions.tenH * 2.5,
                        maxRating: 5,
                        isSelectable: false,
                        stepInt: false,
                      ),

                      Dimensions.tenH.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller"
                                  .text
                                  .white
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              (Dimensions.tenH * 0.5).heightBox,
                              "${data['p_seller']}"
                                  .text
                                  .color(darkFontGrey)
                                  .fontFamily(semibold)
                                  .make()
                            ],
                          )),
                          CircleAvatar(
                            backgroundColor: whiteColor,
                            child: const Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ).onTap(() {
                              Get.to(() => const ChatScreen(), arguments: [
                                data['p_seller'],
                                data['vendor_id']
                              ]);
                            }),
                          )
                        ],
                      )
                          .box
                          .height(Dimensions.tenH * 6)
                          .padding(EdgeInsets.symmetric(
                              horizontal: Dimensions.sixteenW))
                          .color(textfieldGrey)
                          .make(),

                      // color section
                      20.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            // quantity row
                            Row(
                              children: [
                                SizedBox(
                                  width: Dimensions.hundredW,
                                  child: "Quantity: "
                                      .text
                                      .color(textfieldGrey)
                                      .color(darkFontGrey)
                                      .fontFamily(bold)
                                      .make(),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          if (controller.quantity > 0) {
                                            controller.quantity--;
                                          }
                                        },
                                        icon: const Icon(Icons.remove)),
                                    controller.quantity
                                        .toString()
                                        .text
                                        .size(Dimensions.font16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          if (controller.quantity <
                                              int.parse(data['p_quantity'])) {
                                            controller.quantity++;
                                          }
                                        },
                                        icon: const Icon(Icons.add)),
                                    Dimensions.tenW.widthBox,
                                    "(${data['p_quantity']} available)"
                                        .text
                                        .color(fontGrey)
                                        .make(),
                                  ],
                                )
                              ],
                            )
                                .box
                                .padding(EdgeInsets.all(Dimensions.eightH))
                                .make(),

                            // total Row
                            Row(
                              children: [
                                SizedBox(
                                  width: Dimensions.hundredW,
                                  child: "Total: "
                                      .text
                                      .color(textfieldGrey)
                                      .color(darkFontGrey)
                                      .fontFamily(bold)
                                      .make(),
                                ),
                                "${controller.quantity * (int.parse(data['p_price']))}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .size(Dimensions.font16)
                                    .fontFamily(bold)
                                    .make()
                              ],
                            )
                                .box
                                .padding(EdgeInsets.all(Dimensions.eightH))
                                .make(),
                          ],
                        ).box.white.shadowSm.make(),
                      ),

                      // description section
                      Dimensions.tenH.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      Dimensions.tenH.heightBox,
                      "${data['p_desc']}".text.color(darkFontGrey).make(),
                      Dimensions.tenH.heightBox,

                      // // buttons section
                      // ListView(
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   children: List.generate(
                      //       itemDetailButtonsList.length,
                      //       (index) => ListTile(
                      //             title: itemDetailButtonsList[index]
                      //                 .text
                      //                 .fontFamily(semibold)
                      //                 .color(darkFontGrey)
                      //                 .make(),
                      //             trailing: const Icon(Icons.arrow_forward),
                      //           )),
                      // ),
                      // Dimensions.tenH.heightBox,
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: Dimensions.hundredW * 0.6,
              child: customButton(
                  color: redColor,
                  onPress: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                          title: data['p_name'],
                          vendorId: data['vendor_id'],
                          context: context,
                          imageUrl: data['p_imgs'][0],
                          qty: controller.quantity.value,
                          sellername: data['p_seller'],
                          tprice: controller.quantity.value *
                              (int.parse(data['p_price'])));
                      VxToast.show(context, msg: "Added to cart");
                    } else {
                      VxToast.show(context,
                          msg: "Please select products to add to cart");
                    }
                  },
                  textColor: whiteColor,
                  title: "Add to cart"),
            )
          ],
        ),
      ),
    );
  }
}

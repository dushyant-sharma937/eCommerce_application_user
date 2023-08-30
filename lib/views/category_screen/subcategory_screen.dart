import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category_screen/category_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Sub Categories".text.fontFamily(bold).white.make(),
        iconTheme: const IconThemeData(color: whiteColor),
        backgroundColor: redColor,
      ),
      body: Container(
        padding: EdgeInsets.all(Dimensions.twelveH),
        child: GridView.builder(
            itemCount: controller.subcat.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: Dimensions.hundredH * 2.5),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      "${controller.subcatImg[index]}",
                      height: Dimensions.hundredH * 2,
                      width: Dimensions.hundredW * 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  (Dimensions.tenH * 1.5).heightBox,
                  "${controller.subcat[index]}"
                      .text
                      .fontWeight(FontWeight.w600)
                      .size(16)
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .makeCentered()
                ],
              )
                  .box
                  .color(Colors.grey.shade300)
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadowSm
                  .shadowSm
                  .make()
                  .onTap(() {
                Get.to(() => CategoryDetails(title: categoriesList[index]));
              });
            }),
      ),
    );
  }
}

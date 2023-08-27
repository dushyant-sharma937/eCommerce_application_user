import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category_screen/category_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Categories".text.fontFamily(bold).white.make(),
        iconTheme: const IconThemeData(color: whiteColor),
        backgroundColor: redColor,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(Dimensions.twelveH),
        child: GridView.builder(
            itemCount: 9,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: Dimensions.hundredH * 2),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Dimensions.tenH.heightBox,
                  Image.asset(
                    categoryImages[index],
                    height: Dimensions.hundredH * 1.2,
                    width: Dimensions.hundredW * 2,
                    fit: BoxFit.cover,
                  ),
                  Dimensions.tenH.heightBox,
                  categoriesList[index]
                      .text
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make()
                ],
              )
                  .box
                  .white
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadowSm
                  .make()
                  .onTap(() {
                controller.getSubCategories(
                    categoryTitle: categoriesList[index]);
                Get.to(() => CategoryDetails(title: categoriesList[index]));
              });
            }),
      ),
    );
  }
}

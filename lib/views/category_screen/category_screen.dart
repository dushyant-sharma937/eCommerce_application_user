import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category_screen/subcategory_screen.dart';
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
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: Dimensions.hundredH * 2.6),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      categoryImages[index],
                      height: Dimensions.hundredH * 2,
                      width: Dimensions.hundredW * 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  (Dimensions.tenH * 1.5).heightBox,
                  categoriesList[index]
                      .text
                      .fontWeight(FontWeight.w600)
                      .size(16)
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make(),
                ],
              )
                  .box
                  .color(Colors.grey.shade300)
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadowSm
                  .shadowSm
                  .make()
                  .onTap(() async {
                await controller.getSubCategories(
                    categoryTitle: categoriesList[index]);
                Get.to(() => SubCategoryScreen());
              });
            }),
      ),
    );
  }
}

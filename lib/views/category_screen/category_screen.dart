import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category_screen/category_details.dart';
import 'package:emart_app/widgets/bg_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: "Categories".text.fontFamily(bold).white.make(),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        iconTheme: const IconThemeData(color: whiteColor),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(Dimensions.twelveH),
        child: GridView.builder(
            itemCount: 9,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
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
    ));
  }
}

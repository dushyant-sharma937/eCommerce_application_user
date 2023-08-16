import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:emart_app/widgets/bg_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: title.text.fontFamily(bold).white.make(),
        iconTheme: const IconThemeData(color: whiteColor),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(
                    6,
                    (index) => "Baby Clothing"
                        .text
                        .size(12)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .makeCentered()
                        .box
                        .rounded
                        .white
                        .size(150, 60)
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .make()),
              ),
            ),
            20.heightBox,
            // items Container
            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 250),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          imgP5,
                          width: 200,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        "Women Gucci Bag"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        10.heightBox,
                        "\$6000000"
                            .text
                            .color(redColor)
                            .fontFamily(bold)
                            .make(),
                      ],
                    )
                        .box
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .white
                        .roundedSM
                        .outerShadowSm
                        .padding(const EdgeInsets.all(12))
                        .make()
                        .onTap(() {
                      Get.to(() => const ItemDetails(title: "Dummy title"));
                    });
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}

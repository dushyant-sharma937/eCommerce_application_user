import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/views/profile_screen.dart/components/details_card.dart';
import 'package:emart_app/widgets/bg_widgets.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      body: SafeArea(
          child: Column(children: [
        //user details section
        10.heightBox,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Image.asset(
                imgProfile2,
                width: 100,
                fit: BoxFit.cover,
              ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.widthBox,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Dummy User".text.fontFamily(semibold).white.make(),
                  5.heightBox,
                  "customer@example.com".text.white.make(),
                ],
              )),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                    color: whiteColor,
                  )),
                  onPressed: () {},
                  child: "Log out".text.fontFamily(semibold).white.make()),
            ],
          ),
        ),
        20.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            detailsCard(
              count: "00",
              title: "in your cart",
              width: context.screenWidth / 3.4,
            ),
            detailsCard(
              count: "32",
              title: "in your wishlist",
              width: context.screenWidth / 3.4,
            ),
            detailsCard(
              count: "675",
              title: "your orders",
              width: context.screenWidth / 3.4,
            ),
          ],
        ),

        // buttons section
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.asset(
                profileButtonIcon[index],
                width: 22,
                color: Colors.black87,
              ),
              title: profileButtonList[index]
                  .text
                  .fontFamily(semibold)
                  .color(darkFontGrey)
                  .make(),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(color: lightGrey);
          },
          itemCount: profileButtonList.length,
        )
            .box
            .white
            .margin(const EdgeInsets.all(12))
            .rounded
            .padding(const EdgeInsets.symmetric(horizontal: 16))
            .shadowSm
            .make()
            .box
            .color(redColor)
            .make(),
      ])),
    ));
  }
}

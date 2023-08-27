import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:emart_app/views/cart_screen.dart/cart_screen.dart';
import 'package:emart_app/views/category_screen/category_screen.dart';
import 'package:emart_app/views/home_screen/home_screen.dart';
import 'package:emart_app/views/profile_screen.dart/profile_screen.dart';
import 'package:emart_app/widgets/dialogue_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  final int? navIndex;
  const Home({super.key, this.navIndex});

  @override
  Widget build(BuildContext context) {
    // init home controller
    var controller = Get.put(HomeController());
    var navBarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome,
              width: Dimensions.tenW * 2.6, color: Colors.black87),
          label: "Home"),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories,
              width: Dimensions.tenW * 2.6, color: Colors.black87),
          label: "Categories"),
      BottomNavigationBarItem(
          icon: Image.asset(icCart,
              width: Dimensions.tenW * 2.6, color: Colors.black87),
          label: "Cart"),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile,
              width: Dimensions.tenW * 2.6, color: Colors.black87),
          label: "Profile"),
    ];
    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => CustomDialogueBox(
                text: "Are you sure want to quit?", context: context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value)))
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            items: navBarItem,
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            selectedItemColor: redColor,
            unselectedItemColor: darkFontGrey,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  // getUserName();
  // }

  var currentNavIndex = 0.obs;

  var username = "";

  var searchController = TextEditingController();

  // getUserName() async {
  //   var s = await firestore
  //       .collection(userCollections)
  //       .where('uid', isEqualTo: currentUser!.uid)
  //       .get()
  //       .then((value) {
  //     if (value.docs.isNotEmpty) {
  //       return value.docs.single['name'];
  //     }
  //   });

  //   username = s;
  // }
}

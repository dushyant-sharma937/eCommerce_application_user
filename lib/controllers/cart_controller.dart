import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var tprice = 0.obs;

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var pinCodeController = TextEditingController();
  var mobileController = TextEditingController();

  late dynamic productSnapshot;

  var productList = [];

  var orderPlaced = false.obs;

  calculatePrice(data) {
    tprice.value = 0;
    for (var i = 0; i < data.length; i++) {
      tprice.value += int.parse("${data[i]['tprice']}");
    }
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    orderPlaced(true);
    await getProductDetails();
    await firestore.collection(orderCollections).doc().set({
      'order_code': "233981237",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_city': cityController.text,
      'order_by_state': stateController.text,
      'order_by_pincode': pinCodeController.text,
      'order_by_mobile': mobileController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(productList),
    });
    orderPlaced(false);
  }

  getProductDetails() {
    productList.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      productList.add({
        'img': productSnapshot[i]['img'],
        'quantity': productSnapshot[i]['quantity'],
        'title': productSnapshot[i]['title'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'tprice': productSnapshot[i]['tprice'],
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollections).doc(productSnapshot[i].id).delete();
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/firebase_services.dart';

class CartController extends GetxController {
  var tprice = 0.obs;
  User? currentUser = auth.currentUser;
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var pinCodeController = TextEditingController();
  var mobileController = TextEditingController();

  late dynamic productSnapshot;

  var productList = [];
  var vendors = [];

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
      'order_code': DateTime.now().microsecondsSinceEpoch.toString(),
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
      'vendors': FieldValue.arrayUnion(vendors),
      'orders': FieldValue.arrayUnion(productList),
    });

    orderPlaced(false);
  }

  getProductDetails() {
    productList.clear();
    vendors.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      productList.add({
        'img': productSnapshot[i]['img'],
        'quantity': productSnapshot[i]['quantity'],
        'title': productSnapshot[i]['title'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'tprice': productSnapshot[i]['tprice'],
      });
      vendors.add(productSnapshot[i]['vendor_id']);
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollections).doc(productSnapshot[i].id).delete();
    }
  }

  updateAddress() async {
    await firestore.collection(userCollections).doc(currentUser!.uid).set({
      'address': addressController.text.trim(),
      'city': cityController.text.trim(),
      'pincode': pinCodeController.text.trim(),
      'state': stateController.text.trim(),
      // "${addressController.text} City: ${cityController.text}, Pincode: ${pinCodeController.text}",
    }, SetOptions(merge: true));
  }

  deleteCartProduct(data) async {
    DocumentSnapshot snapshot = await firestore
        .collection(productCollections)
        .doc(data['product_id'])
        .get();
    Map<String, dynamic> proddata = snapshot.data() as Map<String, dynamic>;
    var totalQty = proddata['p_quantity'];
    int x = int.parse(totalQty.toString()) + int.parse("${data['quantity']}");
    await firestore.collection(productCollections).doc(data['product_id']).set({
      'p_quantity': x.toString(),
    }, SetOptions(merge: true));
    FirestoreServices.deleteCartProduct(data.id);
  }

  getAddress() async {
    DocumentSnapshot snapshot =
        await firestore.collection(userCollections).doc(currentUser!.uid).get();
    Map<String, dynamic> userdata = snapshot.data() as Map<String, dynamic>;
    if ("${userdata['address']}".isEmptyOrNull) {
    } else {
      addressController.text = "${userdata['address']}";
      pinCodeController.text = "${userdata['pincode']}";
      cityController.text = "${userdata['city']}";
      stateController.text = "${userdata['state']}";
      mobileController.text = "${userdata['phone']}";
    }
  }
}

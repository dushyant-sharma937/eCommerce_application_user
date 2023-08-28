import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  User? currentUser = auth.currentUser;
  var subcat = [];
  var quantity = 0.obs;
  var isFav = false.obs;

  getSubCategories({categoryTitle}) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s = decoded.categories
        .where((element) => element.name == categoryTitle)
        .toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  addToCart(
      {prodId,
      title,
      tprice,
      qty,
      sellername,
      imageUrl,
      context,
      vendorId,
      totalQty}) async {
    await firestore.collection(cartCollections).doc().set({
      'title': title,
      'tprice': tprice,
      'quantity': qty,
      'vendor_id': vendorId,
      'sellername': sellername,
      'img': imageUrl,
      'added_by': currentUser!.uid,
      'product_id': prodId,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
    int x = int.parse(totalQty.toString()) - int.parse(qty.toString());
    await firestore.collection(productCollections).doc(prodId).set({
      'p_quantity': x.toString(),
    }, SetOptions(merge: true));
  }

  addToWishlist(docId, context) async {
    await firestore.collection(productCollections).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([
        currentUser!.uid,
      ])
    }, SetOptions(merge: true));
    isFav.value = true;
    VxToast.show(context, msg: "Item added to wishlist");
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(productCollections).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([
        currentUser!.uid,
      ])
    }, SetOptions(merge: true));

    isFav.value = false;
    VxToast.show(context, msg: "Item removed from wishlist");
  }
}

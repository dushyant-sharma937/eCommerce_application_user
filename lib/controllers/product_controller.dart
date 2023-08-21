import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var isFav = false.obs;
  getSubCategories({categoryTitle}) async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s = decoded.categories
        .where((element) => element.name == categoryTitle)
        .toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  addToCart({title, tprice, qty, sellername, imageUrl, context}) async {
    await firestore.collection(cartCollections).doc().set({
      'title': title,
      'tprice': tprice,
      'quantity': qty,
      'sellername': sellername,
      'img': imageUrl,
      'added_by': currentUser!.uid,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }
}

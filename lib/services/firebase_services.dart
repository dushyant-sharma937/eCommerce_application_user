import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  static User? currentUser = auth.currentUser;
  // get users data
  static getUserData(uid) {
    return firestore
        .collection(userCollections)
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  static getProducts(category) {
    return firestore
        .collection(productCollections)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getCartProducts(customerId) {
    return firestore
        .collection(cartCollections)
        .where('added_by', isEqualTo: customerId)
        .snapshots();
  }

  static deleteCartProduct(id) {
    return firestore.collection(cartCollections).doc(id).delete();
  }

  static getAllMessages(docId) {
    return firestore
        .collection(chatCollections)
        .doc(docId)
        .collection(messagesCollections)
        .orderBy('created_on', descending: true)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection(orderCollections)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlists() {
    return firestore
        .collection(productCollections)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getChatMessages() {
    return firestore
        .collection(chatCollections)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getAllProducts() {
    return firestore.collection(productCollections).snapshots();
  }

  static getSearchedProducts() {
    return firestore.collection(productCollections).get();
  }

  static getCategoryProducts(categoryTitle) {
    return firestore
        .collection(productCollections)
        .where('p_subcategory', isEqualTo: categoryTitle)
        .snapshots();
  }

  static getFeaturedProducts() {
    return firestore
        .collection(productCollections)
        .where('is_featured', isEqualTo: true)
        .snapshots();
  }
}

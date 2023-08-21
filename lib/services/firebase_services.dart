import 'package:emart_app/consts/consts.dart';

class FirestoreServices {
  // get users data
  static getUserData(uid) {
    return firestore
        .collection(userCollections)
        .where('uid', isEqualTo: uid)
        .snapshots();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  // has error, errorCode, provider, id, email, name, imageUrl
  final bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _provider;
  String? get provider => _provider;

  String? _name;
  String? get name => _name;

  String? _phone;
  String? get phone => _phone;

  String? _uid;
  String? get uid => _uid;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  String? _email;
  String? get email => _email;

  String? _address;
  String? get address => _address;

  String? _city;
  String? get city => _city;

  String? _state;
  String? get state => _state;

  String? _pincode;
  String? get pincode => _pincode;

  SignInProvider() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool('signed_in') ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }

  // check whether user exists or not in cloudfirestore
  Future<bool> checkUserExists({context}) async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (snap.exists) {
      VxToast.show(context, msg: "Signed in as existing user");
      return true;
    } else {
      VxToast.show(context, msg: "Signed in as new user");
      return false;
    }
  }

  void phoneNumberUser(
      User user, email, name, phone, address, pincode, city, state) {
    _name = name;
    _email = email;
    _imageUrl =
        "https://w7.pngwing.com/pngs/184/113/png-transparent-user-profile-computer-icons-profile-heroes-black-silhouette-thumbnail.png";
    _provider = 'PHONE';
    _uid = user.uid;
    _phone = phone;
    _address = address;
    _pincode = pincode;
    _city = city;
    _state = state;

    notifyListeners();
  }

  Future getUserDataFromFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) => {
              _name = snapshot['name'],
              _email = snapshot['email'],
              _imageUrl = snapshot['imageUrl'],
              _provider = snapshot['provider'],
              _uid = snapshot['uid'],
              _phone = snapshot['phone'],
              _address = snapshot['address'],
              _city = snapshot['city'],
              _state = snapshot['state'],
              _pincode = snapshot['pincode'],
            });
  }

  Future saveDataToFirestore() async {
    final DocumentReference r =
        FirebaseFirestore.instance.collection('users').doc(uid);
    await r.set({
      "name": _name,
      "email": _email,
      "imageUrl": _imageUrl,
      "provider": _provider,
      "cart_count": "00",
      "order_count": "00",
      "wishlist_count": "00",
      "uid": _uid,
      "phone": _phone,
      "address": _address,
      "city": _city,
      "state": _state,
      "pincode": _pincode,
    });
    notifyListeners();
  }

  Future saveDataToSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('name', _name!);
    await s.setString('email', _email!);
    await s.setString('imageUrl', _imageUrl!);
    await s.setString('provider', _provider!);
    await s.setString('uid', _uid!);
    await s.setString('phone', _phone!);
    await s.setString('address', _address!);
    await s.setString('city', _city!);
    await s.setString('state', _state!);
    await s.setString('pincode', _pincode!);
  }

  Future getDataFromSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _name = s.getString('name');
    _email = s.getString('email');
    _imageUrl = s.getString('imageUrl');
    _provider = s.getString('provider');
    _uid = s.getString('uid');
    _phone = s.getString('phone');
    _address = s.getString('address');
    _city = s.getString('city');
    _pincode = s.getString('pincode');
    _state = s.getString('state');
    notifyListeners();
  }

  void userSignOut() async {
    await firebaseAuth.signOut();
    _isSignedIn = false;

    // clear all data
    clearStoredData();
    notifyListeners();
  }

  Future clearStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }
}

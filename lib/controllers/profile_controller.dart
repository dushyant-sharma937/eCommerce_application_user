import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  User? currentUser = auth.currentUser;
  var profileImagePath = ''.obs;
  var isCamera = false.obs;
  var profileImageLink = '';
  var isLoading = false.obs;

  var nameController = TextEditingController();
  var emailController = TextEditingController();

  changeImage({context}) async {
    try {
      final img = await ImagePicker().pickImage(
          source: isCamera.value ? ImageSource.camera : ImageSource.gallery,
          // source: ImageSource.gallery,
          imageQuality: 70);
      if (img == null) {
        return;
      } else {
        profileImagePath.value = img.path;
      }
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage() async {
    isLoading(true);
    var filename = basename(profileImagePath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile() async {
    var store = firestore.collection(userCollections).doc(currentUser!.uid);
    await store.set({
      'name': nameController.text.trim(),
      'imageUrl': profileImageLink,
      'email': emailController.text.trim(),
    }, SetOptions(merge: true));
    isLoading(false);
  }
}

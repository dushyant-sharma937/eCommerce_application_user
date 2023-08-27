import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets/bg_widgets.dart';
import 'package:emart_app/widgets/custom_button.dart';
import 'package:emart_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  void tapImage() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: whiteColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.isCamera(true);
                    controller.changeImage(context: context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: Dimensions.tenH * 1.5),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Camera',
                        style: TextStyle(fontSize: Dimensions.font18),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                GestureDetector(
                  onTap: () {
                    controller.isCamera(false);
                    controller.changeImage(context: context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: Dimensions.tenH * 1.5),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Gallery',
                        style: TextStyle(fontSize: Dimensions.font18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: "Edit Profile".text.color(whiteColor).semiBold.make(),
              backgroundColor: redColor,
              foregroundColor: whiteColor,
            ),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  (MediaQuery.of(context).size.height * 0.15).heightBox,
                  Card(
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.eightW,
                        vertical: Dimensions.sixteenH),
                    elevation: 2,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.tenH)),
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              tapImage();
                            },
                            child:
                                // if data image url and controller path is empty
                                widget.data['imageUrl'] == '' &&
                                        controller.profileImagePath.isEmpty
                                    ? Image.asset(
                                        imgProfile,
                                        width: Dimensions.hundredW,
                                        fit: BoxFit.cover,
                                      )
                                        .box
                                        .roundedFull
                                        .clip(Clip.antiAlias)
                                        .makeCentered()
                                    // if data is not empty, but controller path is empty
                                    : widget.data['imageUrl'] != '' &&
                                            controller.profileImagePath.isEmpty
                                        ? Image.network(
                                            widget.data['imageUrl'],
                                            width: Dimensions.hundredW * 0.8,
                                            fit: BoxFit.cover,
                                          )
                                            .box
                                            .roundedFull
                                            .clip(Clip.antiAlias)
                                            .makeCentered()
                                        // if both are empty
                                        : Image.file(
                                            File(controller
                                                .profileImagePath.value),
                                            width: Dimensions.hundredW,
                                            fit: BoxFit.cover,
                                          )
                                            .box
                                            .roundedFull
                                            .clip(Clip.antiAlias)
                                            .makeCentered(),
                          ),
                          Dimensions.tenH.heightBox,
                          customTextField(
                              hint: "admin",
                              title: "Name",
                              isPass: false,
                              controller: controller.nameController),
                          Dimensions.twentyH.heightBox,
                          customTextField(
                              hint: "admin@gmail.com",
                              title: "Email",
                              isPass: false,
                              controller: controller.emailController),
                          (Dimensions.tenH * 3).heightBox,
                          controller.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(redColor)))
                              : customButton(
                                  color: redColor,
                                  onPress: () async {
                                    controller.isLoading(true);

                                    if (controller
                                        .profileImagePath.value.isNotEmpty) {
                                      await controller.uploadImage();
                                    } else {
                                      controller.profileImageLink =
                                          widget.data['imageUrl'];
                                    }
                                    await controller.updateProfile();
                                    VxToast.show(context,
                                        msg: "Profile updated successfully");
                                  },
                                  title: "Submit",
                                  textColor: whiteColor,
                                ).box.width(double.infinity).make(),
                        ],
                      )
                          .box
                          .padding(
                              EdgeInsets.symmetric(horizontal: Dimensions.tenH))
                          .white
                          .roundedSM
                          .size(double.infinity, context.screenHeight * 0.45)
                          .make(),
                    ),
                  )
                ],
              ),
            )));
  }
}

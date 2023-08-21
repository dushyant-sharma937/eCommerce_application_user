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
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Camera',
                        style: TextStyle(fontSize: 18),
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
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Gallery',
                        style: TextStyle(fontSize: 18),
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
            appBar: AppBar(iconTheme: const IconThemeData(color: whiteColor)),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  (MediaQuery.of(context).size.height * 0.15).heightBox,
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    elevation: 2,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
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
                                        imgProfile2,
                                        width: 100,
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
                                            width: 80,
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
                                            width: 100,
                                            fit: BoxFit.cover,
                                          )
                                            .box
                                            .roundedFull
                                            .clip(Clip.antiAlias)
                                            .makeCentered(),
                          ),
                          10.heightBox,
                          customTextField(
                              hint: "admin",
                              title: "Name",
                              isPass: false,
                              controller: controller.nameController),
                          20.heightBox,
                          customTextField(
                              hint: "admin@gmail.com",
                              title: "Email",
                              isPass: false,
                              controller: controller.emailController),
                          30.heightBox,
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
                          .padding(const EdgeInsets.symmetric(horizontal: 10))
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

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets/custom_text_field.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dropdown_menu.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping info"
            .text
            .black
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: Obx(
        () => SizedBox(
          height: Dimensions.tenH * 6,
          child: controller.orderPlaced.value
              ? const Center(child: LoadingIndicator())
              : MaterialButton(
                  onPressed: () async {
                    if (controller.addressController.text.isNotEmpty &&
                        controller.cityController.text.isNotEmpty &&
                        controller.stateController.text.isNotEmpty &&
                        controller.pinCodeController.text.length == 6 &&
                        controller.mobileController.text.length == 10) {
                      await controller.placeMyOrder(
                          orderPaymentMethod: "Cash on Delivery",
                          totalAmount: controller.tprice.value);
                      await controller.clearCart();
                      VxToast.show(context, msg: "Order placed successfully");
                      Get.offAll(const Home());
                    } else {
                      VxToast.show(context,
                          msg: "Please fill the details correctly");
                    }
                  },
                  color: Colors.red,
                  minWidth: context.width * 0.9,
                  height: Dimensions.tenH * 6,
                  elevation: 2,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.tenH)),
                  child: "Place order"
                      .text
                      .size(Dimensions.font18)
                      .white
                      .fontFamily(semibold)
                      .make(),
                ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.sixteenH),
          child: Column(
            children: [
              customTextField(
                  hint: "Address",
                  isPass: false,
                  title: "Address",
                  controller: controller.addressController),
              Dimensions.twentyH.heightBox,
              customTextField(
                  hint: "City",
                  isPass: false,
                  title: "City",
                  controller: controller.cityController),
              Dimensions.twentyH.heightBox,
              customTextField(
                  hint: "State",
                  isPass: false,
                  title: "State",
                  controller: controller.stateController),
              Dimensions.twentyH.heightBox,
              customTextField(
                  hint: "Pin Code",
                  isPass: false,
                  title: "Pin Code",
                  type: TextInputType.number,
                  controller: controller.pinCodeController),
              Dimensions.twentyH.heightBox,
              customTextField(
                  hint: "Mobile Number",
                  isPass: false,
                  title: "Mobile Number",
                  type: TextInputType.number,
                  controller: controller.mobileController),
              // const Spacer(),
              Dimensions.twentyH.heightBox,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.tenH),
                  color: lightGolden,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (Dimensions.twoH * 0.5).widthBox,
                    "Payment:"
                        .text
                        .fontFamily(semibold)
                        .size(Dimensions.font18)
                        .make(),
                    const DropdownDemo(),
                    (Dimensions.twoW * 0.5).widthBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

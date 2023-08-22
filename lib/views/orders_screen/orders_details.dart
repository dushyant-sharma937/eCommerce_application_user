import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/orders_screen/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import 'components/order_details_text_widget.dart';

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Order Details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
              child: Column(
                children: [
                  orderStatus(
                    color: Colors.blue,
                    icon: Icons.done,
                    title: "Placed",
                    showDone: data['order_placed'],
                  ),
                  5.heightBox,
                  orderStatus(
                    color: Colors.yellow,
                    icon: Icons.thumb_up_alt,
                    title: "Confirmed",
                    showDone: data['order_confirmed'],
                  ),
                  5.heightBox,
                  orderStatus(
                    color: Colors.green,
                    icon: Icons.delivery_dining,
                    title: "On Delivery",
                    showDone: data['order_on_delivery'],
                  ),
                  5.heightBox,
                  orderStatus(
                    color: Colors.red,
                    icon: Icons.done_all_rounded,
                    title: "Delivered",
                    showDone: data['order_delivered'],
                  ),
                  5.heightBox,
                  const Divider(thickness: 1),
                  5.heightBox,
                  Column(
                    children: [
                      OrderPlaceDetails(
                        t1: "Order Code",
                        d1: "${data['order_code']}",
                        t2: "Shipping Method",
                        d2: "${data['shipping_method']}",
                      ),
                      5.heightBox,
                      OrderPlaceDetails(
                        t1: "Order Date",
                        d1: intl.DateFormat.yMd()
                            .format(data['order_date'].toDate()),
                        t2: "Payment Method",
                        d2: "${data['payment_method']}",
                      ),
                      5.heightBox,
                      const OrderPlaceDetails(
                        t1: "Payment Status ",
                        d1: "Unpaid",
                        t2: "Delivery Status",
                        d2: "Order Placed",
                      ),
                      5.heightBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Shipping Address"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                "${data['order_by_name']}".text.make(),
                                "${data['order_by_email']}".text.make(),
                                "${data['order_by_address']}".text.make(),
                                "${data['order_by_city']}".text.make(),
                                "${data['order_by_state']}".text.make(),
                                "${data['order_by_mobile']}".text.make(),
                                "${data['order_by_pincode']}".text.make(),
                              ],
                            ),
                            SizedBox(
                              width: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Total Amount"
                                      .text
                                      .fontFamily(semibold)
                                      .make(),
                                  "${data['total_amount']}"
                                      .text
                                      .color(Colors.red)
                                      .fontFamily(bold)
                                      .make(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ).box.outerShadowMd.white.make(),
                      const Divider(thickness: 1),
                      10.heightBox,
                      "Ordered Product(s)"
                          .text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .makeCentered(),
                      10.heightBox,
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(data['orders'].length, (index) {
                          return OrderPlaceDetails(
                              t1: "${data['orders'][index]['title']}",
                              t2: "${data['orders'][index]['tprice']}",
                              d1: "${data['orders'][index]['quantity']}",
                              d2: "Refundable");
                        }).toList(),
                      )
                          .box
                          .outerShadowMd
                          .white
                          .margin(const EdgeInsets.only(bottom: 4))
                          .make(),
                      20.heightBox,
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

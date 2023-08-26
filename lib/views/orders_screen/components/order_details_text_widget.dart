import 'package:flutter/material.dart';

import '../../../consts/consts.dart';

class OrderPlaceDetails extends StatelessWidget {
  final String t1, t2, d1, d2;
  const OrderPlaceDetails({
    super.key,
    required this.t1,
    required this.t2,
    required this.d1,
    required this.d2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.sixteenH, vertical: Dimensions.sixteenH * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              t1.text.fontFamily(semibold).make(),
              d1.text.color(Colors.red).fontFamily(semibold).make(),
            ],
          ),
          SizedBox(
            width: Dimensions.hundredW * 1.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                t2.text.fontFamily(semibold).make(),
                d2.text.color(Colors.red).fontFamily(semibold).make(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

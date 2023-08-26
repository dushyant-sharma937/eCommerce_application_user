import 'package:flutter/material.dart';

import '../../../consts/consts.dart';

import 'package:intl/intl.dart' as intl;

class ChatBubble extends StatelessWidget {
  final dynamic data;
  const ChatBubble({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    var t = data['created_on'] == null
        ? DateTime.now()
        : data['created_on'].toDate();
    var time = intl.DateFormat("h:mma").format(t);
    return Directionality(
      textDirection: data['uid'] == currentUser!.uid
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.only(bottom: Dimensions.eightW),
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.sixteenW, vertical: Dimensions.eightH),
        decoration: BoxDecoration(
          color: data['uid'] == currentUser!.uid
              ? Colors.greenAccent.withOpacity(0.5)
              : Colors.blueAccent.withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.twentyH),
            topRight: Radius.circular(Dimensions.twentyH),
            bottomLeft: data['uid'] == currentUser!.uid
                ? Radius.circular(Dimensions.twentyH)
                : const Radius.circular(0),
            bottomRight: data['uid'] == currentUser!.uid
                ? const Radius.circular(0)
                : Radius.circular(Dimensions.twentyH),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          "${data['msg']}".text.size(Dimensions.font16).make(),
          Dimensions.tenH.heightBox,
          time.text
              .color(Colors.black.withOpacity(0.5))
              .size(Dimensions.font12)
              .make(),
        ]),
      ),
    );
  }
}

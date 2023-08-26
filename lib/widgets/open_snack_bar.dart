import 'package:flutter/material.dart';

import '../consts/consts.dart';

void openSnackBar(context, snackMessage, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
        textColor: Colors.white,
      ),
      content: Text(
        snackMessage,
        style: TextStyle(fontSize: Dimensions.font14),
      ),
    ),
  );
}

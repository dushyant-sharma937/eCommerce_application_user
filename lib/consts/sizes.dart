import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height; // height: 843.4285714285714
  static double screenWidth = Get.context!.width; // width: 411.42857142857144
  // 843/x = 10; x = 843/10 = 84.3

  static double tenH = screenHeight / 84.34285714;
  static double tenW = screenWidth / 41.1428571;
  static double twentyH = tenH * 2;
  static double twentyW = tenW * 2;
  static double thirtyH = tenH * 3;
  static double thirtyW = tenW * 3;
  static double twoH = tenH / 5;
  static double twoW = tenW / 5;
  static double eightH = twoH * 4;
  static double eightW = twoW * 4;
  static double twelveH = twoH * 6;
  static double twelveW = twoW * 6;
  static double sixteenH = twoH * 8;
  static double sixteenW = twoW * 8;
  static double hundredH = tenH * 10;
  static double hundredW = tenW * 10;

  static double font12 = twoH * 6;
  static double font14 = twoH * 7;
  static double font16 = twoH * 8;
  static double font18 = twoH * 9;
  static double font20 = tenH * 2;
  static double font22 = tenH * 2.2;
}

/*
* Author: Haotian(Jeremy) Li
*
* Desc: This is for the Map Size Multi-Model Adaptation
*/

import 'dart:ui';

class SizeFit {
  static late double physicalWidth;
  static late double physicalHeight;
  static late double screenWidth;
  static late double screenHeight;
  static late double dpr;
  static late double rpx;
  static late double px;

  // iPhone13 size: 1170 * 2532
  static void initialize({double standardSize = 1170}){
    physicalHeight = window.physicalSize.height;
    physicalWidth = window.physicalSize.width;

    dpr = window.devicePixelRatio;

    screenHeight = physicalHeight / dpr;
    screenWidth = physicalWidth / dpr;

    rpx = screenWidth / standardSize;
    px = rpx * 2;
  }

  static double setPx(double size) {
    return px * size;
  }

  static double setRpx(double size) {
    return rpx * size;
  }

  static double setHeightPersentage(double persents) {
    return persents * screenHeight;
  }

  static double setWidthPersentage(double persents) {
    return persents * screenWidth;
  }
}
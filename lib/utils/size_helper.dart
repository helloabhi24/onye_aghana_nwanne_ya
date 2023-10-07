import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// app height****************

const height2 = SizedBox(
  height: 2,
);

const height5 = SizedBox(
  height: 5,
);

const height8 = SizedBox(
  height: 8,
);

const height10 = SizedBox(
  height: 10,
);

const height13 = SizedBox(
  height: 13,
);

const height15 = SizedBox(
  height: 15,
);

const height18 = SizedBox(
  height: 18,
);

const height20 = SizedBox(
  height: 20,
);

const height23 = SizedBox(
  height: 23,
);

const height25 = SizedBox(
  height: 25,
);

// app width****************

const width2 = SizedBox(
  width: 2,
);

const width5 = SizedBox(
  width: 5,
);

const width3 = SizedBox(
  width: 3,
);

const width8 = SizedBox(
  width: 8,
);

const width10 = SizedBox(
  width: 10,
);

const width13 = SizedBox(
  width: 13,
);

const width15 = SizedBox(
  width: 15,
);

const width18 = SizedBox(
  width: 18,
);

const width20 = SizedBox(
  width: 20,
);

const width23 = SizedBox(
  width: 23,
);

const width25 = SizedBox(
  width: 25,
);

// mediaquery height

SizedBox getheight(context, double height) {
  return SizedBox(
    height: Get.height * height,
  );
}

SizedBox getwidth(context, double width) {
  return SizedBox(
    width: Get.width * width,
  );
}

Size size = WidgetsBinding.instance.window.physicalSize /
    WidgetsBinding.instance.window.devicePixelRatio;

double getHorizontalSize(double px) {
  return px * (size.width / 428);
}

double getVerticalSize(double px) {
  final num statusBar =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewPadding.top;
  final num screenHeight = size.height - statusBar;
  return px * (screenHeight / 926);
}

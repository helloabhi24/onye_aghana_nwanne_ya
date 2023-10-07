import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Get.width * 0.20,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotatePulse,
          colors: [appColor, appYellowColor],
          strokeWidth: 2,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? icon;
  const CustomFloatingActionButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.1,
      width: Get.width * 0.1,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: appColor,
          onPressed: onPressed,
          child: icon,
        ),
      ),
    );
  }
}

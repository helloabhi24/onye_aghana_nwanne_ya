import 'package:flutter/material.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? icon;
  const CustomFloatingActionButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: appColor,
      onPressed: onPressed,
      child: icon,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: Get.height * 0.075,
          width: Get.width * 0.66,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
                shape: const StadiumBorder(),
                elevation: 2),
            onPressed: onPressed,
            child: CustomButtonText(
              text: text,
              color: appYellowColor,
            ),
          )),
    );
  }
}

class CustomButtonHome extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  const CustomButtonHome(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: Get.height * 0.075,
          width: Get.width * 0.66,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
                shape: const StadiumBorder(),
                elevation: 2),
            onPressed: onPressed,
            child: CustomButtonTextHome(
              text: text,
              color: appYellowColor,
            ),
          )),
    );
  }
}

class CustomSelectedButton extends StatelessWidget {
  final bool? isSelected;
  final String? text;
  final VoidCallback? onPressed;
  const CustomSelectedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: Get.height * 0.060,
          width: Get.width * 0.45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: isSelected! ? appColor : null,
                shape: const StadiumBorder(),
                elevation: 2),
            onPressed: onPressed,
            child: CustomText(
              text: text,
              color: isSelected! ? appYellowColor : null,
            ),
          )),
    );
  }
}

class CustomExpandedButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  const CustomExpandedButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: Get.height * 0.062,
          width: Get.width * 0.95,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(), elevation: 2),
            onPressed: onPressed,
            child: CustomText(
              text: text,
            ),
          )),
    );
  }
}

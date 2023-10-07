import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';

import '../utils/size_helper.dart';
import 'custom_text_widget.dart';

class CustomCardWidget extends StatelessWidget {
  final String? mainCardHeading;
  final String? numberOnCard;
  final String? saveDraftText;
  const CustomCardWidget(
      {super.key,
      required this.mainCardHeading,
      required this.numberOnCard,
      this.saveDraftText});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomHeadingText(text: numberOnCard),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: Get.width * 0.60,
                      child: CustomBoldText(text: mainCardHeading)),
                  saveDraftText != null
                      ? getheight(context, 0.010)
                      : const SizedBox.shrink(),
                  saveDraftText != null
                      ? CustomText(
                          text: saveDraftText,
                          color: darkRedColor,
                        )
                      : const SizedBox.shrink()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomContainerListTile extends StatelessWidget {
  final Widget? image;
  final String? title;
  final String? subtitle;
  final VoidCallback? onIconPressed;
  const CustomContainerListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image,
      required this.onIconPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: appColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: image,
        title: CustomText(text: title),
        subtitle: CustomText(text: subtitle),
        trailing: TextButton(
          onPressed: onIconPressed,
          child: Icon(
            Icons.edit,
            color: blueColor,
          ),
        ),
      ),
    );
  }
}

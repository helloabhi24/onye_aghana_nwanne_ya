import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';

import '../utils/size_helper.dart';
import 'custom_text_widget.dart';

class CustomCardWidget extends StatelessWidget {
  final String? mainCardHeading;
  final String? numberOnCard;
  final Future<int?>? saveDraftText;
  final String? formName;
  final int? formLength;
  final List? formList;
  final String? submitText;
  final int? index;

  const CustomCardWidget({
    super.key,
    required this.mainCardHeading,
    required this.numberOnCard,
    this.saveDraftText,
    this.formName,
    this.formLength,
    this.formList,
    this.index,
    this.submitText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                        width: Get.width * 0.60,
                        child: CustomBoldText(text: mainCardHeading)),
                  ),
                  saveDraftText != null
                      ? getheight(context, 0.010)
                      : const SizedBox.shrink(),
                  saveDraftText != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FutureBuilder<int?>(
                              future: saveDraftText,
                              builder: (BuildContext context,
                                  AsyncSnapshot<int?> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator(); // Display a loading indicator while fetching data.
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomText(
                                        text:
                                            'Save & Draft: ${snapshot.data ?? 0}',
                                        color: darkRedColor,
                                      ),
                                    ),
                                  );

                                  // Text('Save & Draft: ${snapshot.data ?? 0}');
                                }
                              },
                            ),
                            // Card(
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: CustomText(
                            //       text: saveDraftText,
                            //       color: darkRedColor,
                            //     ),
                            //   ),
                            // ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(
                                  text: submitText,
                                  color: darkRedColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
            // IconButton.outlined(
            //     onPressed: onPressed, icon: Icon(Icons.arrow_forward_ios))
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
        // leading: image,
        title: CustomTextOverFlow(text: title),
        // subtitle: CustomText(text: subtitle),
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

class CustomContainerListDataTile extends StatelessWidget {
  final Widget? image;
  final String? title;
  final String? subtitle;
  final VoidCallback? onIconPressed;
  final int? isVerified;
  final String? pollUnit;
  final bool? isSync;
  final String? dob;
  final String? gender;
  final String? maritalStatus;
  const CustomContainerListDataTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image,
      required this.onIconPressed,
      required this.isVerified,
      required this.pollUnit,
      required this.isSync,
      required this.dob,
      required this.gender,
      required this.maritalStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: appColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        // leading: image,
        title: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // const Icon(
                //   Icons.person,
                //   size: 15,
                // ),
                // getwidth(context, 0.010),
                SizedBox(
                    width: Get.width * 0.78,
                    child: CustomTextOverFlowName(text: title)),
              ],
            ),
          ],
        ),
        subtitle: Column(
          children: [
            getheight(context, 0.010),
            subtitle != ""
                ? getheight(context, 0.005)
                : const SizedBox.shrink(),
            subtitle != ""
                ? Row(
                    children: [
                      const CustomTextOverFlow(text: "Tel. Number:"),
                      // const Icon(
                      //   Icons.phone,
                      //   size: 15,
                      // ),
                      getwidth(context, 0.010),
                      CustomTextOverFlow(text: "+234 $subtitle"),
                    ],
                  )
                : const SizedBox.shrink(),
            dob != "" || gender != ""
                ? getheight(context, 0.005)
                : const SizedBox.shrink(),
            Row(
              children: [
                dob != ""
                    ? Row(
                        children: [
                          const CustomTextOverFlow(text: 'DOB-Y:'),
                          // const Icon(
                          //   Icons.cake,
                          //   size: 15,
                          // ),
                          getwidth(context, 0.010),
                          CustomTextOverFlow(
                              text: dob!.substring(dob!.length - 4)),
                        ],
                      )
                    : const SizedBox.shrink(),
                dob != "" && gender != ""
                    ? const CustomTextOverFlow(text: " | ")
                    : const SizedBox.shrink(),
                gender != ""
                    ? Row(
                        children: [
                          const CustomTextOverFlow(text: 'Gender: '),
                          // Icon(
                          //   gender == "Male" ? Icons.male : Icons.female,
                          //   size: 15,
                          // ),
                          getwidth(context, 0.010),
                          CustomTextOverFlow(text: gender![0]),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            maritalStatus != ""
                ? getheight(context, 0.005)
                : const SizedBox.shrink(),
            maritalStatus != ""
                ? Row(
                    children: [
                      const CustomTextOverFlow(text: "Marital Status:"),
                      getwidth(context, 0.010),
                      CustomTextOverFlow(text: maritalStatus),
                    ],
                  )
                : const SizedBox.shrink(),
            pollUnit != ""
                ? getheight(context, 0.005)
                : const SizedBox.shrink(),
            pollUnit != ""
                ? Row(
                    children: [
                      Row(
                        children: [
                          const CustomTextOverFlow(text: "Poll Unit Code:"),
                          // const Icon(
                          //   Icons.poll,
                          //   size: 15,
                          // ),
                          getwidth(context, 0.010),
                          CustomTextOverFlow(text: pollUnit),
                        ],
                      ),
                      !isSync!
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                getwidth(context, 0.08),
                                CustomText(
                                  text: isVerified == 0
                                      ? "Not Verified"
                                      : "Verified",
                                  color:
                                      isVerified == 0 ? redColor : greenColor,
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                getwidth(context, 0.08),
                                CustomText(
                                  text: "Not Sync",
                                  color: redColor,
                                )
                              ],
                            )
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class CustomContainerListTileForAll extends StatelessWidget {
  final Widget? image;
  final String? title;
  final String? subtitle;
  final String? dob;
  final String? gender;
  final String? maritalStatus;
  final VoidCallback? onIconPressed;
  final String? pollUnit;
  const CustomContainerListTileForAll(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.dob,
      required this.gender,
      required this.maritalStatus,
      required this.image,
      required this.onIconPressed,
      required this.pollUnit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: appColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        // leading: image,
        title: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // const Icon(
                //   Icons.person,
                //   size: 15,
                // ),
                // getwidth(context, 0.010),
                SizedBox(
                    width: Get.width * 0.60,
                    child: CustomTextOverFlowName(text: title)),
              ],
            ),
          ],
        ),
        subtitle: Column(
          children: [
            getheight(context, 0.010),
            subtitle != ""
                ? getheight(context, 0.005)
                : const SizedBox.shrink(),
            subtitle != ""
                ? Row(
                    children: [
                      const CustomTextOverFlow(text: "Tel. Number:"),
                      // const Icon(
                      //   Icons.phone,
                      //   size: 15,
                      // ),
                      getwidth(context, 0.010),
                      CustomTextOverFlow(text: "+234 $subtitle"),
                    ],
                  )
                : const SizedBox.shrink(),
            dob != "" && gender != ""
                ? getheight(context, 0.005)
                : const SizedBox.shrink(),
            Row(
              children: [
                dob != ""
                    ? Row(
                        children: [
                          const CustomTextOverFlow(text: 'DOB-Y:'),
                          // const Icon(
                          //   Icons.cake,
                          //   size: 15,
                          // ),
                          getwidth(context, 0.010),
                          CustomTextOverFlow(
                              text: dob!.substring(dob!.length - 4)),
                        ],
                      )
                    : const SizedBox.shrink(),
                dob != "" && gender != ""
                    ? const CustomTextOverFlow(text: " | ")
                    : const SizedBox.shrink(),
                gender != ""
                    ? Row(
                        children: [
                          const CustomTextOverFlow(text: 'Gender: '),
                          // Icon(
                          //   gender == "Male" ? Icons.male : Icons.female,
                          //   size: 15,
                          // ),
                          getwidth(context, 0.010),
                          CustomTextOverFlow(text: gender![0]),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            maritalStatus != ""
                ? getheight(context, 0.005)
                : const SizedBox.shrink(),
            maritalStatus != ""
                ? Row(
                    children: [
                      const CustomTextOverFlow(text: "Marital Status:"),
                      getwidth(context, 0.010),
                      CustomTextOverFlow(text: maritalStatus),
                    ],
                  )
                : const SizedBox.shrink(),
            pollUnit != ""
                ? getheight(context, 0.005)
                : const SizedBox.shrink(),
            pollUnit != ""
                ? Row(
                    children: [
                      const CustomTextOverFlow(text: "Poll Unit Code:"),
                      // const Icon(
                      //   Icons.poll,
                      //   size: 15,
                      // ),
                      getwidth(context, 0.010),
                      CustomTextOverFlow(text: pollUnit),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),

        trailing: SizedBox(
          width: Get.width * 0.080,
          // height: Get.height * 0.020,
          child: TextButton(
            onPressed: onIconPressed,
            child: Icon(
              Icons.edit,
              color: blueColor,
            ),
          ),
        ),
      ),
    );
  }
}

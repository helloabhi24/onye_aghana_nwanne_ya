import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';

showloadingIndicator() {
  Get.dialog(Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        getheight(Get.context, 0.010),
        const RepaintBoundary(child: CircularProgressIndicator()),
        getheight(Get.context, 0.010),
        const CustomText(
          text: "Please wait....",
        )
      ],
    ),
  ));
}

hideLoading() {
  if (Get.isDialogOpen!) {
    Get.back();
  }
}

// showeErrrorDialouge(String error) {
//   Get.dialog(Dialog(
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         getheight(Get.context, 0.010),
//         CustomText(
//           text: error,
//           fontSize: 20.sp,
//           fontWeight: FontWeight.w700,
//         ),
//         getheight(Get.context, 0.010),
//       ],
//     ),
//   ));
// }

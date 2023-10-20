import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/services/local_database_helper.dart';
import 'package:onye_aghana_nwanne_ya/sync_data/sync_summit_data.dart';

import '../utils/colors.dart';

class CustomSyncButton extends StatelessWidget {
  const CustomSyncButton({super.key});

  @override
  Widget build(BuildContext context) {
    FormController formController = Get.find();
    SharedPref sharedPref = Get.put(SharedPref());
    return Obx(
      () => formController.userSubmittedDataList.isNotEmpty
          ? GestureDetector(
              onTap: () async {
                await LocalDatabaseHelper.getSubmitteddNote(
                    sharedPref.userID.value);
                // await formController.loadSubmitStoredData();
                Get.to(() => const SyncSubmitData(),
                    transition: Transition.noTransition);
              },
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.sync_outlined,
                      color: appColor,
                    ),
                  ),
                  CircleAvatar(
                    maxRadius: 8,
                    child: Text(
                      formController.userSubmittedDataList.length.toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

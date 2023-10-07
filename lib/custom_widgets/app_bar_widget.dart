import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  const AppBarWidget({super.key, this.actions});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          elevation: 15,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: Container(
            height: 100,
            width: 200,
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Image.asset(
              'assets/images/logo.png',
              // height: Get.height * 0.20,
              // width: Get.width * 0.20,
            ),
          ),
        ),
        //  Card(
        //   margin: EdgeInsets.all(1),
        //   color: appYellowColor,
        //   elevation: 8,
        //   shadowColor: appYellowColor,
        //   child: Image.asset(
        //     'assets/images/logo.png',
        //     height: Get.height * 0.20,
        //     width: Get.width * 0.20,
        //   ),
        // ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              // begin: Alignment.,
              // end: Alignment.bottomCenter,
              colors: <Color>[darkAmber, lightAmber, darkAmber]),
        ),
      ),
    );
  }
}

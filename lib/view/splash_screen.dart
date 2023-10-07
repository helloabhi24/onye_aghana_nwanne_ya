import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/view/dashboard/dashboard_page.dart';
import 'package:onye_aghana_nwanne_ya/view/login/sign_in_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPref sharedPref = Get.put(SharedPref());
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Get.offAll(
          () => sharedPref.userID.isEmpty
              ? const SingInPage()
              : const DashboardPage(),
          transition: Transition.downToUp);
      // print("hello");
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => SignInWidget(),
      //     ));
      // print("hello99");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkAmber.withOpacity(0.85),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomBoldText(text: "Welcome"),
          ],
        )
            //  Image(
            //   image: const AssetImage('assets/images/logo.jpg'),
            //   width: Get.width * 0.50,
            // ),
            )
        //  Image.asset(
        //   'assets/images/logo.png',
        //   width: Get.width * 0.50,
        // ),
        );
  }
}

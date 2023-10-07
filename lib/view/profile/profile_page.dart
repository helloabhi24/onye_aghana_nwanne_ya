import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onye_aghana_nwanne_ya/contoller/sign_up_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_form_field.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custome_pop_down.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/image_selected_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import '../../custom_widgets/app_bar_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());
    return Obx(
      () => Scaffold(
        appBar: AppBarWidget(
          actions: [
            TextButton(
                onPressed: () {},
                child: Icon(
                  Icons.sync_outlined,
                  color: appColor,
                )),
            const CustomPopDown()
          ],
          // actions: [
          //   TextButton(
          //       onPressed: () {},
          //       child: Icon(
          //         Icons.sync_outlined,
          //         color: appColor,
          //       )),
          //   TextButton(
          //       onPressed: () => Get.to(() => const ProfilePage()),
          //       child: Icon(
          //         Icons.person,
          //         color: appColor,
          //       )),
          // ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getheight(context, 0.10),
                  const CustomHeadingText(text: "Welcome "),
                  getheight(context, 0.020),
                  Image.network(
                      "https://misoftwaresolutions.com/csdvoters/public/uploads/${signUpController.userImage.value}"),
                  getheight(context, 0.020),

                  CustomTextFormField(
                    controller: signUpController.firstNameController,
                    labelText: "First Name",
                  ),
                  getheight(context, 0.020),
                  CustomTextFormField(
                    controller: signUpController.surNameController,
                    labelText: "Sur Name",
                  ),
                  getheight(context, 0.020),
                  CustomTextFormField(
                    readOnly: true,
                    controller: signUpController.telephoneNumberController,
                    labelText: "Mobile Number",
                  ),
                  getheight(context, 0.020),
                  CustomTextFormField(
                    controller: signUpController.specialPasswordController,
                    labelText: "Special Password",
                  ),
                  getheight(context, 0.020),

                  // signUpController.selectedImagePathforSignUp.value.isNotEmpty
                  //     ? WithImageWidget(
                  //         fileValue:
                  //             signUpController.selectedImagePathforSignUp.value,
                  //         onChangedCamera: () => signUpController
                  //             .getImageforSignUp(ImageSource.camera),
                  //         onChangedCancel: () => signUpController
                  //             .selectedImagePathforSignUp.value = "",
                  //         onChangedGallery: () => signUpController
                  //             .getImageforSignUp(ImageSource.gallery),
                  //       )
                  //     : WithOutImageWidget(
                  //         onChangedCamera: () => signUpController
                  //             .getImageforSignUp(ImageSource.camera),
                  //         onChangedGallery: () => signUpController
                  //             .getImageforSignUp(ImageSource.gallery),
                  //       ),
                  getheight(context, 0.020),
                  !signUpController.isLoading.value
                      ? CustomButton(
                          text: "Submit",
                          onPressed: () async {
                            await signUpController.userUpdates();
                          })
                      : const CustomLoading(),
                  getheight(context, 0.060),
                  const CustomText(text: "Current Application"),
                  getheight(context, 0.010),
                  const CustomText(text: "Version"),
                  getheight(context, 0.010),
                  const CustomText(text: "0.0.1")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

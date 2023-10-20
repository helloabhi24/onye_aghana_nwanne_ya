import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onye_aghana_nwanne_ya/contoller/sign_up_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_syn_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_form_field.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custome_pop_down.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/image_selected_widget.dart';
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
        appBar: const AppBarWidget(
          actions: [CustomSyncButton(), CustomPopDown()],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // getheight(context, 0.10),
                  getheight(context, 0.030),
                  Column(
                    children: [
                      const CustomHeadingText(text: "Welcome"),
                      CustomHeadingText(
                          text:
                              "${signUpController.firstNameProfile.value} ${signUpController.surNameProfile.value}")
                    ],
                  ),
                  getheight(context, 0.020),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone),
                      CustomTextPhone(
                          text:
                              "  (+234) ${signUpController.telephoneProfile.value}"),
                    ],
                  ),
                  getheight(context, 0.020),
                  signUpController.selectedImagePathForProfile.value.isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the radius as needed
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10.0), // Same radius as in BoxDecoration
                            child: Image.network(
                              "https://misoftwaresolutions.com/csdvoters/public/uploads/${signUpController.userImage.value}",
                              errorBuilder: (context, error, stackTrace) {
                                // Handle image loading error here
                                return const CustomText(
                                    text:
                                        "Please Upload Profile Image"); // Fallback text when the image cannot be fetched
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const CircularProgressIndicator(); // Show a loading indicator while the image is loading
                              },
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  getheight(context, 0.020),
                  signUpController.selectedImagePathForProfile.value.isNotEmpty
                      ? WithImageWidget(
                          fileValue: signUpController
                              .selectedImagePathForProfile.value,
                          onChangedCamera: () => signUpController
                              .getImageForProfile(ImageSource.camera),
                          onChangedCancel: () => signUpController
                              .selectedImagePathForProfile.value = "",
                          onChangedGallery: () => signUpController
                              .getImageForProfile(ImageSource.gallery),
                        )
                      : WithOutImageWidget(
                          isAnyImage:
                              signUpController.userImage.isEmpty ? false : true,
                          onChangedCamera: () => signUpController
                              .getImageForProfile(ImageSource.camera),
                          onChangedGallery: () => signUpController
                              .getImageForProfile(ImageSource.gallery),
                        ),
                  getheight(context, 0.020),

                  CustomTextFormField(
                    controller: signUpController.firstNameController,
                    labelText: "First Name",
                  ),
                  getheight(context, 0.020),
                  CustomTextFormField(
                    controller: signUpController.surNameController,
                    labelText: "Surname",
                  ),

                  getheight(context, 0.020),
                  CustomTextFormField(
                    isEnable: false,
                    readOnly: true,
                    controller: signUpController.specialPasswordController,
                    labelText: "Special Password",
                  ),
                  getheight(context, 0.020),

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

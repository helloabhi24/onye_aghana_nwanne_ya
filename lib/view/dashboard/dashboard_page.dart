import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/votar_registration_form/basic_voter_registration_form.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custom_card_widget.dart';
import '../../custom_widgets/custome_pop_down.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final List<Map<String, dynamic>> apiResponses = [
    //   {
    //     "id": 5,
    //     "sub_admin_id": 9,
    //     "form_name": "asjhahjs",
    //     // Add other fields as needed
    //   },
    //   {
    //     "id": 6,
    //     "sub_admin_id": 9,
    //     "form_name": "ggre",
    //     // Add other fields as needed
    //   },
    //   // Add more API response objects as needed
    // ];
    // SignUpController signUpController = Get.find();
    FormController formController = Get.find();
    SharedPref sharedPref = Get.put(SharedPref());
    NetworkController networkController = Get.find();
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
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TextButton(
                //     onPressed: () async {
                //       final prefs = await SharedPreferences.getInstance();
                //       final apiResponsesJson = formController.formsList;
                //       print(apiResponsesJson);
                //       // apiResponses.map((response) {
                //       //   return response
                //       //       .fromJson(); // Convert ApiResponse to JSON
                //       // }).toList();
                //       await prefs.setString(
                //           'api_responses', json.encode(apiResponsesJson));
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text(
                //               'API responses stored in SharedPreferences.'),
                //         ),
                //       );

                //       // await ApiStorage.storeApiResponse(apiResponses);
                //       // ScaffoldMessenger.of(context).showSnackBar(
                //       //   SnackBar(
                //       //     content: Text('API responses stored locally.'),
                //       //   ),
                //       // );
                //     },
                //     child: CustomText(text: "click")),
                // TextButton(
                //     onPressed: () async {
                //       await ApiStorage.getStoredApiResponse();
                //       // print(formController.formsList[0].formData);
                //     },
                //     child: CustomText(text: "click")),
                getheight(context, 0.10),
                CustomHeadingText(
                    text: "List of Forms (${formController.formsList.length})"),
                getheight(context, 0.010),
                formController.formsList.isEmpty
                    ? formController.storedApiResponses.isEmpty
                        ? !formController.isLoading.value
                            ? CustomButton(
                                text: "Refresh Forms",
                                onPressed: () {
                                  customToast("Checking for Forms");
                                  if (networkController.isInternet.value) {
                                    formController.forms(
                                        sharedPref.userID.value, true);
                                  } else {
                                    customToast(
                                        "Please Connect with Internet to For Voter List");
                                  }
                                  formController.isLoading.value =
                                      !formController.isLoading.value;
                                })
                            : const CustomLoading()
                        : SizedBox(
                            height: 500,
                            child: ListView.builder(
                                // physics: AlwaysScrollableScrollPhysics(),
                                itemCount:
                                    formController.storedApiResponses.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(
                                              () =>
                                                  const BasicVoterRegistrationForm(),
                                              arguments: index);
                                          formController.index.value = index;

                                          formController.formsName.value =
                                              formController
                                                      .storedApiResponses[index]
                                                  ["form_name"];
                                          print("this is length of local");
                                          print(formController
                                              .storedApiResponses[formController
                                                  .index.value]["form_data"]
                                              .length);
                                        },
                                        child: CustomCardWidget(
                                          mainCardHeading: formController
                                                  .storedApiResponses[index]
                                              ["form_name"],
                                          numberOnCard: formController
                                              .storedApiResponses[index]
                                                  ["voters_count"]
                                              .toString(),
                                          // saveDraftText: "Save & Draft: 20",
                                        ),
                                      ),
                                      getheight(context, 0.010),
                                    ],
                                  );
                                }),
                          )
                    : SizedBox(
                        height: 500,
                        child: ListView.builder(
                            // physics: AlwaysScrollableScrollPhysics(),
                            itemCount: formController.formsList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          () =>
                                              const BasicVoterRegistrationForm(),
                                          arguments: index);
                                      formController.index.value = index;
                                      formController.formsName.value =
                                          formController
                                              .formsList[index].formName;
                                    },
                                    child: CustomCardWidget(
                                      mainCardHeading: formController
                                          .formsList[index].formName,
                                      numberOnCard: formController
                                          .formsList[index].votersCount
                                          .toString(),
                                      // saveDraftText: "Save & Draft: 20",
                                    ),
                                  ),
                                  getheight(context, 0.010),
                                ],
                              );
                            }),
                      ),
                // GestureDetector(
                //   onTap: () => Get.to(() => const SaveDraftForm()),
                //   child: const CustomCardWidget(
                //     mainCardHeading: "Voter Registration Form",
                //     numberOnCard: "10",
                //     saveDraftText: "Save & Draft: 20",
                //   ),
                // ),
                // getheight(context, 0.010),
                // const CustomCardWidget(
                //   mainCardHeading: "Voter Feedback Forms",
                //   numberOnCard: "23",
                // ),
                // getheight(context, 0.010),
                // const CustomCardWidget(
                //   mainCardHeading: "Campaign Finance Reporting Forms",
                //   numberOnCard: "39",
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

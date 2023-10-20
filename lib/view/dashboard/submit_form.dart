import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_card_widget.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_floating_action_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_syn_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custome_pop_down.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/view/dashboard/save_and_draft_form.dart';
import 'package:onye_aghana_nwanne_ya/view/votar_registration_form/basic_voter_registration_form.dart';
import '../../custom_widgets/app_bar_widget.dart';

class SubmitForm extends StatelessWidget {
  const SubmitForm({super.key});

  @override
  Widget build(BuildContext context) {
    FormController formController = Get.find();
    NetworkController networkController = Get.put(NetworkController());
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
          icon: Icon(
            Icons.add,
            color: appYellowColor,
          ),
          onPressed: () {
            formController.genderValue.value = "Select Gender";

            formController.maritualValue.value = "Select Maritual Status";
            Get.to(() => const BasicVoterRegistrationForm(
                  isEdit: false,
                ));
          }),
      appBar: const AppBarWidget(
        actions: [CustomSyncButton(), CustomPopDown()],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomSelectedButton(
                    text: "Save & Draft",
                    onPressed: () {
                      Get.off(() => const SaveDraftForm(),
                          transition: Transition.noTransition,
                          arguments: Get.arguments);
                    },
                    isSelected: false,
                  ),
                  getwidth(context, 0.010),
                  CustomSelectedButton(
                    text: "Submit",
                    onPressed: () {},
                    isSelected: true,
                  ),
                ],
              ),
              // getheight(context, 0.020),
              // CustomExpandedButton(text: "Search Keywords", onPressed: () {}),
              getheight(context, 0.020),
              Obx(
                () => !formController.isGetData.value
                    ? formController.dataAccordingFormsList.isNotEmpty
                        ? SizedBox(
                            height: 600,
                            child: ListView.builder(
                              itemCount:
                                  formController.dataAccordingFormsList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    // for (final mapEntry in values[2][index].data.entries)
                                    //   CustomContainerListTile(
                                    //       title:
                                    //       //  "${values[2][index].data.forEach(
                                    //       //       (k, v) => 'sdfs',
                                    //       //     )}",
                                    //       // "${mapEntry.key}: ${mapEntry.value}",
                                    //       subtitle: "+234 803 231 5890",
                                    //       image: const CircleAvatar(),
                                    //       onIconPressed: () {
                                    //         print("hello");
                                    //       }),

                                    CustomContainerListDataTile(
                                        title:
                                            "${(formController.dataAccordingFormsList[index].firstName)} ${formController.dataAccordingFormsList[index].middelName} ${formController.dataAccordingFormsList[index].surName}",
                                        isVerified: formController
                                            .dataAccordingFormsList[index]
                                            .isVerified,
                                        // "${values[2][index].data.keys}: ${values[2][index].data.values}",
                                        subtitle: formController
                                            .dataAccordingFormsList[index]
                                            .telephone,
                                        pollUnit: formController
                                            .dataAccordingFormsList[index]
                                            .pollUnit,
                                        dob: formController
                                            .dataAccordingFormsList[index].dob,
                                        gender: formController
                                            .dataAccordingFormsList[index]
                                            .gender,
                                        maritalStatus: formController
                                            .dataAccordingFormsList[index]
                                            .maritualStatus,
                                        image: const CircleAvatar(),
                                        isSync: false,
                                        onIconPressed: () {}),
                                    getheight(context, 0.010)
                                  ],
                                );
                              },
                            ),
                          )
                        : Column(
                            children: [
                              getheight(context, 0.25),
                              const CustomBoldText(text: "No Data Found"),
                            ],
                          )
                    : CustomLoading(),
              ),
              // CustomContainerListTile(
              //     title: "Ngozi Adeola (M)",
              //     subtitle: "+234 803 231 5890",
              //     image: const CircleAvatar(),
              //     onIconPressed: () {}),
              // getheight(context, 0.020),
              // CustomContainerListTile(
              //     title: "Ifeoma (M)",
              //     subtitle: "+234 803 322 3455",
              //     image: const CircleAvatar(),
              //     onIconPressed: () {}),
              // getheight(context, 0.020),
              // CustomContainerListTile(
              //     title: "Obinna Chioma (M)",
              //     subtitle: "+234 803 322 3455",
              //     image: const CircleAvatar(),
              //     onIconPressed: () {}),
              // getheight(context, 0.020),
              // CustomContainerListTile(
              //     title: "Jadhesdha Lautne (M)",
              //     subtitle: "+234 803 322 3455",
              //     image: const CircleAvatar(),
              //     onIconPressed: () {}),
              // getheight(context, 0.020),
              // CustomContainerListTile(
              //     title: "Pehtsar Healmar (M)",
              //     subtitle: "+234 803 322 3455",
              //     image: const CircleAvatar(),
              //     onIconPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

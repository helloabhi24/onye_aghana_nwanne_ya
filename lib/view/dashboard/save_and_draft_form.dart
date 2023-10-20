import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_card_widget.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_floating_action_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_syn_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/services/local_database_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/dashboard/submit_form.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custome_pop_down.dart';
import '../votar_registration_form/basic_voter_registration_form.dart';

class SaveDraftForm extends StatelessWidget {
  const SaveDraftForm({super.key});

  @override
  Widget build(BuildContext context) {
    FormController formController = Get.find();
    SharedPref sharedPref = Get.put(SharedPref());
    NetworkController networkController = Get.put(NetworkController());
    // var values = Get.arguments;
    // formController.values.clear();
    // formController.values.value = Get.arguments ?? [];

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
                    onPressed: () async {
                      print("length");
                      // print(formController.saveAndDrftList.length);
                      // for (var i in formController.saveAndDrftList) {
                      //   print(i);
                      // }
                      // print("dfh");
                      // print(formController.values[2].length);
                      // print("argument");
                      // print(Get.arguments);
                      // print(formController.values[2].length != 0);
                      // await formController.loadStoredData();
                      // await formController.loadSubmitStoredData();
                    },
                    isSelected: true,
                  ),
                  getwidth(context, 0.010),
                  // !formController.isGetData.value
                  Obx(
                    () => !formController.isGetData.value
                        ? CustomSelectedButton(
                            text: "Submit",
                            onPressed: () async {
                              networkController.isInternet.value
                                  ? await formController.getDataAccrodingform()
                                  : customToast("Please Connect with Internet");
                              Get.off(() => const SubmitForm(),
                                  transition: Transition.noTransition,
                                  arguments: formController.values);
                            },
                            isSelected: false,
                          )
                        : Row(
                            children: [
                              getwidth(context, 0.15),
                              const CustomLoading(),
                            ],
                          ),
                  ),
                ],
              ),

              getheight(context, 0.020),
              // CustomExpandedButton(text: "Search Keywords", onPressed: () {}),
              // getheight(context, 0.020),

              // formController.values.isNotEmpty
              // ? formController.values[2].length != 0
              // ?
              formController.saveAndDrftList.isNotEmpty
                  ? SizedBox(
                      height: 500,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ListView.builder(
                          reverse: false,
                          // itemCount: formController.values[2].length,
                          itemCount: formController.saveAndDrftList.length,
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

                                CustomContainerListTileForAll(
                                    title:
                                        "${(formController.saveAndDrftList[index]["firstName"]) ?? ""} ${(formController.saveAndDrftList[index]["middleName"]) ?? ""} ${(formController.saveAndDrftList[index]["surName"]) ?? ""}",
                                    subtitle:
                                        "${(formController.saveAndDrftList[index]["phone"]) ?? ""}",
                                    pollUnit:
                                        "${(formController.saveAndDrftList[index]["pollUnit"]) ?? ""}",
                                    dob:
                                        "${(formController.saveAndDrftList[index]["dob"]) ?? ""}",
                                    gender:
                                        "${(formController.saveAndDrftList[index]["gender"]) != null ? (formController.saveAndDrftList[index]["gender"]) == "Select Gender" ? "" : (formController.saveAndDrftList[index]["gender"]) : ""}",
                                    // "${(formController.saveAndDrftList[index]["gender"]) ?? ""}",
                                    maritalStatus:
                                        "${(formController.saveAndDrftList[index]["maritalStatus"]) != null ? (formController.saveAndDrftList[index]["maritalStatus"]) == "Select Maritual Status" ? "" : (formController.saveAndDrftList[index]["maritalStatus"]) : ""}",
                                    // title:
                                    //     "${formController.values[2][index].data["First Name"]} ${(formController.values[2][index].data["Middle Name"]) ?? ""} ${(formController.values[2][index].data["Surname"]) ?? ""}",

                                    // "${values[2][index].data.keys}: ${values[2][index].data.values}",
                                    // subtitle:
                                    //     "${(formController.values[2][index].data["Mobile Number"]) ?? ""}",
                                    // pollUnit: (formController.values[2][index]
                                    //         .data["Poll Unit"]) ??
                                    //     "",
                                    image: const CircleAvatar(),
                                    onIconPressed: () async {
                                      // print(formController
                                      //     .values[2][index].data["First Name"]);

                                      print("this is id");
                                      print(sharedPref.userID.value);
                                      print(formController
                                          .saveAndDrftList[index]["formid"]);
                                      print(formController
                                          .saveAndDrftList[index]['id']);
                                      formController.formEditId.value =
                                          formController.saveAndDrftList[index]
                                                  ['id']
                                              .toString();
                                      formController.editDrftList.clear();
                                      await LocalDatabaseHelper.getSingleNote(
                                          sharedPref.userID.value,
                                          formController.saveAndDrftList[index]
                                              ["formid"],
                                          formController.saveAndDrftList[index]
                                                  ['id']
                                              .toString());
                                      print("this is id");
                                      // print(formController.values[2][index].id);
                                      print("this is first name");
                                      // print(formController
                                      //     .values[2][index].data["First Name"]);
                                      if (formController.formsList.isNotEmpty) {
                                        print("sartr");
                                        print(formController.genderValue.value);
                                        formController
                                                    .formsList[formController
                                                        .index.value]
                                                    .gender ==
                                                "1"
                                            ? formController.genderValue.value =
                                                formController.editDrftList[0]
                                                    ["gender"]
                                            : null;
                                        print("hid");
                                        print(formController.genderValue.value);
                                        formController
                                                    .formsList[formController
                                                        .index.value]
                                                    .maritualStatus ==
                                                "1"
                                            ? formController
                                                    .maritualValue.value =
                                                formController.editDrftList[0]
                                                        ["maritalStatus"]
                                                    .toString()
                                            : null;
                                        formController
                                                    .formsList[formController
                                                        .index.value]
                                                    .firstName ==
                                                "1"
                                            ? formController
                                                    .firstFormController.text =
                                                formController.editDrftList[0]
                                                    ["firstName"]
                                            : null;
                                        formController
                                                    .formsList[formController
                                                        .index.value]
                                                    .middelName ==
                                                "1"
                                            ? formController
                                                    .middleFormController.text =
                                                formController.editDrftList[0]
                                                    ["middleName"]
                                            : null;
                                        formController
                                                    .formsList[formController
                                                        .index.value]
                                                    .surName ==
                                                "1"
                                            ? formController
                                                    .surFormController.text =
                                                formController.editDrftList[0]
                                                    ["surName"]
                                            : null;
                                        formController
                                                    .formsList[formController
                                                        .index.value]
                                                    .telephone ==
                                                "1"
                                            ? formController
                                                    .teleFormController.text =
                                                formController.editDrftList[0]
                                                    ["phone"]
                                            : null;
                                        formController
                                                    .formsList[formController
                                                        .index.value]
                                                    .address ==
                                                "1"
                                            ? formController
                                                    .addressFormController
                                                    .text =
                                                formController.editDrftList[0]
                                                    ["address"]
                                            : null;
                                        formController
                                                    .formsList[formController
                                                        .index.value]
                                                    .dob ==
                                                "1"
                                            ? formController
                                                    .dobController.text =
                                                formController.editDrftList[0]
                                                    ["dob"]
                                            : null;
                                        formController
                                                    .formsList[formController
                                                        .index.value]
                                                    .pollUnit ==
                                                "1"
                                            ? formController
                                                    .pollUnitController.text =
                                                formController.editDrftList[0]
                                                    ["pollUnit"]
                                            : null;

                                        print("this is gender value");
                                        print(formController.genderValue.value);
                                        print(
                                            formController.maritualValue.value);
                                        print(formController.editDrftList[0]
                                            ["maritalStatus"]);
                                      } else if (formController
                                          .storedApiResponses.isNotEmpty) {
                                        formController.storedApiResponses[
                                                    formController.index
                                                        .value]["first_name"] ==
                                                "1"
                                            ? formController
                                                    .firstFormController.text =
                                                formController.editDrftList[0]
                                                    ["firstName"]
                                            : null;
                                        formController.storedApiResponses[
                                                        formController
                                                            .index.value]
                                                    ["middel_name"] ==
                                                "1"
                                            ? formController
                                                    .middleFormController.text =
                                                formController.editDrftList[0]
                                                    ["middleName"]
                                            : null;
                                        formController.storedApiResponses[
                                                    formController.index
                                                        .value]["sur_name"] ==
                                                "1"
                                            ? formController
                                                    .surFormController.text =
                                                formController.editDrftList[0]
                                                    ["surName"]
                                            : null;
                                        formController.storedApiResponses[
                                                    formController.index
                                                        .value]["telephone"] ==
                                                "1"
                                            ? formController
                                                    .teleFormController.text =
                                                formController.editDrftList[0]
                                                    ["phone"]
                                            : null;
                                        formController.storedApiResponses[
                                                    formController.index
                                                        .value]["address"] ==
                                                "1"
                                            ? formController
                                                    .addressFormController
                                                    .text =
                                                formController.editDrftList[0]
                                                    ["address"]
                                            : null;
                                        formController.storedApiResponses[
                                                    formController
                                                        .index.value]["dob"] ==
                                                "1"
                                            ? formController
                                                    .dobController.text =
                                                formController.editDrftList[0]
                                                    ["dob"]
                                            : null;
                                        formController.storedApiResponses[
                                                    formController.index
                                                        .value]["poll_unit"] ==
                                                "1"
                                            ? formController
                                                    .pollUnitController.text =
                                                formController.editDrftList[0]
                                                    ["pollUnit"]
                                            : null;

                                        formController.storedApiResponses[
                                                    formController.index
                                                        .value]["gender"] ==
                                                "1"
                                            ? formController.genderValue.value =
                                                formController.editDrftList[0]
                                                    ["gender"]
                                            : null;

                                        formController.storedApiResponses[
                                                        formController
                                                            .index.value]
                                                    ["maritual_status"] ==
                                                "1"
                                            ? formController
                                                    .maritualValue.value =
                                                formController.editDrftList[0]
                                                    ["maritalStatus"]
                                            : null;
                                      }
                                      Get.to(
                                          () =>
                                              const BasicVoterRegistrationForm(
                                                  isEdit: true),
                                          arguments: [
                                            // formController.values[2][index].data,
                                            // formController.values[2][index].id
                                          ]);
                                      // formController.formsName.value =
                                      //     formController
                                      //         .values[2][index].formName;
                                    }),
                                getheight(context, 0.010)
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        getheight(context, 0.25),
                        const CustomBoldText(text: "No Data Found"),
                      ],
                    )
              // : const SizedBox.shrink(),
              // getheight(context, 0.020),
              // CustomContainerListTile(
              //     title: "Babatunde (M)",
              //     subtitle: "+234 803 322 3455",
              //     image: const CircleAvatar(),
              //     onIconPressed: () {}),
              // getheight(context, 0.020),
              // CustomContainerListTile(
              //     title: "Yetunde Ayodele (M)",
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

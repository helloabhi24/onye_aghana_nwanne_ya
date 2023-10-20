import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_syn_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/services/local_database_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custom_card_widget.dart';
import '../../custom_widgets/custome_pop_down.dart';
import 'save_and_draft_form.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late dynamic database;
  @override
  void initState() {
    super.initState();
    database = LocalDatabaseHelper.getDB();
    LocalDatabaseHelper.getAllNote();
  }

  @override
  Widget build(BuildContext context) {
    FormController formController = Get.find();
    SharedPref sharedPref = Get.put(SharedPref());

    return Obx(
      () => Scaffold(
        appBar: const AppBarWidget(
          actions: [CustomSyncButton(), CustomPopDown()],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getheight(context, 0.10),
                CustomHeadingText(
                    text:
                        "List of Forms (${formController.formsList.isNotEmpty ? formController.formsList.length : formController.storedApiResponses.length})"),
                getheight(context, 0.010),
                formController.formsList.isEmpty
                    ? formController.storedApiResponses.isEmpty
                        ? Column(
                            children: [
                              getheight(context, 0.20),
                              const CustomText(text: "No Form Data Found"),
                            ],
                          )
                        : Obx(
                            () => SizedBox(
                              height: 500,
                              child: ListView.builder(
                                  // physics: AlwaysScrollableScrollPhysics(),
                                  itemCount:
                                      formController.storedApiResponses.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await LocalDatabaseHelper
                                                .getSelectedNote(
                                                    sharedPref.userID.value,
                                                    formController
                                                        .storedApiResponses[
                                                            index]['id']
                                                        .toString());
                                            await formController
                                                .loadStoredData();
                                            await formController
                                                .loadSubmitStoredData();

                                            Get.to(() => const SaveDraftForm(),
                                                arguments: [
                                                  formController
                                                          .storedApiResponses[
                                                      index]["form_name"],
                                                  formController.saveDraftCount(
                                                      formController
                                                          .localDataList,
                                                      formController
                                                              .storedApiResponses[
                                                          index]["form_name"]),
                                                  formController.saveDraftList(
                                                      formController
                                                          .localDataList,
                                                      formController
                                                              .storedApiResponses[
                                                          index]["form_name"])
                                                ],
                                                transition:
                                                    Transition.noTransition);
                                            formController.values.clear();
                                            formController.values.value = [
                                              formController
                                                      .storedApiResponses[index]
                                                  ["form_name"],
                                              formController.saveDraftCount(
                                                  formController.localDataList,
                                                  formController
                                                          .storedApiResponses[
                                                      index]["form_name"]),
                                              formController.saveDraftList(
                                                  formController.localDataList,
                                                  formController
                                                          .storedApiResponses[
                                                      index]["form_name"])
                                            ];
                                            formController.genderValue.value =
                                                "Select Gender";

                                            formController.maritualValue.value =
                                                "Select Maritual Status";
                                            formController.index.value = index;

                                            formController.formsName
                                                .value = formController
                                                    .storedApiResponses[index]
                                                ["form_name"];

                                            formController.saveDraftList(
                                                formController.localDataList,
                                                formController
                                                        .storedApiResponses[
                                                    index]["form_name"]);

                                            formController.formID.value =
                                                formController
                                                    .storedApiResponses[index]
                                                        ['id']
                                                    .toString();
                                            formController.subadminID.value =
                                                formController
                                                    .storedApiResponses[index]
                                                        ['sub_admin_id']
                                                    .toString();
                                          },
                                          child: Obx(
                                            () => CustomCardWidget(
                                              mainCardHeading: formController
                                                      .storedApiResponses[index]
                                                  ["form_name"],
                                              numberOnCard: formController
                                                  .storedApiResponses[index]
                                                      ["voters_count"]
                                                  .toString(),
                                              saveDraftText: LocalDatabaseHelper
                                                  .getDraftCount(
                                                      sharedPref.userID.value,
                                                      formController
                                                          .storedApiResponses[
                                                              index]['id']
                                                          .toString()),
                                              submitText:
                                                  "Submit: ${formController.storedApiResponses[index]["voters_count"]}",
                                              formName: formController
                                                      .storedApiResponses[index]
                                                  ["form_name"],
                                              formLength:
                                                  formController.saveDraftCount(
                                                      formController
                                                          .localDataList,
                                                      formController
                                                              .storedApiResponses[
                                                          index]["form_name"]),
                                              index: index,
                                            ),
                                          ),
                                        ),
                                        getheight(context, 0.010),
                                      ],
                                    );
                                  }),
                            ),
                          )
                    : Obx(
                        () => SizedBox(
                          height: 500,
                          child: ListView.builder(
                              // physics: AlwaysScrollableScrollPhysics(),
                              itemCount: formController.formsList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await LocalDatabaseHelper
                                            .getSelectedNote(
                                                sharedPref.userID.value,
                                                formController
                                                    .formsList[index].id
                                                    .toString());

                                        await formController.loadStoredData();
                                        await formController
                                            .loadSubmitStoredData();

                                        Get.to(() => const SaveDraftForm(),
                                            arguments: [
                                              formController
                                                  .formsList[index].formName,
                                              formController.saveDraftCount(
                                                  formController.localDataList,
                                                  formController
                                                      .formsList[index]
                                                      .formName),
                                              formController.saveDraftList(
                                                  formController.localDataList,
                                                  formController
                                                      .formsList[index]
                                                      .formName)
                                            ],
                                            transition:
                                                Transition.noTransition);
                                        formController.values.clear();
                                        formController.values.value = [
                                          formController
                                              .formsList[index].formName,
                                          formController.saveDraftCount(
                                              formController.localDataList,
                                              formController
                                                  .formsList[index].formName),
                                          formController.saveDraftList(
                                              formController.localDataList,
                                              formController
                                                  .formsList[index].formName)
                                        ];

                                        formController.genderValue.value =
                                            "Select Gender";

                                        formController.maritualValue.value =
                                            "Select Maritual Status";
                                        formController.index.value = index;

                                        formController.formsName.value =
                                            formController
                                                .formsList[index].formName;

                                        formController.saveDraftList(
                                            formController.localDataList,
                                            formController
                                                .formsList[index].formName);

                                        formController.formID.value =
                                            formController.formsList[index].id
                                                .toString();
                                        formController.subadminID.value =
                                            formController
                                                .formsList[index].subAdminId
                                                .toString();
                                      },
                                      child: Obx(
                                        () => CustomCardWidget(
                                          mainCardHeading: formController
                                              .formsList[index].formName,
                                          numberOnCard: formController
                                              .formsList[index].votersCount
                                              .toString(),
                                          saveDraftText:
                                              LocalDatabaseHelper.getDraftCount(
                                                  sharedPref.userID.value,
                                                  formController
                                                      .formsList[index].id
                                                      .toString()),
                                          submitText:
                                              "Submit: ${formController.formsList[index].votersCount}",
                                          formName: formController
                                              .formsList[index].formName,
                                          formLength:
                                              formController.saveDraftCount(
                                                  formController.localDataList,
                                                  formController
                                                      .formsList[index]
                                                      .formName),
                                          index: index,
                                        ),
                                      ),
                                    ),
                                    getheight(context, 0.010),
                                  ],
                                );
                              }),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

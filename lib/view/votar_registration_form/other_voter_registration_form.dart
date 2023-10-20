import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_date_picker.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_floating_action_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_form_field_with_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/drop_down_widget.dart';
import 'package:onye_aghana_nwanne_ya/model/db_data_model.dart';
import 'package:onye_aghana_nwanne_ya/services/local_database_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/view/dashboard/dashboard_page.dart';
import 'package:onye_aghana_nwanne_ya/view/votar_registration_form/basic_voter_registration_form.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custom_syn_button.dart';
import '../../custom_widgets/custome_pop_down.dart';
import '../../custom_widgets/image_selected_widget.dart';

class OtherVoterRegistrationForm extends StatefulWidget {
  final bool? isEdit;
  const OtherVoterRegistrationForm({super.key, required this.isEdit});

  @override
  State<OtherVoterRegistrationForm> createState() =>
      _OtherVoterRegistrationFormState();
}

class _OtherVoterRegistrationFormState
    extends State<OtherVoterRegistrationForm> {
  // List<TextEditingController> generalController = [];
  FormController formController = Get.find();
  NetworkController networkController = Get.put(NetworkController());
  Map textMap = {};
  SharedPref sharedPref = Get.put(SharedPref());
  List submitList = [];

  @override
  void initState() {
    super.initState();
    if (formController.formsList.isNotEmpty) {
      for (int i = 0;
          i <
              formController
                  .formsList[formController.index.value].formData.length;
          i++) {
        print("value of i");
        print(i);
        formController.formsList[formController.index.value].formData[i]
                        .questionType ==
                    "1" ||
                formController.formsList[formController.index.value].formData[i]
                        .questionType ==
                    "2"
            ? formController.generalController.add(TextEditingController(
                text: widget.isEdit!
                    ? formController.ohterWholeList[i]["value"]
                    : ""))
            : null;
      }
    } else if (formController.storedApiResponses.isNotEmpty) {
      for (int i = 0;
          i <
              formController
                  .storedApiResponses[formController.index.value]['form_data']
                  .length;
          i++) {
        formController.storedApiResponses[formController.index.value]
                        ['form_data'][i]['question_type'] ==
                    "1" ||
                formController.storedApiResponses[formController.index.value]
                        ['form_data'][i]['question_type'] ==
                    "2"
            ? formController.generalController.add(TextEditingController(
                text: widget.isEdit!
                    ? formController.ohterWholeList[i]["value"]
                    : ""))
            : null;
      }
    }
  }

  late int id;
  //= Get.arguments[1] ?? 0;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    DateTime selectedDate = DateTime.now();

    void handleDateChanged(DateTime newDate) {
      setState(() {
        selectedDate = newDate;
      });
    }

    if (widget.isEdit!) {
      // id = Get.arguments[1];
      id = 0;
    } else {
      id = 0;
    }

    var vari;
    var variLocal;

    if (formController.formsList.isNotEmpty) {
      vari = formController.formsList[formController.index.value].formData;
    }
    if (formController.storedApiResponses.isNotEmpty) {
      variLocal = formController.storedApiResponses[formController.index.value]
          ["form_data"];
    }
    Map allData = {}.obs;
    void finalDataf(Map map) {
      allData.addAll(map);
      print(allData);
    }

    void addData(String question, dynamic value) {
      Map map = {question: value};
      finalDataf(map);
    }

    int getcontrollerIndexTextLocal(int i) {
      final a = (formController.storedApiResponses[formController.index.value]
              ["form_data"] as List)
          .where((v) => v['question_type'] == "1" || v['question_type'] == "2")
          .toList();
      var indexList = [];
      for (var i = 0; i < a.length; i++) {
        indexList.add(formController
            .storedApiResponses[formController.index.value]["form_data"]
            .indexOf(a[i]));
      }
      print(indexList);
      // [3, 7]
      return indexList.indexOf(i); // 0
    }

    int getcontrollerIndexText(int i) {
      final a = (vari as List)
          .where((v) => v.questionType == "1" || v.questionType == "2")
          .toList();
      var indexList = [];
      for (var i = 0; i < a.length; i++) {
        indexList.add(vari.indexOf(a[i]));
      }
      print(indexList);
      // [3, 7]
      return indexList.indexOf(i); // 0
    }

    return WillPopScope(
      onWillPop: () async {
        formController.firstFormController.clear();
        formController.middleFormController.clear();
        formController.surFormController.clear();
        formController.teleFormController.clear();
        formController.addressFormController.clear();
        formController.dobController.clear();
        formController.pollUnitController.clear();
        formController.generalController.clear();
        formController.allData.clear();
        formController.editedData.clear();
        formController.editedSubmitData.clear();
        formController.ohterWholeList.clear();
        return true;
      },
      child: Scaffold(
        appBar: const AppBarWidget(
          actions: [CustomSyncButton(), CustomPopDown()],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getheight(context, 0.020),
                      CustomHeadingText(text: formController.formsName.value),
                      getheight(context, 0.040),
                      Row(
                        children: [
                          CustomSelectedButton(
                            text: "Basic",
                            onPressed: () {},
                            isSelected: false,
                          ),
                          getwidth(context, 0.010),
                          CustomSelectedButton(
                            text: "Other Info",
                            onPressed: () {},
                            isSelected: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                  getheight(context, 0.020),
                  Column(
                    children: [
                      formController.formsList.isNotEmpty
                          ? SizedBox(
                              // height: Get.height * (vari.length / 7.3),
                              height: Get.height * 0.595,
                              child: Form(
                                onChanged: () {
                                  // Form.of(primaryFocus!.context!).save();
                                  print("any");
                                },
                                key: _formKey,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: vari.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text:
                                                    "${index + 1}. ${vari[index].question}",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: ' *',
                                                      style: TextStyle(
                                                          color: redColor)),
                                                ]),
                                          ),
                                          getheight(context, 0.010),
                                          vari[index].questionType == "1"
                                              ? CustomTextFormFieldWithController(
                                                  key: UniqueKey(),
                                                  controller: formController
                                                          .generalController[
                                                      getcontrollerIndexText(
                                                          index)],
                                                  onTap: () {
                                                    print(formController
                                                        .generalController[
                                                            index]
                                                        .text);
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter ${vari[index].question}';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (p0) {
                                                    formController
                                                            .ohterWholeList[
                                                        index]["value"] = p0;
                                                    print("editng");
                                                    print(formController
                                                        .ohterWholeList);
                                                  })
                                              : const SizedBox.shrink(),
                                          vari[index].questionType == "2"
                                              ? CustomTextFormFieldAddressWithController(
                                                  key: UniqueKey(),
                                                  controller: formController
                                                          .generalController[
                                                      getcontrollerIndexText(
                                                          index)],
                                                  onTap: () {
                                                    print("this is index");
                                                    print(index);
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter ${vari[index].question}';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (p0) {
                                                    formController
                                                            .ohterWholeList[
                                                        index]["value"] = p0;
                                                    print("editing");
                                                    print(formController
                                                        .ohterWholeList);
                                                  },
                                                )
                                              : const SizedBox.shrink(),
                                          vari[index].questionType == "3"
                                              ? DropDownWidget(
                                                  index: index,
                                                  valueList: vari[index]
                                                      .value
                                                      .split('|')
                                                    ..insert(0, "select item"),
                                                  dropValue: widget.isEdit!
                                                      ? formController
                                                          .ohterWholeList[index]
                                                              ["value"]
                                                          .toString()
                                                      // Get.arguments[0]
                                                      //     [vari[index].question]
                                                      : (vari[index]
                                                              .value
                                                              .split('|')
                                                            ..insert(0,
                                                                "select item"))
                                                          .first,
                                                  valueOnText:
                                                      vari[index].question,
                                                  isEdit: widget.isEdit,
                                                  editableList: widget.isEdit!
                                                      ? Get.arguments
                                                      : [],
                                                )
                                              : const SizedBox.shrink(),
                                          vari[index].questionType == "4"
                                              ? MultiSelectValue(
                                                  index: index,
                                                  initialValue: widget.isEdit!
                                                      ? formController
                                                              .ohterWholeList[
                                                          index]["value"]
                                                      : "",
                                                  listValue: vari[index]
                                                      .value
                                                      .split("|"),
                                                  // selectedList: formController.multi,
                                                  questionValue:
                                                      vari[index].question,
                                                  isEdit: widget.isEdit,
                                                  editableList: widget.isEdit!
                                                      ? Get.arguments
                                                      : [],
                                                )
                                              : const SizedBox.shrink(),
                                          vari[index].questionType == "5"
                                              ? NoParameterImageWidget(
                                                  index: index,
                                                  isEdit: widget.isEdit,
                                                  editableList: widget.isEdit!
                                                      ? Get.arguments
                                                      : [],
                                                  base64String: widget.isEdit!
                                                      ? formController
                                                              .ohterWholeList[
                                                          index]["value"]
                                                      : "",
                                                  questionName:
                                                      vari[index].question,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter ${vari[index].question}';
                                                    }
                                                    return null;
                                                  })
                                              : const SizedBox.shrink(),
                                          vari[index].questionType == "6"
                                              ? CustomDatePicker(
                                                  index: index,
                                                  isEdit: widget.isEdit,
                                                  editableList: widget.isEdit!
                                                      ? Get.arguments
                                                      : [],
                                                  value: widget.isEdit!
                                                      ? formController
                                                              .ohterWholeList[
                                                          index]["value"]
                                                      : "",
                                                  questionValue:
                                                      vari[index].question,
                                                )
                                              : const SizedBox.shrink(),
                                          getheight(context, 0.010)
                                        ],
                                      );
                                    }),
                              ),
                            )
                          : SizedBox(
                              // height: Get.height * (vari.length / 7.3),
                              height: Get.height * 0.595,
                              child: Form(
                                key: _formKey,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: variLocal.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: Get.width * 0.80,
                                                child: CustomText(
                                                    text: variLocal[index]
                                                        ["question"]),
                                              ),
                                              variLocal[index]["mandatory"] ==
                                                      "1"
                                                  ? RichText(
                                                      text: const TextSpan(
                                                          text: ' *',
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )))
                                                  : const SizedBox.shrink()
                                            ],
                                          ),
                                          getheight(context, 0.010),
                                          variLocal[index]["question_type"] ==
                                                  "1"
                                              ? CustomTextFormFieldWithController(
                                                  key: UniqueKey(),
                                                  controller: formController
                                                          .generalController[
                                                      getcontrollerIndexTextLocal(
                                                          index)],
                                                  onTap: () {
                                                    print(formController
                                                        .generalController[
                                                            index]
                                                        .text);
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter ${variLocal[index]["question"]}';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (p0) {
                                                    formController
                                                            .ohterWholeList[
                                                        index]["value"] = p0;
                                                    // if (p0.isNotEmpty) {
                                                    //   Form.of(primaryFocus!
                                                    //           .context!)
                                                    //       .save();
                                                    //   print(p0);
                                                    //   if (widget.isEdit!) {
                                                    //     formController
                                                    //         .updateValue(
                                                    //             Get.arguments,
                                                    //             variLocal[index]
                                                    //                 [
                                                    //                 "question"],
                                                    //             p0);
                                                    //   } else {
                                                    //     formController.addData(
                                                    //         variLocal[index]
                                                    //             ["question"],
                                                    //         p0);
                                                    //     formController
                                                    //         .finalQuestionData(
                                                    //             variLocal[index]
                                                    //                 [
                                                    //                 "question"],
                                                    //             p0,
                                                    //             'text');
                                                    //   }
                                                    // }
                                                  })
                                              : const SizedBox.shrink(),
                                          variLocal[index]["question_type"] ==
                                                  "2"
                                              ? CustomTextFormFieldAddressWithController(
                                                  key: UniqueKey(),
                                                  controller: formController
                                                          .generalController[
                                                      getcontrollerIndexTextLocal(
                                                          index)],
                                                  onTap: () {
                                                    print("this is index");
                                                    print(index);
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter ${variLocal[index]["question"]}';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (p0) {
                                                    formController
                                                            .ohterWholeList[
                                                        index]["value"] = p0;
                                                    // if (p0.isNotEmpty) {
                                                    //   widget.isEdit!
                                                    //       ? formController
                                                    //           .updateValue(
                                                    //               Get.arguments,
                                                    //               variLocal[
                                                    //                       index]
                                                    //                   [
                                                    //                   "question"],
                                                    //               p0)
                                                    //       : formController
                                                    //           .addData(
                                                    //               variLocal[
                                                    //                       index]
                                                    //                   [
                                                    //                   "question"],
                                                    //               p0);
                                                    // }
                                                  },
                                                )
                                              : const SizedBox.shrink(),
                                          variLocal[index]["question_type"] ==
                                                  "3"
                                              ? DropDownWidget(
                                                  index: index,
                                                  valueList: variLocal[index]
                                                          ["_value"]
                                                      .split('|')
                                                    ..insert(0, "select item"),
                                                  dropValue: widget.isEdit!
                                                      ? formController
                                                          .ohterWholeList[index]
                                                              ["value"]
                                                          .toString()
                                                      : (variLocal[index]
                                                                  ["_value"]
                                                              .split('|')
                                                            ..insert(0,
                                                                "select item"))
                                                          .first,
                                                  valueOnText: variLocal[index]
                                                      ["question"],
                                                  isEdit: widget.isEdit,
                                                  editableList: widget.isEdit!
                                                      ? Get.arguments
                                                      : [],
                                                )
                                              : const SizedBox.shrink(),
                                          variLocal[index]["question_type"] ==
                                                  "4"
                                              ? MultiSelectValue(
                                                  index: index,
                                                  initialValue: widget.isEdit!
                                                      ? formController
                                                              .ohterWholeList[
                                                          index]["value"]
                                                      : "",
                                                  listValue: variLocal[index]
                                                          ["_value"]
                                                      .split("|"),
                                                  // selectedList: formController.multi,
                                                  questionValue:
                                                      variLocal[index]
                                                          ["question"],
                                                  isEdit: widget.isEdit,
                                                  editableList: widget.isEdit!
                                                      ? Get.arguments
                                                      : [],
                                                )
                                              : const SizedBox.shrink(),
                                          variLocal[index]["question_type"] ==
                                                  "5"
                                              ? NoParameterImageWidget(
                                                  index: index,
                                                  isEdit: widget.isEdit,
                                                  editableList: widget.isEdit!
                                                      ? Get.arguments
                                                      : [],
                                                  base64String: widget.isEdit!
                                                      ? formController
                                                              .ohterWholeList[
                                                          index]["value"]
                                                      : "",
                                                  questionName: variLocal[index]
                                                      ["question"],
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter ${variLocal[index]["question"]}';
                                                    }
                                                    return null;
                                                  })
                                              : const SizedBox.shrink(),
                                          variLocal[index]["question_type"] ==
                                                  "6"
                                              ? CustomDatePicker(
                                                  index: index,
                                                  isEdit: widget.isEdit,
                                                  editableList: widget.isEdit!
                                                      ? Get.arguments
                                                      : [],
                                                  value: widget.isEdit!
                                                      ? formController
                                                              .ohterWholeList[
                                                          index]["value"]
                                                      : "",
                                                  questionValue:
                                                      variLocal[index]
                                                          ["question"],
                                                )
                                              : const SizedBox.shrink(),
                                          getheight(context, 0.010)
                                        ],
                                      );
                                    }),
                              ),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomFloatingActionButton(
                              icon: Icon(
                                Icons.fast_rewind,
                                color: appYellowColor,
                              ),
                              onPressed: () => Get.off(
                                  () => BasicVoterRegistrationForm(
                                        isEdit: widget.isEdit,
                                      ),
                                  // arguments: formController.index.value,
                                  arguments: Get.arguments,
                                  transition: Transition.noTransition)),
                          !formController.isSubmitLoading.value
                              ? CustomSelectedButton(
                                  isSelected: true,
                                  text: "Submit",
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  const Text("Alert"),
                                                  Positioned(
                                                      top: -10,
                                                      right: -10,
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: const Align(
                                                          alignment:
                                                              Alignment(1, -2),
                                                          child: CircleAvatar(
                                                              maxRadius: 20,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              child: Icon(
                                                                  Icons.cancel,
                                                                  size: 30)),
                                                        ),
                                                      ))
                                                ],
                                              ),
                                              content: SizedBox(
                                                height: Get.height * 0.23,
                                                width: Get.width * 0.20,
                                                child: Column(
                                                  children: [
                                                    const Divider(),
                                                    const CustomText(
                                                        text:
                                                            "Would you like to Save or Submit?"),
                                                    getheight(context, 0.01),
                                                    CustomSelectedButton(
                                                      isSelected: true,
                                                      text: "Save & Draft",
                                                      onPressed: () async {
                                                        // print(allData);
                                                        // print(allData['name']);

                                                        // formController
                                                        //     .deletOneLocalData(id);
                                                        if (widget.isEdit!) {
                                                          await LocalDatabaseHelper
                                                              .getDB();
                                                          await LocalDatabaseHelper.updateNote(
                                                              DBDataModel(
                                                                  firstName: formController
                                                                      .firstFormController
                                                                      .text,
                                                                  middleName: formController
                                                                      .middleFormController
                                                                      .text,
                                                                  surName: formController
                                                                      .surFormController
                                                                      .text,
                                                                  phone: formController
                                                                      .teleFormController
                                                                      .text,
                                                                  gender: formController
                                                                      .genderValue
                                                                      .value,
                                                                  address: formController
                                                                      .addressFormController
                                                                      .text,
                                                                  maritalStatus: formController
                                                                      .maritualValue
                                                                      .value,
                                                                  dob: formController
                                                                      .dobController
                                                                      .text,
                                                                  pollUnit: formController
                                                                      .pollUnitController
                                                                      .text,
                                                                  isSubmit: 0,
                                                                  wholelist: formController
                                                                      .ohterWholeList
                                                                      .toString(),
                                                                  userid: sharedPref
                                                                      .userID
                                                                      .value,
                                                                  formid: formController
                                                                      .formID
                                                                      .value,
                                                                  subadminid: formController.subadminID.value),
                                                              formController.formEditId.value);
                                                          Get.off(() =>
                                                              const DashboardPage());
                                                          formController
                                                              .firstFormController
                                                              .clear();
                                                          formController
                                                              .middleFormController
                                                              .clear();
                                                          formController
                                                              .surFormController
                                                              .clear();
                                                          formController
                                                              .teleFormController
                                                              .clear();
                                                          formController
                                                              .addressFormController
                                                              .clear();
                                                          formController
                                                              .dobController
                                                              .clear();
                                                          formController
                                                              .pollUnitController
                                                              .clear();
                                                          formController
                                                              .generalController
                                                              .clear();
                                                          formController
                                                              .ohterWholeList
                                                              .clear();
                                                          formController
                                                              .editDrftList
                                                              .clear();
                                                        } else {
                                                          await LocalDatabaseHelper
                                                              .getDB();
                                                          await LocalDatabaseHelper.addNote(DBDataModel(
                                                              firstName: formController
                                                                  .firstFormController
                                                                  .text,
                                                              middleName:
                                                                  formController
                                                                      .middleFormController
                                                                      .text,
                                                              surName: formController
                                                                  .surFormController
                                                                  .text,
                                                              phone: formController
                                                                  .teleFormController
                                                                  .text,
                                                              gender: formController
                                                                  .genderValue
                                                                  .value,
                                                              address: formController
                                                                  .addressFormController
                                                                  .text,
                                                              maritalStatus:
                                                                  formController
                                                                      .maritualValue
                                                                      .value,
                                                              dob: formController
                                                                  .dobController
                                                                  .text,
                                                              pollUnit: formController
                                                                  .pollUnitController
                                                                  .text,
                                                              isSubmit: 0,
                                                              wholelist: formController.ohterWholeList.toString(),
                                                              userid: sharedPref.userID.value,
                                                              formid: formController.formID.value,
                                                              subadminid: formController.subadminID.value));
                                                          Get.off(() =>
                                                              const DashboardPage());
                                                          formController
                                                              .firstFormController
                                                              .clear();
                                                          formController
                                                              .middleFormController
                                                              .clear();
                                                          formController
                                                              .surFormController
                                                              .clear();
                                                          formController
                                                              .teleFormController
                                                              .clear();
                                                          formController
                                                              .addressFormController
                                                              .clear();
                                                          formController
                                                              .dobController
                                                              .clear();
                                                          formController
                                                              .pollUnitController
                                                              .clear();
                                                          formController
                                                              .generalController
                                                              .clear();
                                                          formController
                                                              .ohterWholeList
                                                              .clear();
                                                          formController
                                                              .editDrftList
                                                              .clear();
                                                        }
                                                      },
                                                    ),
                                                    getheight(context, 0.02),
                                                    CustomSelectedButton(
                                                        isSelected: true,
                                                        text: "Submit",
                                                        onPressed: () async {
                                                          if (widget.isEdit!) {
                                                            if (networkController
                                                                .isInternet
                                                                .value) {
                                                              //call the api
                                                              await formController.formSubmit(
                                                                  id.toString(),
                                                                  formController
                                                                      .ohterWholeList,
                                                                  formController
                                                                      .formID
                                                                      .value,
                                                                  formController
                                                                      .subadminID
                                                                      .value,
                                                                  widget
                                                                      .isEdit!);
                                                            } else {
                                                              //local save with isSubmit status 1(update run)
                                                              await LocalDatabaseHelper
                                                                  .getDB();
                                                              await LocalDatabaseHelper.updateNote(
                                                                  DBDataModel(
                                                                      firstName: formController
                                                                          .firstFormController
                                                                          .text,
                                                                      middleName: formController
                                                                          .middleFormController
                                                                          .text,
                                                                      surName: formController
                                                                          .surFormController
                                                                          .text,
                                                                      phone: formController
                                                                          .teleFormController
                                                                          .text,
                                                                      gender: formController
                                                                          .genderValue
                                                                          .value,
                                                                      address: formController
                                                                          .addressFormController
                                                                          .text,
                                                                      maritalStatus: formController
                                                                          .maritualValue
                                                                          .value,
                                                                      dob: formController
                                                                          .dobController
                                                                          .text,
                                                                      pollUnit: formController
                                                                          .pollUnitController
                                                                          .text,
                                                                      isSubmit:
                                                                          1,
                                                                      wholelist: formController
                                                                          .ohterWholeList
                                                                          .toString(),
                                                                      userid: sharedPref
                                                                          .userID
                                                                          .value,
                                                                      formid: formController
                                                                          .formID
                                                                          .value,
                                                                      subadminid: formController
                                                                          .subadminID
                                                                          .value),
                                                                  formController
                                                                      .formEditId
                                                                      .value);
                                                              await LocalDatabaseHelper
                                                                  .getSubmitteddNote(
                                                                      sharedPref
                                                                          .userID
                                                                          .value);
                                                              Get.off(() =>
                                                                  const DashboardPage());
                                                              formController
                                                                  .firstFormController
                                                                  .clear();
                                                              formController
                                                                  .middleFormController
                                                                  .clear();
                                                              formController
                                                                  .surFormController
                                                                  .clear();
                                                              formController
                                                                  .teleFormController
                                                                  .clear();
                                                              formController
                                                                  .addressFormController
                                                                  .clear();
                                                              formController
                                                                  .dobController
                                                                  .clear();
                                                              formController
                                                                  .pollUnitController
                                                                  .clear();
                                                              formController
                                                                  .generalController
                                                                  .clear();
                                                              formController
                                                                  .ohterWholeList
                                                                  .clear();
                                                              formController
                                                                  .editDrftList
                                                                  .clear();
                                                            }
                                                          } else {
                                                            if (networkController
                                                                .isInternet
                                                                .value) {
                                                              Get.back();
                                                              await formController.formSubmit(
                                                                  id.toString(),
                                                                  formController
                                                                      .ohterWholeList,
                                                                  formController
                                                                      .formID
                                                                      .value,
                                                                  formController
                                                                      .subadminID
                                                                      .value,
                                                                  widget
                                                                      .isEdit!);
                                                              //call the api
                                                            } else {
                                                              //local save with isSubmit status 1 (add run)
                                                              await LocalDatabaseHelper
                                                                  .getDB();
                                                              await LocalDatabaseHelper.addNote(DBDataModel(
                                                                  firstName: formController
                                                                      .firstFormController
                                                                      .text,
                                                                  middleName:
                                                                      formController
                                                                          .middleFormController
                                                                          .text,
                                                                  surName: formController
                                                                      .surFormController
                                                                      .text,
                                                                  phone: formController
                                                                      .teleFormController
                                                                      .text,
                                                                  gender: formController
                                                                      .genderValue
                                                                      .value,
                                                                  address: formController
                                                                      .addressFormController
                                                                      .text,
                                                                  maritalStatus:
                                                                      formController
                                                                          .maritualValue
                                                                          .value,
                                                                  dob: formController
                                                                      .dobController
                                                                      .text,
                                                                  pollUnit: formController
                                                                      .pollUnitController
                                                                      .text,
                                                                  isSubmit: 1,
                                                                  wholelist: formController
                                                                      .ohterWholeList
                                                                      .toString(),
                                                                  userid: sharedPref.userID.value,
                                                                  formid: formController.formID.value,
                                                                  subadminid: formController.subadminID.value));
                                                              await LocalDatabaseHelper
                                                                  .getSubmitteddNote(
                                                                      sharedPref
                                                                          .userID
                                                                          .value);
                                                              Get.off(() =>
                                                                  const DashboardPage());
                                                              formController
                                                                  .firstFormController
                                                                  .clear();
                                                              formController
                                                                  .middleFormController
                                                                  .clear();
                                                              formController
                                                                  .surFormController
                                                                  .clear();
                                                              formController
                                                                  .teleFormController
                                                                  .clear();
                                                              formController
                                                                  .addressFormController
                                                                  .clear();
                                                              formController
                                                                  .dobController
                                                                  .clear();
                                                              formController
                                                                  .pollUnitController
                                                                  .clear();
                                                              formController
                                                                  .generalController
                                                                  .clear();
                                                              formController
                                                                  .ohterWholeList
                                                                  .clear();
                                                              formController
                                                                  .editDrftList
                                                                  .clear();
                                                            }
                                                          }
                                                        })
                                                  ],
                                                ),
                                              ));
                                        });
                                  })
                              : const CustomLoading(),
                        ],
                      ),
                      getheight(context, 0.026),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

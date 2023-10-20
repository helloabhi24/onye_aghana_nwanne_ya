import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_floating_action_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_syn_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_form_field.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/drop_down_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/const/string_const.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/votar_registration_form/other_voter_registration_form.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custome_pop_down.dart';

class BasicVoterRegistrationForm extends StatefulWidget {
  final bool? isEdit;
  const BasicVoterRegistrationForm({super.key, required this.isEdit});

  @override
  State<BasicVoterRegistrationForm> createState() =>
      _BasicVoterRegistrationFormState();
}

class _BasicVoterRegistrationFormState
    extends State<BasicVoterRegistrationForm> {
  // List<Map<String, dynamic>> parseInputString(String inputString) {
  //   List<Map<String, dynamic>> jsonList = [];

  //   // Remove square brackets at the beginning and end of the input string
  //   inputString = inputString.substring(1, inputString.length - 1);

  //   // Split the input string into individual question-answer pairs
  //   List<String> pairs = inputString.split('}, ');

  //   for (var pair in pairs) {
  //     // Split each pair into question, type, and value
  //     List<String> parts = pair.split(', ');

  //     Map<String, dynamic> jsonObject = {};

  //     for (var part in parts) {
  //       List<String> keyValue = part.split(': ');
  //       String key = keyValue[0].replaceAll(
  //         '{',
  //         '',
  //       );
  //       String value = keyValue[1];

  //       // Remove any leading and trailing curly braces
  //       if (value.startsWith('{')) {
  //         value = value.substring(1);
  //       }
  //       if (value.endsWith('}')) {
  //         value = value.substring(0, value.length - 1);
  //       }

  //       // Convert value to dynamic type if possible
  //       dynamic parsedValue = value;

  //       if (value.isNotEmpty) {
  //         if (value == 'true' || value == 'false') {
  //           parsedValue = (value == 'true');
  //         } else if (int.tryParse(value) != null) {
  //           parsedValue = int.parse(value);
  //         }
  //       }

  //       jsonObject[key] = parsedValue;
  //     }

  //     jsonList.add(jsonObject);
  //   }

  //   return jsonList;
  // }
  List<Map<String, dynamic>> parseInputString(String inputString) {
    // Remove the leading and trailing brackets '[ ]'
    if (inputString.startsWith("[") && inputString.endsWith("]")) {
      inputString = inputString.substring(1, inputString.length - 1);
    }

    List<String> segments = inputString.split("}, {");
    List<Map<String, dynamic>> resultList = [];

    for (String segment in segments) {
      segment = segment.replaceAll("{", "").replaceAll("}", "");
      List<String> keyValuePairs = segment.split(", ");

      Map<String, dynamic> map = {};

      for (String pair in keyValuePairs) {
        List<String> parts = pair.split(": ");
        if (parts.length == 2) {
          map[parts[0]] = parts[1];
        }
      }

      resultList.add(map);
    }

    return resultList;
  }
//  List<Map<String, String>> parseInputString(String inputString) {
//     List<Map<String, String>> result = [];
//     final regex = RegExp(r'{(.*?)}');

//     for (final match in regex.allMatches(inputString)) {
//       final jsonStr = match.group(1)!;
//       final jsonMap = parseJsonString(jsonStr);
//       if (jsonMap.isNotEmpty) {
//         result.add(jsonMap);
//       }
//     }

//     return result;
//   }

//   Map<String, String> parseJsonString(String jsonString) {
//     Map<String, String> jsonMap = {};

//     final keyValuePairs = jsonString.split(', ');
//     for (var pair in keyValuePairs) {
//       final parts = pair.split(': ');
//       if (parts.length == 2) {
//         final key = parts[0].trim();
//         final value = parts[1].trim();
//         jsonMap[key] = value;
//       }
//     }

//     return jsonMap;
//   }
  @override
  Widget build(BuildContext context) {
    // List updatedList = [];
    // SignUpController signUpController = Get.find();
    FormController formController = Get.find();
    final formKey = GlobalKey<FormState>();
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
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
        resizeToAvoidBottomInset: true,
        floatingActionButton: showFab
            ? CustomFloatingActionButton(
                icon: Icon(
                  Icons.fast_forward,
                  color: appYellowColor,
                ),
                onPressed: () {
                  if (formController.formsList.isNotEmpty) {
                    if (formKey.currentState!.validate()) {
                      if (formController.formsList[formController.index.value]
                                  .firstName ==
                              "1" &&
                          formController.firstFormController.text.isEmpty) {
                        customToast("Please Provide First Name");
                      } else if (formController
                                  .formsList[formController.index.value]
                                  .middelName ==
                              "1" &&
                          formController.middleFormController.text.isEmpty) {
                        customToast("Please Provide Middle Name");
                      } else if (formController
                                  .formsList[formController.index.value]
                                  .surName ==
                              "1" &&
                          formController.surFormController.text.isEmpty) {
                        customToast("Please Provide Sur Name");
                      } else if (formController
                                  .formsList[formController.index.value]
                                  .telephone ==
                              "1" &&
                          formController.teleFormController.text.isEmpty) {
                        customToast("Please Provide Mobile Number");
                      }
                      // else if (formController
                      //         .formsList[formController.index.value].gender ==
                      //     "1") {
                      //   customToast("Please Provide Gender");
                      // }
                      else if (formController
                                  .formsList[formController.index.value]
                                  .address ==
                              "1" &&
                          formController.addressFormController.text.isEmpty) {
                        customToast("Please Provide Address");
                      }
                      //  else if (formController
                      //         .formsList[formController.index.value].maritualStatus ==
                      //     "1") {
                      //   customToast("Please Provide Marital Status");
                      // }
                      else if (formController
                                  .formsList[formController.index.value].dob ==
                              "1" &&
                          formController.dobController.text.isEmpty) {
                        customToast("Please Provide Date of Birth");
                      } else if (formController
                                  .formsList[formController.index.value]
                                  .pollUnit ==
                              "1" &&
                          formController.pollUnitController.text.isEmpty) {
                        customToast("Please Provide Poll Unit");
                      } else if (widget.isEdit!) {
                        formController.formsList[formController.index.value]
                                    .firstName ==
                                "1"
                            ? formController.updateValue(
                                Get.arguments,
                                "First Name",
                                formController.firstFormController.text)
                            : null;
                        formController.formsList[formController.index.value]
                                    .middelName ==
                                "1"
                            ? formController.updateValue(
                                Get.arguments,
                                "Middle Name",
                                formController.middleFormController.text)
                            : null;
                        formController.formsList[formController.index.value]
                                    .surName ==
                                "1"
                            ? formController.updateValue(
                                Get.arguments,
                                "Surname",
                                formController.surFormController.text)
                            : null;
                        formController.formsList[formController.index.value]
                                    .telephone ==
                                "1"
                            ? formController.updateValue(
                                Get.arguments,
                                "Mobile Number",
                                formController.teleFormController.text)
                            : null;
                        formController.formsList[formController.index.value]
                                    .address ==
                                "1"
                            ? formController.updateValue(
                                Get.arguments,
                                "Address",
                                formController.addressFormController.text)
                            : null;
                        formController.formsList[formController.index.value]
                                    .dob ==
                                "1"
                            ? formController.updateValue(
                                Get.arguments,
                                "Date of Birth",
                                formController.dobController.text)
                            : null;
                        formController.formsList[formController.index.value]
                                    .pollUnit ==
                                "1"
                            ? formController.updateValue(
                                Get.arguments,
                                "Poll Unit",
                                formController.pollUnitController.text)
                            : null;
                        // Get.off(
                        //     () => OtherVoterRegistrationForm(
                        //           isEdit: widget.isEdit,
                        //         ),
                        //     transition: Transition.noTransition,
                        //     arguments: Get.arguments);
                        print("this is type of ");
                        print(formController.editDrftList[0]["wholelist"]);
                        print(formController
                            .editDrftList[0]["wholelist"][0][0].runtimeType);
                        print(formController.editDrftList[0]["wholelist"][5]);
                        // final jsonEncoder = JsonEncoder();
                        // final collection1 = List.from(
                        //     formController.editDrftList[0]["wholelist"]);
                        // print(jsonEncoder.convert(collection1));
                        // var ab = json
                        //     .decode(formController.editDrftList[0]["wholelist"])
                        //     .cast<String>()
                        //     .toList();
                        // print(ab);
                        // try {
                        //   // Parse the JSON string into a list of maps
                        //   formController.ohterWholeList.value =
                        //       List<Map<String, dynamic>>.from(json.decode(
                        //           formController.editDrftList[0]["wholelist"]));
                        // } catch (e) {
                        //   print('Error parsing JSON: $e');
                        // }

                        String jsonString =
                            formController.editDrftList[0]["wholelist"];
                        // jsonString =
                        //     jsonString.substring(1, jsonString.length - 1);
                        // print(jsonString);

                        List<Map<String, dynamic>> jsonList =
                            parseInputString(jsonString);

                        // Print the resulting JSON list
                        for (var jsonObj in jsonList) {
                          print(jsonObj['question']);
                          print(jsonObj['value']);
                          print(jsonObj);
                          formController.ohterWholeList.add(jsonObj);
                        }

                        Get.off(
                            () => OtherVoterRegistrationForm(
                                  isEdit: widget.isEdit,
                                ),
                            transition: Transition.noTransition,
                            arguments: Get.arguments);
                        // print("this is value");
                        // var a;
                        // a = formController.ohterWholeList[9]["value"]
                        //     .split('|');
                        // print(a);
                        // print(a[1]);
                        // print((formController.ohterWholeList[9]["value"]
                        //     .split('|'))[1]);
                        // if (jsonString != null) {
                        //   // Parse the JSON string into a list of maps
                        //   List<Map<String, dynamic>> mapList =
                        //       List<Map<String, dynamic>>.from(
                        //           json.decode(jsonString));

                        //   // Print the list of maps
                        //   for (var item in mapList) {
                        //     // print(item);
                        //     formController.ohterWholeList.add(item);
                        //   }
                        // } else {
                        //   print(
                        //       'Failed to format the dynamic string as valid JSON');
                        // }

                        // List<Map<String, dynamic>> mapList = [];

                        // final parts = jsonString.split(RegExp(r'\s*(?=\{)'));
                        // print(parts);
                        // for (var part in parts) {
                        //   final cleanedPart = part
                        //       .replaceAll('{', '{"')
                        //       .replaceAll('}', '"}')
                        //       .replaceAll(', ', '","')
                        //       .replaceAll(': ', '":"');
                        //   try {
                        //     final map = json.decode(cleanedPart);
                        //     mapList.add(map);
                        //   } catch (e) {
                        //     print('Error parsing JSON: $e');
                        //   }
                        // }
                        // print(mapList);
                        // for (var item in mapList) {
                        //   print(item);
                        // }
                        print("this is controller ");
                        print(formController.ohterWholeList);
                        // var jsonString = formController.editDrftList[0]
                        //         ["wholelist"]
                        //     .substring(
                        //         1,
                        //         formController
                        //                 .editDrftList[0]["wholelist"].length -
                        //             1);

                        // // List<Map<String, String>> dataList = [];
                        // List<String> items = jsonString.split(', ');
                        // print("this si items");
                        // print(items.runtimeType);

                        // formController.ohterWholeList.value = items;
                        print("this");
                        print(formController.ohterWholeList);
                      } else {
                        formController.formsList[formController.index.value]
                                    .firstName ==
                                "1"
                            ? formController.addData("First Name",
                                formController.firstFormController.text)
                            : null;
                        formController.formsList[formController.index.value]
                                    .middelName ==
                                "1"
                            ? formController.addData("Middle Name",
                                formController.middleFormController.text)
                            : null;
                        formController.formsList[formController.index.value]
                                    .surName ==
                                "1"
                            ? formController.addData("Surname",
                                formController.surFormController.text)
                            : null;
                        formController.formsList[formController.index.value]
                                    .telephone ==
                                "1"
                            ? formController.addData("Mobile Number",
                                formController.teleFormController.text)
                            : null;
                        formController.formsList[formController.index.value]
                                    .address ==
                                "1"
                            ? formController.addData("Address",
                                formController.addressFormController.text)
                            : null;
                        formController.formsList[formController.index.value]
                                    .dob ==
                                "1"
                            ? formController.addData("Date of Birth",
                                formController.dobController.text)
                            : null;
                        formController.formsList[formController.index.value]
                                    .pollUnit ==
                                "1"
                            ? formController.addData("Poll Unit",
                                formController.pollUnitController.text)
                            : null;
                        if (formController.ohterWholeList.isEmpty) {
                          for (var i in formController
                              .formsList[formController.index.value].formData) {
                            print("hello");
                            print(i.question);
                            formController.ohterWholeList.add({
                              "question": i.question,
                              "type":
                                  i.questionType == "1" || i.questionType == "2"
                                      ? "text"
                                      : i.questionType == "3"
                                          ? "dropdown"
                                          : i.questionType == "4"
                                              ? "dropdownmulti"
                                              : i.questionType == "5"
                                                  ? "image"
                                                  : i.questionType == "6"
                                                      ? "date"
                                                      : "",
                              "value": ""
                            });
                          }
                        }
                        // print(formController.ohterWholeList);
                        Get.off(
                            () => OtherVoterRegistrationForm(
                                  isEdit: widget.isEdit,
                                ),
                            transition: Transition.noTransition,
                            arguments: Get.arguments);
                        print("this is all data ");
                        print(formController.allData);
                      }
                    }
                  } else if (formController.storedApiResponses.isNotEmpty) {
                    if (formKey.currentState!.validate()) {
                      if (formController.storedApiResponses[
                                  formController.index.value]['first_name'] ==
                              "1" &&
                          formController.firstFormController.text.isEmpty) {
                        customToast("Please Provide First Name");
                      } else if (formController.storedApiResponses[
                                  formController.index.value]['middel_name'] ==
                              "1" &&
                          formController.middleFormController.text.isEmpty) {
                        customToast("Please Provide Middle Name");
                      } else if (formController.storedApiResponses[
                                  formController.index.value]['sur_name'] ==
                              "1" &&
                          formController.surFormController.text.isEmpty) {
                        customToast("Please Provide Sur Name");
                      } else if (formController
                                      .storedApiResponses[formController.index.value]
                                  ['telephone'] ==
                              "1" &&
                          formController.teleFormController.text.isEmpty) {
                        customToast("Please Provide Mobile Number");
                      }
                      // else if (formController
                      //         .formsList[formController.index.value].gender ==
                      //     "1") {
                      //   customToast("Please Provide Gender");
                      // }
                      else if (formController.storedApiResponses[
                                  formController.index.value]['address'] ==
                              "1" &&
                          formController.addressFormController.text.isEmpty) {
                        customToast("Please Provide Address");
                      }
                      //  else if (formController
                      //         .formsList[formController.index.value].maritualStatus ==
                      //     "1") {
                      //   customToast("Please Provide Marital Status");
                      // }
                      else if (formController.storedApiResponses[
                                  formController.index.value]['dob'] ==
                              "1" &&
                          formController.dobController.text.isEmpty) {
                        customToast("Please Provide Date of Birth");
                      } else if (formController.storedApiResponses[
                                  formController.index.value]['poll_unit'] ==
                              "1" &&
                          formController.pollUnitController.text.isEmpty) {
                        customToast("Please Provide Poll Unit");
                      } else if (widget.isEdit!) {
                        // formController.storedApiResponses[
                        //             formController.index.value]['first_name'] ==
                        //         "1"
                        //     ? formController.updateValue(
                        //         Get.arguments,
                        //         "First Name",
                        //         formController.firstFormController.text)
                        //     : null;
                        // formController.storedApiResponses[formController
                        //             .index.value]['middel_name'] ==
                        //         "1"
                        //     ? formController.updateValue(
                        //         Get.arguments,
                        //         "Middle Name",
                        //         formController.middleFormController.text)
                        //     : null;
                        // formController.storedApiResponses[
                        //             formController.index.value]['sur_name'] ==
                        //         "1"
                        //     ? formController.updateValue(
                        //         Get.arguments,
                        //         "Surname",
                        //         formController.surFormController.text)
                        //     : null;
                        // formController.storedApiResponses[
                        //             formController.index.value]['telephone'] ==
                        //         "1"
                        //     ? formController.updateValue(
                        //         Get.arguments,
                        //         "Mobile Number",
                        //         formController.teleFormController.text)
                        //     : null;
                        // formController.storedApiResponses[
                        //             formController.index.value]['address'] ==
                        //         "1"
                        //     ? formController.updateValue(
                        //         Get.arguments,
                        //         "Address",
                        //         formController.addressFormController.text)
                        //     : null;
                        // formController.storedApiResponses[
                        //             formController.index.value]['dob'] ==
                        //         "1"
                        //     ? formController.updateValue(
                        //         Get.arguments,
                        //         "Date of Birth",
                        //         formController.dobController.text)
                        //     : null;
                        // formController.storedApiResponses[
                        //             formController.index.value]['poll_unit'] ==
                        //         "1"
                        //     ? formController.updateValue(
                        //         Get.arguments,
                        //         "Poll Unit",
                        //         formController.pollUnitController.text)
                        //     : null;

                        String jsonString =
                            formController.editDrftList[0]["wholelist"];
                        print(formController.editDrftList[0]["wholelist"]);
                        // jsonString =
                        //     jsonString.substring(1, jsonString.length - 1);
                        // print(jsonString);

                        List<Map<String, dynamic>> jsonList =
                            parseInputString(jsonString);

                        // Print the resulting JSON list
                        for (var jsonObj in jsonList) {
                          // print(jsonObj['question']);
                          // print(jsonObj['value']);
                          // print(jsonObj);
                          formController.ohterWholeList.add(jsonObj);
                        }
                        Get.off(
                          () => OtherVoterRegistrationForm(
                            isEdit: widget.isEdit,
                          ),
                          transition: Transition.noTransition,
                          // arguments: Get.arguments
                        );
                      } else {
                        // formController.storedApiResponses[
                        //             formController.index.value]['first_name'] ==
                        //         "1"
                        //     ? formController.addData("First Name",
                        //         formController.firstFormController.text)
                        //     : null;
                        // formController.storedApiResponses[formController
                        //             .index.value]['middel_name'] ==
                        //         "1"
                        //     ? formController.addData("Middle Name",
                        //         formController.middleFormController.text)
                        //     : null;
                        // formController.storedApiResponses[
                        //             formController.index.value]['sur_name'] ==
                        //         "1"
                        //     ? formController.addData("Surname",
                        //         formController.surFormController.text)
                        //     : null;
                        // formController.storedApiResponses[
                        //             formController.index.value]['telephone'] ==
                        //         "1"
                        //     ? formController.addData("Mobile Number",
                        //         formController.teleFormController.text)
                        //     : null;
                        // formController.storedApiResponses[
                        //             formController.index.value]['address'] ==
                        //         "1"
                        //     ? formController.addData("Address",
                        //         formController.addressFormController.text)
                        //     : null;
                        // formController.storedApiResponses[
                        //             formController.index.value]['dob'] ==
                        //         "1"
                        //     ? formController.addData("Date of Birth",
                        //         formController.dobController.text)
                        //     : null;
                        // formController.storedApiResponses[
                        //             formController.index.value]['poll_unit'] ==
                        //         "1"
                        //     ? formController.addData("Poll Unit",
                        //         formController.pollUnitController.text)
                        //     : null;
                        if (formController.ohterWholeList.isEmpty) {
                          for (var i in formController.storedApiResponses[
                              formController.index.value]['form_data']) {
                            print("hello");
                            print(i['question']);
                            formController.ohterWholeList.add({
                              "question": i['question'],
                              "type": i['question_type'] == "1" ||
                                      i['question_type'] == "2"
                                  ? "text"
                                  : i['question_type'] == "3"
                                      ? "dropdown"
                                      : i['question_type'] == "4"
                                          ? "dropdownmulti"
                                          : i['question_type'] == "5"
                                              ? "image"
                                              : i['question_type'] == "6"
                                                  ? "date"
                                                  : "",
                              "value": ""
                            });
                          }
                        }
                        Get.off(
                          () => OtherVoterRegistrationForm(
                            isEdit: widget.isEdit,
                          ),
                          transition: Transition.noTransition,
                          // arguments: Get.arguments
                        );
                      }
                    }
                  }
                  // print("this is index value");
                  // print(formController.index.value);
                  // print(formController.formsName.value);
                  // Get.off(() => const OtherVoterRegistrationForm(),
                  //     transition: Transition.native);
                })
            : null,
        appBar: const AppBarWidget(
          actions: [CustomSyncButton(), CustomPopDown()],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    onChanged: () {
                      Form.of(primaryFocus!.context!).save();
                    },
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getheight(context, 0.020),
                        CustomHeadingText(text: formController.formsName.value),
                        getheight(context, 0.040),
                        Row(
                          children: [
                            CustomSelectedButton(
                              text: "Basic",
                              onPressed: () {},
                              isSelected: true,
                            ),
                            getwidth(context, 0.010),
                            CustomSelectedButton(
                              text: "Other Info",
                              onPressed: () {},
                              isSelected: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  getheight(context, 0.020),
                  SizedBox(
                    // height: Get.height * 0.52,
                    child: SingleChildScrollView(
                      child: formController.formsList.isNotEmpty
                          ? Column(
                              children: [
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .firstName ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .firstName ==
                                        "1"
                                    ? CustomTextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return EMPTY_FIRST_NAME;
                                          } else if (value.length < 3) {
                                            return THREE_FIRST_NAME;
                                          }
                                          return null;
                                        },
                                        controller:
                                            formController.firstFormController,
                                        labelText: "First Name",
                                      )
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .middelName ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .middelName ==
                                        "1"
                                    ? CustomTextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return EMPTY_MIDDLE_NAME;
                                          } else if (value.length < 3) {
                                            return THREE_MIDDLE_NAME;
                                          }
                                          return null;
                                        },
                                        controller:
                                            formController.middleFormController,
                                        labelText: "Middle Name",
                                      )
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .surName ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .surName ==
                                        "1"
                                    ? CustomTextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return EMPTY_SUR_NAME;
                                          } else if (value.length < 3) {
                                            return THREE_SUR_NAME;
                                          }
                                          return null;
                                        },
                                        controller:
                                            formController.surFormController,
                                        labelText: "Surname",
                                      )
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .telephone ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .telephone ==
                                        "1"
                                    ? CustomTextFormField(
                                        onTap: () {
                                          print("hello");
                                          print(
                                              formController.genderValue.value);
                                          print("dfd");
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return EMPTY_MOBILE_NUMBER;
                                          } else if (value.length < 10) {
                                            return VALID_MOBILE_NUMBER;
                                          }
                                          return null;
                                        },
                                        formatter: [
                                          LengthLimitingTextInputFormatter(10),
                                          FilteringTextInputFormatter.deny(
                                              RegExp('^0+'))
                                        ],
                                        controller:
                                            formController.teleFormController,
                                        labelText: "Telephone Number",
                                        textInputType: TextInputType.number,
                                      )
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .gender ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .gender ==
                                        "1"
                                    ? DropDownBasicWidget(
                                        dropValue:
                                            formController.genderValue.value,
                                        valueList: formController.gender,
                                        isMarital: false,
                                        isEdit: widget.isEdit,
                                        editableList:
                                            widget.isEdit! ? Get.arguments : [],
                                      )
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .address ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .address ==
                                        "1"
                                    ? CustomTextFormFieldAddress(
                                        controller: formController
                                            .addressFormController,
                                        labelText: "Address",
                                      )
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .maritualStatus ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .maritualStatus ==
                                        "1"
                                    ? DropDownBasicWidget(
                                        dropValue:
                                            formController.maritualValue.value,
                                        valueList: formController.maritual,
                                        isMarital: true,
                                        isEdit: widget.isEdit,
                                        editableList:
                                            widget.isEdit! ? Get.arguments : [],
                                      )
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .dob ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .dob ==
                                        "1"
                                    ? CustomTextFormField(
                                        readOnly: true,
                                        onTap: () async {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          DateTime? newDate =
                                              await showDatePicker(
                                                  context: context,
                                                  helpText: "DATE OF BIRTH",
                                                  initialDate:
                                                      formController.date.value,
                                                  firstDate: DateTime(1950),
                                                  lastDate: DateTime.now());
                                          if (newDate == null) return;
                                          formController.date.value = newDate;
                                          formController.dobController.text =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(newDate);
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        controller:
                                            formController.dobController,
                                        textInputType: TextInputType.datetime,
                                        labelText: "Date of Birth",
                                      )
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .pollUnit ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController
                                            .formsList[
                                                formController.index.value]
                                            .pollUnit ==
                                        "1"
                                    ? CustomTextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return EMPTY_POLL;
                                          } else if (value.length < 12) {
                                            return FORMAT_POLL;
                                          }
                                          return null;
                                        },
                                        formatter: [
                                          LengthLimitingTextInputFormatter(12),
                                          // PhoneNumberFormatter(),
                                          // MaskTextInputFormatter(
                                          //   mask: '00-00-00-000',
                                          //   separator: '-',
                                          // )
                                          // PhoneNumberFormatterr(),
                                          formController.maskFormatterforCard
                                        ],
                                        controller:
                                            formController.pollUnitController,
                                        labelText: "Poll Unit",
                                        hintText: '04-xx-xx-xxx',
                                        textInputType: TextInputType.number,
                                      )
                                    : const SizedBox.shrink(),
                                getheight(context, 0.08),
                              ],
                            )
                          : Column(
                              children: [
                                formController.storedApiResponses[formController
                                            .index.value]["first_name"] ==
                                        "1"
                                    ? CustomTextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return EMPTY_FIRST_NAME;
                                          } else if (value.length < 3) {
                                            return THREE_FIRST_NAME;
                                          }
                                          return null;
                                        },
                                        controller:
                                            formController.firstFormController,
                                        labelText: "First Name",
                                      )
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["middel_name"] ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["middel_name"] ==
                                        "1"
                                    ? CustomTextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return EMPTY_MIDDLE_NAME;
                                          } else if (value.length < 3) {
                                            return THREE_MIDDLE_NAME;
                                          }
                                          return null;
                                        },
                                        controller:
                                            formController.middleFormController,
                                        labelText: "Middle Name",
                                      )
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["sur_name"] ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["sur_name"] ==
                                        "1"
                                    ? CustomTextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return EMPTY_SUR_NAME;
                                          } else if (value.length < 3) {
                                            return THREE_SUR_NAME;
                                          }
                                          return null;
                                        },
                                        controller:
                                            formController.surFormController,
                                        labelText: "Surname",
                                      )
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["telephone"] ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["telephone"] ==
                                        "1"
                                    ? CustomTextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return EMPTY_MOBILE_NUMBER;
                                          } else if (value.length < 10) {
                                            return VALID_MOBILE_NUMBER;
                                          }
                                          return null;
                                        },
                                        formatter: [
                                          LengthLimitingTextInputFormatter(10),
                                          FilteringTextInputFormatter.deny(
                                              RegExp('^0+'))
                                        ],
                                        controller:
                                            formController.teleFormController,
                                        labelText: "Telephone Number",
                                        textInputType: TextInputType.number,
                                      )
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["gender"] ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["gender"] ==
                                        "1"
                                    ? DropDownBasicWidget(
                                        dropValue:
                                            formController.genderValue.value,
                                        valueList: formController.gender,
                                        isMarital: false,
                                        isEdit: widget.isEdit,
                                        editableList:
                                            widget.isEdit! ? Get.arguments : [],
                                      )
                                    : const SizedBox.shrink(),
                                //  DropDownWidget(
                                //     dropValue:
                                //         formController.genderValue.value,
                                //     valueList: formController.gender,
                                //   )
                                // : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["address"] ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["address"] ==
                                        "1"
                                    ? CustomTextFormFieldAddress(
                                        controller: formController
                                            .addressFormController,
                                        labelText: "Address",
                                      )
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["maritual_status"] ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["maritual_status"] ==
                                        "1"
                                    ? DropDownBasicWidget(
                                        dropValue:
                                            formController.maritualValue.value,
                                        valueList: formController.maritual,
                                        isMarital: true,
                                        isEdit: widget.isEdit,
                                        editableList:
                                            widget.isEdit! ? Get.arguments : [],
                                      )
                                    // DropDownWidget(
                                    //     dropValue:
                                    //         formController.maritualValue.value,
                                    //     valueList: formController.maritual,
                                    //   )
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["dob"] ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["dob"] ==
                                        "1"
                                    ? CustomTextFormField(
                                        readOnly: true,
                                        onTap: () async {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          DateTime? newDate =
                                              await showDatePicker(
                                                  context: context,
                                                  helpText: "DATE OF BIRTH",
                                                  initialDate:
                                                      formController.date.value,
                                                  firstDate: DateTime(1950),
                                                  lastDate: DateTime.now());
                                          if (newDate == null) return;
                                          formController.date.value = newDate;
                                          formController.dobController.text =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(newDate);
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        controller:
                                            formController.dobController,
                                        textInputType: TextInputType.datetime,
                                        labelText: "Date of Birth",
                                      )
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["poll_unit"] ==
                                        "1"
                                    ? getheight(context, 0.020)
                                    : const SizedBox.shrink(),
                                formController.storedApiResponses[formController
                                            .index.value]["poll_unit"] ==
                                        "1"
                                    ? CustomTextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return EMPTY_POLL;
                                          } else if (value.length < 12) {
                                            return FORMAT_POLL;
                                          }
                                          return null;
                                        },
                                        formatter: [
                                          LengthLimitingTextInputFormatter(12),
                                          // PhoneNumberFormatter(),
                                          // MaskTextInputFormatter(
                                          //   mask: '00-00-00-000',
                                          //   separator: '-',
                                          // )
                                          // PhoneNumberFormatterr(),
                                          formController.maskFormatterforCard
                                        ],
                                        controller:
                                            formController.pollUnitController,
                                        labelText: "Poll Unit",
                                        hintText: '04-xx-xx-xxx',
                                        textInputType: TextInputType.number,
                                      )
                                    : const SizedBox.shrink(),
                                getheight(context, 0.01),
                              ],
                            ),
                    ),
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/sign_up_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_floating_action_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_format_text_field.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_form_field.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/drop_down_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/const/string_const.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/view/dashboard/save_and_draft_form.dart';
import 'package:onye_aghana_nwanne_ya/view/votar_registration_form/other_voter_registration_form.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custome_pop_down.dart';

class BasicVoterRegistrationForm extends StatefulWidget {
  const BasicVoterRegistrationForm({super.key});

  @override
  State<BasicVoterRegistrationForm> createState() =>
      _BasicVoterRegistrationFormState();
}

class _BasicVoterRegistrationFormState
    extends State<BasicVoterRegistrationForm> {
  @override
  Widget build(BuildContext context) {
    // SignUpController signUpController = Get.find();
    FormController formController = Get.find();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      floatingActionButton: CustomFloatingActionButton(
          icon: Icon(
            Icons.fast_forward,
            color: appYellowColor,
          ),
          onPressed: () {
            print("this is index value");
            print(formController.index.value);
            print(formController.formsName.value);
            Get.off(() => const OtherVoterRegistrationForm(),
                transition: Transition.native);
          }),
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
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
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
                          // onPressed: () => Get.off(() => const SaveDraftForm(),
                          //     transition: Transition.circularReveal),
                          isSelected: true,
                        ),
                        getwidth(context, 0.010),
                        CustomSelectedButton(
                          text: "Other Info",
                          onPressed: () {},
                          // onPressed: () => Get.off(
                          //     () => const OtherVoterRegistrationForm(),
                          //     transition: Transition.circularReveal),
                          isSelected: false,
                        ),
                      ],
                    ),
                  ],
                ),
                getheight(context, 0.020),
                SizedBox(
                  height: Get.height * 0.60,
                  child: SingleChildScrollView(
                    child: formController.formsList.isNotEmpty
                        ? Column(
                            children: [
                              formController
                                          .formsList[formController.index.value]
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
                                          .formsList[formController.index.value]
                                          .middelName ==
                                      "1"
                                  ? getheight(context, 0.020)
                                  : const SizedBox.shrink(),
                              formController
                                          .formsList[formController.index.value]
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
                                          .formsList[formController.index.value]
                                          .surName ==
                                      "1"
                                  ? getheight(context, 0.020)
                                  : const SizedBox.shrink(),
                              formController
                                          .formsList[formController.index.value]
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
                                          .formsList[formController.index.value]
                                          .telephone ==
                                      "1"
                                  ? getheight(context, 0.020)
                                  : const SizedBox.shrink(),
                              formController
                                          .formsList[formController.index.value]
                                          .telephone ==
                                      "1"
                                  ? CustomTextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return EMPTY_MOBILE_NUMBER;
                                        } else if (value.length < 11) {
                                          return VALID_MOBILE_NUMBER;
                                        }
                                        return null;
                                      },
                                      formatter: [
                                        LengthLimitingTextInputFormatter(11)
                                      ],
                                      controller:
                                          formController.teleFormController,
                                      labelText: "Telephone Number",
                                      textInputType: TextInputType.number,
                                    )
                                  : const SizedBox.shrink(),
                              formController
                                          .formsList[formController.index.value]
                                          .gender ==
                                      "1"
                                  ? getheight(context, 0.020)
                                  : const SizedBox.shrink(),
                              formController
                                          .formsList[formController.index.value]
                                          .gender ==
                                      "1"
                                  ? DropDownWidget(
                                      dropValue:
                                          formController.genderValue.value,
                                      valueList: formController.gender,
                                    )
                                  : const SizedBox.shrink(),
                              formController
                                          .formsList[formController.index.value]
                                          .address ==
                                      "1"
                                  ? getheight(context, 0.020)
                                  : const SizedBox.shrink(),
                              formController
                                          .formsList[formController.index.value]
                                          .address ==
                                      "1"
                                  ? CustomTextFormFieldAddress(
                                      controller:
                                          formController.addressFormController,
                                      labelText: "Address",
                                    )
                                  : const SizedBox.shrink(),
                              formController
                                          .formsList[formController.index.value]
                                          .maritualStatus ==
                                      "1"
                                  ? getheight(context, 0.020)
                                  : const SizedBox.shrink(),
                              formController
                                          .formsList[formController.index.value]
                                          .maritualStatus ==
                                      "1"
                                  ? DropDownWidget(
                                      dropValue:
                                          formController.maritualValue.value,
                                      valueList: formController.maritual,
                                    )
                                  : const SizedBox.shrink(),
                              formController
                                          .formsList[formController.index.value]
                                          .dob ==
                                      "1"
                                  ? getheight(context, 0.020)
                                  : const SizedBox.shrink(),
                              formController
                                          .formsList[formController.index.value]
                                          .dob ==
                                      "1"
                                  ? CustomTextFormField(
                                      onTap: () async {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        DateTime? newDate =
                                            await showDatePicker(
                                                context: context,
                                                helpText: "DATE OF BIRTH",
                                                initialDate:
                                                    formController.date.value,
                                                firstDate: DateTime(1990),
                                                lastDate: DateTime(2222));
                                        if (newDate == null) return;
                                        formController.date.value = newDate;
                                        formController.dobController.text =
                                            DateFormat('dd/MM/yyyy')
                                                .format(newDate);
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      controller: formController.dobController,
                                      textInputType: TextInputType.datetime,
                                      labelText: "Date of Birth",
                                    )
                                  : const SizedBox.shrink(),
                              formController
                                          .formsList[formController.index.value]
                                          .pollUnit ==
                                      "1"
                                  ? getheight(context, 0.020)
                                  : const SizedBox.shrink(),
                              formController
                                          .formsList[formController.index.value]
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
                              getheight(context, 0.01),
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
                                        } else if (value.length < 11) {
                                          return VALID_MOBILE_NUMBER;
                                        }
                                        return null;
                                      },
                                      formatter: [
                                        LengthLimitingTextInputFormatter(11)
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
                                  ? DropDownWidget(
                                      dropValue:
                                          formController.genderValue.value,
                                      valueList: formController.gender,
                                    )
                                  : const SizedBox.shrink(),
                              formController.storedApiResponses[formController
                                          .index.value]["address"] ==
                                      "1"
                                  ? getheight(context, 0.020)
                                  : const SizedBox.shrink(),
                              formController.storedApiResponses[formController
                                          .index.value]["address"] ==
                                      "1"
                                  ? CustomTextFormFieldAddress(
                                      controller:
                                          formController.addressFormController,
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
                                  ? DropDownWidget(
                                      dropValue:
                                          formController.maritualValue.value,
                                      valueList: formController.maritual,
                                    )
                                  : const SizedBox.shrink(),
                              formController.storedApiResponses[
                                          formController.index.value]["dob"] ==
                                      "1"
                                  ? getheight(context, 0.020)
                                  : const SizedBox.shrink(),
                              formController.storedApiResponses[
                                          formController.index.value]["dob"] ==
                                      "1"
                                  ? CustomTextFormField(
                                      onTap: () async {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        DateTime? newDate =
                                            await showDatePicker(
                                                context: context,
                                                helpText: "DATE OF BIRTH",
                                                initialDate:
                                                    formController.date.value,
                                                firstDate: DateTime(1990),
                                                lastDate: DateTime(2222));
                                        if (newDate == null) return;
                                        formController.date.value = newDate;
                                        formController.dobController.text =
                                            DateFormat('dd/MM/yyyy')
                                                .format(newDate);
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      controller: formController.dobController,
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
    );
  }
}

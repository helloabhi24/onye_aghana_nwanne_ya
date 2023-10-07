import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/sign_up_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_date_picker.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_floating_action_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/drop_down_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/view/votar_registration_form/basic_voter_registration_form.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custom_text_form_field.dart';
import '../../custom_widgets/custome_pop_down.dart';
import '../../custom_widgets/image_selected_widget.dart';

class OtherVoterRegistrationForm extends StatefulWidget {
  const OtherVoterRegistrationForm({super.key});

  @override
  State<OtherVoterRegistrationForm> createState() =>
      _OtherVoterRegistrationFormState();
}

class _OtherVoterRegistrationFormState
    extends State<OtherVoterRegistrationForm> {
  @override
  Widget build(BuildContext context) {
    FormController formController = Get.find();
    SignUpController signUpController = Get.put(SignUpController());
    DateTime selectedDate = DateTime.now();

    void handleDateChanged(DateTime newDate) {
      setState(() {
        selectedDate = newDate;
      });
    }

    var vari = formController.formsList[formController.index.value].formData;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: CustomFloatingActionButton(
          icon: Icon(
            Icons.fast_rewind,
            color: appYellowColor,
          ),
          onPressed: () => Get.off(() => const BasicVoterRegistrationForm(),
              arguments: formController.index.value,
              transition: Transition.native)),
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
                          // onPressed: () => Get.off(
                          //     () => const BasicVoterRegistrationForm(),
                          //     transition: Transition.native),
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
                    // for (var i in formController.filterFormList)
                    //   i.questionType == "3"
                    //       ? DropDownWidget(
                    //           // valueList: formController.maritual,
                    //           valueList: i.value.split("|"),
                    //           dropValue: 'one')
                    //       : i.questionType == "4"
                    //           ? DropDownWidget(
                    //               valueList: i.value.split("|"),
                    //               dropValue: 'one')
                    //           : const SizedBox.shrink(),
                    SizedBox(
                      // height: Get.height * (vari.length / 7.3),
                      height: Get.height * 0.595,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: vari.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomText(text: vari[index].question),
                                    vari[index].mandatory == "1"
                                        ? RichText(
                                            text: const TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                )))
                                        : const SizedBox.shrink()
                                  ],
                                ),
                                getheight(context, 0.010),
                                vari[index].questionType == "1"
                                    ? CustomTextFormField(
                                        onChanged: (p0) {
                                          formController.addData(
                                              vari[index].question, p0);
                                        },
                                      )
                                    : SizedBox.shrink(),
                                vari[index].questionType == "2"
                                    ? CustomTextFormFieldAddress(
                                        onChanged: (p0) {
                                          formController.addData(
                                              vari[index].question, p0);
                                        },
                                      )
                                    : SizedBox.shrink(),
                                vari[index].questionType == "3"
                                    ? DropDownWidget(
                                        valueList: vari[index].value.split("|"),
                                        dropValue:
                                            (vari[index].value.split("|"))
                                                .first,
                                        valueOnText: vari[index].question,
                                      )
                                    : SizedBox.shrink(),
                                vari[index].questionType == "4"
                                    ? MultiSelectValue(
                                        listValue: vari[index].value.split("|"),
                                        // selectedList: formController.multi,
                                        questionValue: vari[index].question,
                                      )
                                    //  DropDownWidget(
                                    //     valueList: vari[index].value.split("|"),
                                    //     dropValue:
                                    //         (vari[index].value.split("|"))
                                    //             .first,
                                    //     valueOnText: vari[index].question)
                                    : SizedBox.shrink(),
                                vari[index].questionType == "5"
                                    ? NoParameterImageWidget(
                                        questionName: vari[index].question,
                                      )
                                    // WithOutImageWidget(
                                    //     onChangedCamera: () =>
                                    //         signUpController.getImageforSignUp(
                                    //             ImageSource.camera),
                                    //     onChangedGallery: () =>
                                    //         signUpController.getImageforSignUp(
                                    //             ImageSource.gallery),
                                    //   )
                                    : SizedBox.shrink(),
                                vari[index].questionType == "6"
                                    ? CustomDatePicker(
                                        // selectedDate: selectedDate,
                                        onDateChanged: handleDateChanged,
                                        questionValue: vari[index].question,
                                      )
                                    // ? CustomTextFormField(
                                    //     onTap: () async {
                                    //       FocusManager.instance.primaryFocus
                                    //           ?.unfocus();
                                    //       DateTime? newDate =
                                    //           await showDatePicker(
                                    //               context: context,
                                    //               helpText: "DATE OF BIRTH",
                                    //               initialDate:
                                    //                   formController.date.value,
                                    //               firstDate: DateTime(1990),
                                    //               lastDate: DateTime(2222));
                                    //       if (newDate == null) return;
                                    //       formController.date.value = newDate;
                                    //       formController.dobController.text =
                                    //           DateFormat('dd/MM/yyyy')
                                    //               .format(newDate);
                                    //       FocusManager.instance.primaryFocus
                                    //           ?.unfocus();
                                    //     },
                                    //     controller:
                                    //         formController.dobController,
                                    //     textInputType: TextInputType.datetime,
                                    //     // labelText: "Date of Birth",
                                    //   )
                                    : SizedBox.shrink(),
                                getheight(context, 0.010)
                              ],
                            );
                          }),
                    ),

                    // getheight(context, 0.020),
                    // const CustomTextFormField(
                    //   labelText: "Language Prefrence",
                    // ),
                    // getheight(context, 0.020),
                    // const CustomTextFormField(
                    //   labelText: "How did you hear about us?",
                    // ),
                    // getheight(context, 0.020),
                    // const CustomTextFormField(
                    //   labelText: "Are you a resident of this state?",
                    // ),
                    // getheight(context, 0.020),
                    // const CustomTextFormField(
                    //   labelText: "Chronic Medical Conditions",
                    // ),
                    // getheight(context, 0.020),
                    // const CustomTextFormField(
                    //   labelText: "Name of Emergency Contact",
                    // ),
                    // getheight(context, 0.020),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                            text: "Submit",
                            onPressed: () {
                              Get.defaultDialog(
                                  // title: "Would you like to Save or Submit?",
                                  // textConfirm: "Save & Draft",
                                  // textCancel: "Submit",
                                  middleText:
                                      "Would you like to Save or Submit?",
                                  middleTextStyle: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  actions: [
                                    CustomButton(
                                      text: "Save & Draft",
                                      onPressed: () {},
                                    ),
                                    CustomButton(
                                        text: "Submit",
                                        onPressed: () {
                                          formController.allData
                                              .forEach((i, value) {
                                            print('index=$i, value=$value');
                                          });
                                        })
                                  ]);
                            }),
                      ],
                    ),
                    getheight(context, 0.020),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_form_field.dart';

class CustomDatePicker extends StatefulWidget {
  final String? questionValue;
  final int? index;
  final bool? isEdit;
  final String? value;
  final List? editableList;
  CustomDatePicker(
      {required this.questionValue,
      required this.index,
      this.isEdit,
      this.value,
      this.editableList})
      : super();

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late TextEditingController dobController;
  FormController formController = Get.find();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit == true) {
      // If isEdit is true, initialize with the provided value (widget.value)
      dobController = TextEditingController(text: widget.value ?? '');
      // Note: Use a default value ('') if widget.value is null.
    } else {
      // If isEdit is not set or is false, initialize with an empty string
      dobController = TextEditingController(text: '');
    }
  }

  // Helper method to update the controller's text
  void updateControllerText(DateTime date) {
    dobController.text = DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CustomTextFormField(
        readOnly: true,
        onTap: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          DateTime? newDate = await showDatePicker(
            context: context,
            helpText: "DATE OF BIRTH",
            initialDate: selectedDate,
            firstDate: DateTime(1950),
            lastDate: DateTime(2222),
          );
          if (newDate != null) {
            setState(() {
              selectedDate = newDate; // Update selectedDate
              updateControllerText(newDate); // Update the controller's text
              // widget.onDateChanged(newDate); // Notify the parent widget
              widget.isEdit!
                  ? formController.updateValue(widget.editableList!,
                      widget.questionValue!, dobController.text)
                  : formController.addData(
                      widget.questionValue!, dobController.text);

              formController.removeEntriesWithQuestion(
                  formController.editedData, widget.questionValue!);
              formController.editedData.add({
                "question": widget.questionValue!,
                "value": dobController.text,
                "type": "date"
              });

              if (widget.isEdit!) {
                formController.removeEntriesWithQuestion(
                    formController.editedSubmitData, widget.questionValue!);
                formController.editedSubmitData.add({
                  "question": widget.questionValue!,
                  "value": dobController.text,
                  "type": "date"
                });
              }
              print("this is updated ");
              print(formController.editedData);
              formController.ohterWholeList[widget.index!]["value"] =
                  dobController.text;
              print(formController.ohterWholeList[widget.index!]["value"]);
              print(dobController.text);
              print("this is updated");
              print(formController.ohterWholeList);
            });
          }
        },
        controller: dobController,
        textInputType: TextInputType.datetime,
      ),
    );
  }
}

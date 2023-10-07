// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_form_field.dart';

// class CustomDatePicker extends StatefulWidget {
//   const CustomDatePicker({super.key});

//   @override
//   State<CustomDatePicker> createState() => _CustomDatePickerState();
// }

// class _CustomDatePickerState extends State<CustomDatePicker> {
//   @override
//   Widget build(BuildContext context) {
//     var date = DateTime.now();
//     TextEditingController dobController = TextEditingController();
//     return GestureDetector(
//       child: CustomTextFormField(
//         onTap: () async {
//           FocusManager.instance.primaryFocus?.unfocus();
//           DateTime? newDate = await showDatePicker(
//               context: context,
//               helpText: "DATE OF BIRTH",
//               initialDate: DateTime.now(),
//               firstDate: DateTime(1990),
//               lastDate: DateTime(2222));
//           if (newDate == null) return;
//           setState(() {
//             print('hrllo');

//             try {
//               date = newDate;
//               dobController.text = DateFormat('dd/MM/yyyy').format(newDate);
//             } catch (e) {
//               print(e);
//             }
//             print(dobController.text);
//           });

//           FocusManager.instance.primaryFocus?.unfocus();
//         },
//         controller: dobController,
//         textInputType: TextInputType.datetime,
//         labelText: "Date of Birth",
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_form_field.dart';

class CustomDatePicker extends StatefulWidget {
  // final DateTime selectedDate;
  final Function(DateTime) onDateChanged;
  final String? questionValue;

  CustomDatePicker(
      {
      // required this.selectedDate,
      required this.onDateChanged,
      required this.questionValue})
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
    dobController = TextEditingController(
        text: selectedDate != null
            ? DateFormat('dd/MM/yyyy').format(selectedDate)
            : '');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CustomTextFormField(
        onTap: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          DateTime? newDate = await showDatePicker(
            context: context,
            helpText: "DATE OF BIRTH",
            initialDate: selectedDate,
            // ?? DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime(2222),
          );
          if (newDate != null) {
            setState(() {
              dobController.text = DateFormat('dd/MM/yyyy').format(newDate);
              widget.onDateChanged(newDate); // Notify the parent widget
              formController.addData(widget.questionValue!, dobController.text);
            });
          }
        },
        controller: dobController,
        textInputType: TextInputType.datetime,
        // labelText: widget.questionValue,
      ),
    );
  }
}

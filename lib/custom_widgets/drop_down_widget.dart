import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';

class DropDownWidget extends StatefulWidget {
  int? index;
  List? valueList;
  String? dropValue;
  String? valueOnText;
  bool? isEdit;
  List? editableList;
  DropDownWidget(
      {required this.index,
      required this.valueList,
      required this.dropValue,
      super.key,
      this.valueOnText,
      this.isEdit,
      this.editableList});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  // String? _selectedItem;
  @override
  Widget build(BuildContext context) {
    FormController formController = Get.find();
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                // color: liftGreyColor.withOpacity(0.4)
                ),
            borderRadius: BorderRadius.circular(25)),
        width: Get.width * 0.90,
        height: Get.height * 0.068,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(
              "  Select ${widget.valueOnText}",
              // style: TextStyle(color: whiteColor),
            ),

            // dropdownColor: profileNameColorColor,
            // elevation: 5,
            isExpanded: true,
            // Initial Value
            value: widget.dropValue,
            // value: _selectedItem,
            // Down Arrow Icon
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_drop_down,
                size: 30,
                // color: orangeYellowColor,
              ),
            ),

            // Array list of items
            items: widget.valueList!.map<DropdownMenuItem<String>>((items) {
              return DropdownMenuItem(
                alignment: Alignment.topLeft,
                value: items,
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomText(text: items)),
                onTap: () async {
                  print(items);
                },
              );
            }).toList(),

            onChanged: (String? newValue) {
              setState(() {
                widget.dropValue = newValue!;

                formController.ohterWholeList[widget.index!]["value"] =
                    newValue;

                widget.isEdit!
                    ? formController.updateValue(
                        widget.editableList!, widget.valueOnText!, newValue)
                    : formController.addData(widget.valueOnText!, newValue);
                // formController.editedData.value =
                //     formController.removeDuplicate(formController.editedData);

                formController.removeEntriesWithQuestion(
                    formController.editedData, widget.valueOnText!);

                formController.editedData.add({
                  "question": widget.valueOnText!,
                  "value": newValue,
                  "type": "dropdown"
                });
                if (widget.isEdit!) {
                  formController.removeEntriesWithQuestion(
                      formController.editedSubmitData, widget.valueOnText!);
                  formController.editedSubmitData.add({
                    "question": widget.valueOnText!,
                    "value": newValue,
                    "type": "dropdown"
                  });
                }

                // _selectedItem = newValue;
              });
              // paymentPageController.geoAddressController.text.isEmpty
              //     ? null
              //     : paymentPageController.getNearestStationForOrder(
              //         paymentPageController.productTypeId.value,
              //         sharedPref.lat.value,
              //         sharedPref.long.value,
              //       );
            },
          ),
        ));
  }
}

class DropDownBasicWidget extends StatefulWidget {
  List? valueList;
  String? dropValue;
  String? valueOnText;
  bool? isMarital;
  bool? isEdit;
  List? editableList;
  DropDownBasicWidget(
      {required this.valueList,
      required this.dropValue,
      super.key,
      this.valueOnText,
      this.isMarital,
      this.isEdit,
      this.editableList});

  @override
  State<DropDownBasicWidget> createState() => _DropDownBasicWidgetState();
}

class _DropDownBasicWidgetState extends State<DropDownBasicWidget> {
  // String? _selectedItem;
  @override
  Widget build(BuildContext context) {
    FormController formController = Get.find();
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                // color: liftGreyColor.withOpacity(0.4)
                ),
            borderRadius: BorderRadius.circular(25)),
        width: Get.width * 0.90,
        height: Get.height * 0.068,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(
              "  Select ${widget.valueOnText}",
              // style: TextStyle(color: whiteColor),
            ),

            // dropdownColor: profileNameColorColor,
            // elevation: 5,
            // isExpanded: false,
            // Initial Value
            value: widget.dropValue,
            // value: _selectedItem,
            // Down Arrow Icon
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_drop_down,
                size: 30,
                // color: orangeYellowColor,
              ),
            ),

            // Array list of items
            items: widget.valueList!.map<DropdownMenuItem<String>>((items) {
              return DropdownMenuItem(
                alignment: Alignment.topLeft,
                value: items,
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomText(text: items)
                    // Text(
                    //   items,
                    //   style:const TextStyle(
                    //       // color: blackColor,
                    //       fontSize: 15),
                    // )
                    ),
                onTap: () async {
                  print(items);

                  // paymentPageController.productTypeId.value = items.id.toString();
                  // cardManagementController.idofProduct.value = items.id;
                  // print("this is id");
                  // print(cardManagementController.idofProduct.value);
                  // await cardManagementController.accountsBalance();
                },
              );
            }).toList(),

            onChanged: (String? newValue) {
              setState(() {
                widget.dropValue = newValue!;
                print("this is value");
                print(newValue);
                !widget.isMarital!
                    ? formController.genderValue.value = newValue
                    : formController.maritualValue.value = newValue;
                widget.isEdit!
                    ? formController.updateValue(
                        widget.editableList!,
                        !widget.isMarital! ? "Gender" : "Maritual Status",
                        newValue)
                    : formController.addData(
                        !widget.isMarital! ? "Gender" : "Maritual Status",
                        newValue);

                // _selectedItem = newValue;
              });
              // paymentPageController.geoAddressController.text.isEmpty
              //     ? null
              //     : paymentPageController.getNearestStationForOrder(
              //         paymentPageController.productTypeId.value,
              //         sharedPref.lat.value,
              //         sharedPref.long.value,
              //       );
            },
          ),
        ));
  }
}

class MultiSelectValue extends StatelessWidget {
  final List? listValue;
  // List? selectedList;
  final int? index;
  // final List<dynamic>? initialValue;
  final String? initialValue;

  final String? questionValue;
  final bool? isEdit;
  final List? editableList;
  MultiSelectValue(
      {super.key,
      required this.questionValue,
      required this.listValue,
      required this.initialValue,
      required this.isEdit,
      required this.editableList,
      required this.index
      // this.selectedList
      });

  @override
  Widget build(BuildContext context) {
    FormController formController = Get.find();
    return MultiSelectDialogField(
      items: listValue!.map((e) => MultiSelectItem(e, e)).toList(),
      listType: MultiSelectListType.CHIP,
      buttonText: const Text("Please Select"),
      initialValue: initialValue!.split('|') ?? [],
      // selectedColor: appYellowColor,
      // selectedItemsTextStyle: TextStyle(color: appColor),
      // itemsTextStyle: TextStyle(color: appColor),
      onConfirm: (values) {
        // selectedList = values;
        print(values);
        // print(values.join('|'));
        if (values.runtimeType == List) {
          print('true');
        }
        print(questionValue);
        formController.ohterWholeList[index!]["value"] = values.join('|');
        print("this is updated");
        print(formController.ohterWholeList);
        isEdit!
            ? formController.updateValue(editableList!, questionValue!, values)
            : formController.addData(questionValue!, values);
        formController.removeEntriesWithQuestion(
            formController.editedData, questionValue!);
        formController.editedData.add({
          "question": questionValue!,
          "value": values,
          "type": "dropdownmulti"
        });
        if (isEdit!) {
          formController.removeEntriesWithQuestion(
              formController.editedSubmitData, questionValue!);
          formController.editedSubmitData.add({
            "question": questionValue!,
            "value": values,
            "type": "dropdownmulti"
          });
        }
        print("this is updated ");
        print(formController.editedData);
      },
    );
  }
}

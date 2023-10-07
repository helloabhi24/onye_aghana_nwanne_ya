import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';

class DropDownWidget extends StatefulWidget {
  List? valueList;
  String? dropValue;
  String? valueOnText;
  DropDownWidget(
      {required this.valueList,
      required this.dropValue,
      super.key,
      this.valueOnText});

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
                print(newValue);
                formController.addData(widget.valueOnText!, newValue);

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
  final String? questionValue;
  MultiSelectValue({
    super.key,
    this.questionValue,
    required this.listValue,
    // this.selectedList
  });

  @override
  Widget build(BuildContext context) {
    FormController formController = Get.find();
    return MultiSelectDialogField(
      items: listValue!.map((e) => MultiSelectItem(e, e)).toList(),
      listType: MultiSelectListType.CHIP,
      onConfirm: (values) {
        // selectedList = values;
        print(values);
        if (values.runtimeType == List) {
          print('true');
        }
        print(questionValue);
        formController.addData(questionValue!, values);
      },
    );
  }
}

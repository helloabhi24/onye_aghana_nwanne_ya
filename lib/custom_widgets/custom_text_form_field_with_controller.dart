import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormFieldWithController extends StatelessWidget {
  // TextEditingController controllers = TextEditingController();
  final TextInputType? textInputType;
  final Widget? icon;
  final Color? iconColor;
  final String? labelText;
  final double? hintFontSize;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool? isHidden;
  final List<TextInputFormatter>? formatter;
  final int? maxLength;
  final TextAlign? textAlign;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final VoidCallback? onEditingComplete;
  final String? hintText;
  final String? initialValue;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onChanged;

  CustomTextFormFieldWithController(
      {super.key,
      this.textInputType,
      this.icon,
      this.iconColor,
      this.controller,
      this.hintFontSize,
      this.labelText,
      this.onTap,
      this.onChanged,
      this.isHidden,
      this.formatter,
      this.maxLength,
      this.textAlign,
      this.validator,
      this.readOnly,
      this.onEditingComplete,
      this.onTapOutside,
      this.hintText,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.90,
      // height: Get.height * 0.078,
      child: TextFormField(
        initialValue: initialValue,
        onTapOutside: onTapOutside,
        onEditingComplete: onEditingComplete,
        readOnly: readOnly ?? false,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlign: textAlign ?? TextAlign.start,
        maxLength: maxLength,
        inputFormatters: formatter,
        obscureText: isHidden ?? false,
        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: textInputType,
        decoration: InputDecoration(
            // error: Text('g'),
            hintText: hintText,
            isDense: true,
            suffixIcon: icon,
            suffixIconColor: iconColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            labelText: labelText,
            labelStyle: GoogleFonts.poppins(fontSize: hintFontSize)),
      ),
    );
  }
}

class CustomTextFormFieldAddressWithController extends StatelessWidget {
  // TextEditingController controllers = TextEditingController();
  final TextInputType? textInputType;
  final Widget? icon;
  final Color? iconColor;
  final String? labelText;
  final double? hintFontSize;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool? isHidden;
  final List<TextInputFormatter>? formatter;
  final int? maxLength;
  final TextAlign? textAlign;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final VoidCallback? onEditingComplete;
  final String? hintText;
  final String? initialValue;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onChanged;

  CustomTextFormFieldAddressWithController(
      {super.key,
      this.textInputType,
      this.icon,
      this.iconColor,
      this.controller,
      this.hintFontSize,
      this.labelText,
      this.onTap,
      this.onChanged,
      this.isHidden,
      this.formatter,
      this.maxLength,
      this.textAlign,
      this.validator,
      this.readOnly,
      this.onEditingComplete,
      this.onTapOutside,
      this.hintText,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.90,
      // height: Get.height * 0.078,
      child: TextFormField(
        initialValue: initialValue,
        minLines: 2,
        maxLines: null,
        onTapOutside: onTapOutside,
        onEditingComplete: onEditingComplete,
        readOnly: readOnly ?? false,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlign: textAlign ?? TextAlign.start,
        maxLength: maxLength,
        inputFormatters: formatter,
        obscureText: isHidden ?? false,
        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: textInputType,
        decoration: InputDecoration(
            // error: Text('g'),
            hintText: hintText,
            isDense: true,
            suffixIcon: icon,
            suffixIconColor: iconColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            labelText: labelText,
            labelStyle: GoogleFonts.poppins(fontSize: hintFontSize)),
      ),
    );
  }
}

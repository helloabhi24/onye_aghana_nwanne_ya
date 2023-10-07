import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
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
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onChanged;

  const CustomTextFormField(
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
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.90,
      // height: Get.height * 0.078,
      child: TextFormField(
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

class CustomTextFormFieldAddress extends StatelessWidget {
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
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onChanged;

  const CustomTextFormFieldAddress(
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
      this.onTapOutside});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.90,
      child: TextFormField(
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
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
            // error: Text('g'),
            isDense: true,
            suffixIcon: icon,
            suffixIconColor: iconColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            labelText: labelText,
            labelStyle: GoogleFonts.dmSans(fontSize: hintFontSize)),
      ),
    );
  }
}

import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 2) {
      return TextEditingValue(
        text: '${newValue.text}-',
        selection: TextSelection.collapsed(offset: newValue.text.length + 1),
      );
    } else if (newValue.text.length == 5) {
      return TextEditingValue(
        text: '${newValue.text}-',
        selection: TextSelection.collapsed(offset: newValue.text.length + 1),
      );
    } else if (newValue.text.length == 8) {
      return TextEditingValue(
        text: '${newValue.text}-',
        selection: TextSelection.collapsed(offset: newValue.text.length + 1),
      );
    }
    return newValue;
  }
}

class MaskTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskTextInputFormatter({
    required this.mask,
    required this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return TextEditingValue.empty;
    }

    var text = '';
    var index = 0;

    for (var i = 0; i < mask.length; i++) {
      if (index >= newValue.text.length) {
        break;
      }

      if (mask[i] == '0') {
        text += newValue.text[index];
        index++;
      } else {
        text += separator;
      }
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class PhoneNumberFormatterr extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.length == 1) {
      // Automatically add '04-' prefix when user starts typing.
      return TextEditingValue(
        text: '04-$text',
        selection: TextSelection.collapsed(offset: 4),
      );
    } else if (text.length == 2) {
      // Ensure there's a '-' after '04' when two digits are entered.
      if (text != '04') {
        return TextEditingValue(
          text: '04-$text',
          selection: TextSelection.collapsed(offset: 4),
        );
      }
    } else if (text.length == 4) {
      // Add '-' after every two digits.
      return TextEditingValue(
        text: '$text-',
        selection: TextSelection.collapsed(offset: 5),
      );
    } else if (text.length > 4 && text.length < 10) {
      // Ensure there's a '-' after every two digits.
      return TextEditingValue(
        text: '${text.substring(0, 4)}-${text.substring(4)}',
        selection: TextSelection.collapsed(offset: text.length + 1),
      );
    } else if (text.length >= 10) {
      // Limit the input to '04-xx-xx-xxx'.
      return TextEditingValue(
        text: text.substring(0, 10),
        selection: TextSelection.collapsed(offset: 10),
      );
    }

    return newValue;
  }
}

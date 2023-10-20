import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeadingText extends StatelessWidget {
  final String? text;
  const CustomHeadingText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        style: GoogleFonts.poppins(
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ));
  }
}

class CustomText extends StatelessWidget {
  final String? text;
  final Color? color;
  const CustomText({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: GoogleFonts.poppins(
        color: color ?? Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class CustomTextPhone extends StatelessWidget {
  final String? text;
  final Color? color;
  const CustomTextPhone({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: GoogleFonts.poppins(
        color: color ?? Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class CustomTextOverFlow extends StatelessWidget {
  final String? text;
  final Color? color;
  const CustomTextOverFlow({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      // maxLines: 3,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        color: color ?? Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class CustomTextOverFlowName extends StatelessWidget {
  final String? text;
  final Color? color;
  const CustomTextOverFlowName({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      // maxLines: 3,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        color: color ?? Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class CustomButtonText extends StatelessWidget {
  final String? text;
  final Color? color;
  const CustomButtonText({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: GoogleFonts.poppins(
        color: color ?? Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class CustomButtonTextHome extends StatelessWidget {
  final String? text;
  final Color? color;
  const CustomButtonTextHome({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: GoogleFonts.poppins(
        color: color ?? Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class CustomBoldText extends StatelessWidget {
  final String? text;
  final Color? color;
  const CustomBoldText({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: GoogleFonts.poppins(
        color: color ?? Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

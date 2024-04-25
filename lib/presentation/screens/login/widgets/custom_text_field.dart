import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_letters_easy/utils/app_colors.dart';
import 'package:learning_letters_easy/utils/app_style.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final Function(String?)? onSaved;
  final ValueChanged<String>? onChange;
  final GestureTapCallback? onTap;
  final String? initialValue;
  final bool isPassword;
  final String hintText;
  final Color? backgroundColor;
  final double height;
  final double? boorderRadius;
  final bool isPasswordVisible;
  final FormFieldValidator<String>? validate;

  final Widget? suffix;
  final Widget? prefixIcon;
  final VoidCallback? suffixPressed;
  final bool isClickable;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final int lines;
  final int? maxLength;
  final double? fontSize;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? enabledBorderColor;
  final FocusNode? focusNode;
  const DefaultTextFormField({
    super.key,
    required this.controller,
    required this.type,
    required this.validate,
    this.onSaved,
    this.inputFormatters,
    this.readOnly = false,
    this.maxLength,
    this.enabledBorderColor,
    this.textAlign,
    this.focusNode,
    this.boorderRadius,
    this.textColor,
    this.backgroundColor,
    this.hintText = '',
    this.initialValue,
    this.prefixIcon,
    this.height = 1,
    this.isClickable = true,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.lines = 1,
    this.onChange,
    this.hintTextColor,
    this.onTap,
    this.fontSize,
    this.suffix,
    this.suffixPressed,
  });

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizedW(context) * 0.02),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        initialValue: initialValue,
        controller: controller,
        onFieldSubmitted: (value) {
          if (onSaved != null) {
            onSaved!(value);
          }
        },
        inputFormatters: inputFormatters,
        keyboardType: type,
        readOnly: readOnly,
        focusNode: focusNode,
        obscureText: isPassword ? !isPasswordVisible : false,
        enabled: isClickable,
        maxLength: maxLength,
        onChanged: onChange,
        // onSaved: (v) => onSaved == null ? null : {onSaved!(v)},
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTap: onTap,
        maxLines: lines,
        // textAlign: textAlign == null
        //     ? isArabic(context)
        //         ? TextAlign.start
        //         : TextAlign.end
        //     : textAlign!,
        validator: validate,
        style: TextStyle(
            color: textColor ?? kDarkBlue,
            fontSize: fontSize ?? 15,
            height: height),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          counterText: '',
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: kGrey,
            fontSize: 15,
          ),
          filled: true,
          fillColor: backgroundColor ?? kTextFieldBackColor,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 2.0,
              color: enabledBorderColor ?? Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.blue.withOpacity(0.5),
            ),
          ),
          errorStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 119, 119),
            fontWeight: FontWeight.w700,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

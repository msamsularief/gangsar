import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Customable Text Form Field untuk aplikasi Klinik Digital.
class CustomFormField extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onEditingComplete;
  final bool obscureText;
  final bool readOnly;
  final String? hintText;
  final Widget? suffixIcon;
  final String? labelText;
  final Widget? icon;
  final TextAlign? textAlign;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormater;
  final double? latterSpacing;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final String? value;
  final int? maxLines;
  final VoidCallback? onTap;

  const CustomFormField({
    Key? key,
    this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.hintText = '',
    this.labelText,
    this.textAlign,
    this.style,
    this.keyboardType,
    this.maxLength,
    this.inputFormater,
    this.suffixIcon,
    this.icon,
    this.latterSpacing,
    this.hintStyle,
    this.onEditingComplete,
    this.validator,
    this.textInputAction,
    this.value,
    this.maxLines,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      validator: validator,
      controller: controller,
      style: style ??
          TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.7),
            letterSpacing: latterSpacing,
          ),
      textAlign: textAlign ?? TextAlign.left,
      obscureText: obscureText,
      obscuringCharacter: '*',
      keyboardType: keyboardType ?? TextInputType.text,
      maxLength: maxLength,
      inputFormatters: inputFormater,
      textInputAction: textInputAction ?? TextInputAction.done,
      enableInteractiveSelection: true,
      maxLines: maxLines ?? 1,
      readOnly: readOnly,
      initialValue: value,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          left: 16.0,
          top: 12,
          right: 16,
          bottom: 12,
        ),
        isDense: true,
        hintStyle: hintStyle ??
            TextStyle(
              fontSize: 14,
              letterSpacing: latterSpacing,
              color: Colors.grey.shade500,
            ),
        filled: true,
        fillColor: Colors.white,
        icon: icon,
        hintText: hintText!.toLowerCase(),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 14,
          letterSpacing: latterSpacing,
          color: Colors.orange.shade400,
        ),
        border: _inputBorder(),
        focusedBorder: _inputBorder(
          color: Colors.orangeAccent.shade700.withOpacity(0.5),
        ),
        disabledBorder: _inputBorder(),
        enabledBorder: _inputBorder(),
        suffixIcon: suffixIcon,
      ),
      // ),
    );
  }

  _inputBorder({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        gapPadding: 20,
        borderSide: BorderSide(
          color: color ?? Colors.grey[200]!,
          style: BorderStyle.solid,
          width: 3.0,
        ),
      );
}

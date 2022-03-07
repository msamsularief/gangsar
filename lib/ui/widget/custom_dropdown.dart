import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<String>? items;
  final String? value;
  final String? hintText;
  final Function(dynamic)? onChanged;
  final Function(dynamic)? onSaved;

  const CustomDropDown({
    Key? key,
    this.items,
    this.onChanged,
    this.value,
    this.hintText,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> its = [];
    List<dynamic> its1 = [];
    its = items!;
    // its != items! ? its1 = items! : its;
    if (its.isEmpty) {
      its = items!;
    } else if (its != items) {
      its1 = items!;
      its = [];
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      height: 40.0,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 2.0,
            bottom: 2.0,
          ),
          border: _inputBorder(),
          focusedBorder: _inputBorder(),
          enabledBorder: _inputBorder(),
          disabledBorder: _inputBorder(),
          errorBorder: _inputBorder(
            color: Colors.red,
          ),
        ),
        value: value,
        onSaved: onSaved,
        onChanged: onChanged,
        hint: Text(
          hintText ?? 'pilih salah satu',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade500,
                fontSize: 14.0,
              ),
        ),
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
        items: items!.map(
                  (e) => DropdownMenuItem(
                    key: ValueKey(e),
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
      ),
    );
  }

  _inputBorder({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        gapPadding: 20,
        borderSide: BorderSide(
          color: color ?? Colors.grey[200]!,
          style: BorderStyle.solid,
          width: 3.0,
        ),
      );
}

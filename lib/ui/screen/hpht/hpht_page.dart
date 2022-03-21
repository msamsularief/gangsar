import 'package:flutter/material.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/color_helper.dart';
import 'package:klinik/helper/date_formatter.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/custom_form_field.dart';
import 'package:klinik/ui/widget/form_focus_node.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class HphtPage extends StatefulWidget {
  const HphtPage({Key? key}) : super(key: key);

  @override
  State<HphtPage> createState() => _HphtPageState();
}

class _HphtPageState extends State<HphtPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _lastHaidController = TextEditingController();
  final TextEditingController _longHaidController = TextEditingController();
  final FocusNode _longHaidFocus = FocusNode();
  final FocusNode _submitFocus = FocusNode();

  bool textIsEmpty = false;

  DateTime? initialDate;
  DateTime? initialFirstDate;
  DateTime? initialLastDate;
  DateTime? currentDate;

  @override
  void initState() {
    super.initState();

    initialDate = DateTime.now();
    initialFirstDate = DateTime(
      initialDate!.year - 1,
    );
    initialLastDate = DateTime(
      initialDate!.year + 1,
      initialDate!.month,
      initialDate!.day,
    );
    currentDate = DateTime.now();
  }

  @override
  void dispose() {
    _lastHaidController.dispose();
    _longHaidController.dispose();

    _longHaidFocus.dispose();
    _submitFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _onSubmitted() {
      if (_formKey.currentState!.validate()) {
        _longHaidFocus.dispose();
        print("SUBMITTING");
      } else {
        print("VALUES CANNOT BE NULL");
      }
    }

    return BuildBodyWidget(
      appBar: KlinikAppBar(
        title: "HPTH  Page",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _sizedBox(),
              _text(
                "Kalender Kesuburan",
                textAlign: TextAlign.center,
                fontSize: 48.0,
                fontWeight: FontWeight.w600,
              ),
              _sizedBox(),
              Text("Haid Terakhir :"),
              Container(
                margin: EdgeInsets.only(
                  top: 8.0,
                  bottom: 24.0,
                ),
                width: Core.getDefaultAppWidth(context) / 2.2,
                child: CustomFormField(
                  controller: _lastHaidController,
                  hintText: "masukkan haid terakhir anda",
                  textAlign: TextAlign.center,
                  readOnly: true,
                  onTap: () async {
                    DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: initialDate!,
                      firstDate: initialFirstDate!,
                      lastDate: initialLastDate!,
                      currentDate: currentDate!,
                      cancelText: "Cancel",
                      confirmText: "Ok",
                      helpText: "Select Your Birth Day Date",
                      fieldHintText: "Bulan/Tanggal/Tahun",
                      initialDatePickerMode: DatePickerMode.day,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      builder: (context, child) => child!,
                    );

                    if (result != null) {
                      setState(() {
                        _lastHaidController.text = result.toString().todMMMMy();
                        initialDate = result;
                        formFocusNode(
                          context,
                          _longHaidFocus,
                        );
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return "value tidak boleh kosong !";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Text("Lama Haid :"),
              Container(
                margin: EdgeInsets.only(
                  top: 8.0,
                  bottom: 24.0,
                ),
                width: Core.getDefaultAppWidth(context) / 2.2,
                child: CustomFormField(
                  controller: _longHaidController,
                  hintText: "masukkan haid terakhir anda",
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (p0) => formFocusNode(
                    context,
                    _submitFocus,
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "value tidak boleh kosong !";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              _sizedBox(),
              Container(
                margin: EdgeInsets.only(top: !textIsEmpty ? 0.0 : 32.0),
                width: Core.getDefaultAppWidth(context),
                child: CustomButton.defaultButton(
                  focusNode: _submitFocus,
                  title: "Hitung",
                  titleSize: 18.0,
                  titleColor: Colors.white,
                  buttonDefaultColor: Theme.of(context).primaryColor,
                  titleFontWeight: FontWeight.bold,
                  width: Core.getDefaultAppWidth(context),
                  height: 48.0,
                  onPressed: _onSubmitted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _text(
    String? text, {
    TextAlign? textAlign,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) =>
      Text(
        "$text",
        textAlign: textAlign ?? TextAlign.left,
        style: TextStyle(
          color: color ?? ColorHelper.fromHex("#240B1D"),
          fontSize: fontSize ?? 18.0,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      );

  Widget _sizedBox({
    double? height,
  }) =>
      SizedBox(
        height: height ?? 24.0,
      );
}

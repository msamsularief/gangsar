import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/color_helper.dart';
import 'package:klinik/helper/date_formatter.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/calendar_picker.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/custom_form_field.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class HphtPage extends StatefulWidget {
  const HphtPage({Key? key}) : super(key: key);

  @override
  State<HphtPage> createState() => _HphtPageState();
}

class _HphtPageState extends State<HphtPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _lastHaidController = TextEditingController();
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
      if (_lastHaidController.text.isNotEmpty &&
          _longHaidController.text.isNotEmpty) {
        textIsEmpty = false;
        print("SUBMITTING");

        navigateTo(AppRoute.hphtDetailPage, arguments: [
          initialDate.toString(),
          _longHaidController.text,
        ]);

        print("SUBMITTED");
      } else {
        print("VALUES CANNOT BE NULL");
        textIsEmpty = true;
      }
    }

    return BuildBodyWidget(
      appBar: KlinikAppBar(
        title: "HPTH",
        centerTitle: true,
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
              Text("Haid Terakhir  :"),
              Container(
                margin: EdgeInsets.only(
                  top: 8.0,
                  bottom: 24.0,
                ),
                width: Core.getDefaultAppWidth(context) / 2.0,
                child: CustomFormField(
                  controller: _lastHaidController,
                  hintText: "masukkan haid terakhir anda",
                  textAlign: TextAlign.center,
                  readOnly: true,
                  onTap: () async {
                    DateTime? result = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      enableDrag: true,
                      isDismissible: true,
                      constraints: BoxConstraints(
                        maxHeight: Core.getDefaultBodyHeight(context) / 1.32,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                          ),
                          child: CalendarPicker(
                            isRangedPicker: false,
                            selectedDay: initialDate,
                          ),
                        );
                      },
                    );

                    if (result != null) {
                      print(result);

                      setState(() {
                        initialDate = result;
                        _lastHaidController.text = result.toString().todMMMMy();
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
              Text("Lama Haid (hari) :"),
              Container(
                margin: EdgeInsets.only(
                  top: 8.0,
                  bottom: 24.0,
                ),
                width: Core.getDefaultAppWidth(context) / 2.0,
                child: CustomFormField(
                  controller: _longHaidController,
                  hintText: "masukkan lama haid terakhir anda",
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (p0) => _onSubmitted(),
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

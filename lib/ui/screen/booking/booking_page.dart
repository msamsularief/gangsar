import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/color_helper.dart';
import 'package:klinik/helper/date_formatter.dart';
import 'package:klinik/ui/screen/booking/choose_doctor.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/custom_dropdown.dart';
import 'package:klinik/ui/widget/custom_form_field.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TextEditingController chosenDateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController doctorNameController = TextEditingController();
  TextEditingController doctorKindController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime? initialDate;
  DateTime? initialFirstDate;
  DateTime? initialLastDate;
  DateTime? currentDate;

  bool isChecked = false;
  bool isObscure = true;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initialDate = DateTime.now();
    initialFirstDate = DateTime.now();
    initialLastDate = DateTime(
      DateTime.now().year + 1,
      DateTime.now().month,
      DateTime.now().day,
    );
    currentDate = DateTime.now();
  }

  @override
  void dispose() {
    chosenDateController.dispose();
    phoneController.dispose();
    doctorNameController.dispose();
    doctorKindController.dispose();
    super.dispose();
  }

  List<String> doctorkinds = ["Umum", "Spesialis"];
  List<String> doctorNonSPs = [
    "dr. Indra Gunawan, Sp.A",
    "dr. Prabu Setya Aji, Sp.B",
    "dr. Agung Nugroho, Sp.C",
    "dr. Bambang Gunawan, Sp.D",
    "dr. Clara Kristensen, Sp.E"
  ];
  List<String> doctorSPs = [
    "dr. Indra Gunawan, Sp.F",
    "dr. Prabu Setya Aji, Sp.G",
    "dr. Agung Nugroho, Sp.H",
    "dr. Bambang Gunawan, Sp.I",
    "dr. Clara Kristensen, Sp.J"
  ];

  List<String> itemDoctors = [];

  @override
  Widget build(BuildContext context) {
    return BuildBodyWidget(
      appBar: KlinikAppBar(
        title: "Daftar Konsultasi Online",
        titleTextSize: 28.0,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(
    BuildContext context,
  ) {
    void onRegisterButtonPressed() {
      if (_formKey.currentState!.validate()) {
        print("Sending data : { _DATA_ }");
        goBack();
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 16.0,
      ),
      physics: ClampingScrollPhysics(),
      child: SizedBox(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFormField(
                controller: chosenDateController,
                hintText: "pilih tanggal pemesanan",
                labelText: "Pilih Tanggal",
                keyboardType: TextInputType.datetime,
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
                      chosenDateController.text = result.toString().todMMMMy();
                      initialDate = result;
                    });
                  }
                },
              ),
              _sizedBox(),
              Container(
                alignment: Alignment.centerLeft,
                child: _text(
                  "Pilih Kriteria Layanan :",
                  textAlign: TextAlign.left,
                ),
              ),
              _sizedBox(
                height: 4.0,
              ),
              CustomDropDown(
                items: doctorkinds,
                onChanged: (value) {
                  if (value == "Umum") {
                    setState(() {
                      doctorKindController.text = "1";
                      itemDoctors = doctorNonSPs;
                      doctorNameController.text = "";
                    });
                  } else if (value == "Spesialis") {
                    setState(() {
                      doctorKindController.text = "2";
                      itemDoctors = doctorSPs;
                      doctorNameController.text = "";
                    });
                  }
                  print(doctorKindController.text);
                },
              ),
              _buildFormField(
                controller: doctorNameController,
                hintText: "pilih dokter ",
                labelText: "Pilih Dokter",
                keyboardType: TextInputType.name,
                suffixIcon: doctorNameController.text.isEmpty
                    ? SizedBox()
                    : Container(
                        width: Core.getDefaultAppWidth(context) / 4,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "pilih ulang ?",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                      ),
                readOnly: true,
                onTap: () async {
                  final result = await navigateTo(
                    AppRoute.chooseDoctor,
                    arguments: itemDoctors,
                  );

                  if (result != null) {
                    setState(() {
                      doctorNameController.text = result.toString();
                    });
                    print("RESULT : " + result.toString());
                  }
                },
              ),
              _sizedBox(
                height: 48.0,
              ),
              isLoading
                  ? CustomButton.loadingButton(
                      buttonColor: Theme.of(context).primaryColor.withOpacity(
                            0.18,
                          ),
                      height: 48.0,
                      loadingColor: Theme.of(context).primaryColor,
                      width: Core.getDefaultAppWidth(context),
                    )
                  : CustomButton.defaultButton(
                      title: "Daftar",
                      titleSize: 18.0,
                      titleColor: Colors.white,
                      titleFontWeight: FontWeight.bold,
                      width: Core.getDefaultAppWidth(context),
                      height: 48.0,
                      onPressed: onRegisterButtonPressed,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    String? hintText,
    String? labelText,
    int? maxLines,
    bool? readOnly,
    VoidCallback? onTap,
    String? Function(String?)? validator,
    bool obsecureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      children: [
        _sizedBox(),
        Container(
          alignment: Alignment.centerLeft,
          child: _text(
            "$labelText :",
            textAlign: TextAlign.left,
          ),
        ),
        _sizedBox(
          height: 4.0,
        ),
        CustomFormField(
          controller: controller,
          hintText: "$hintText",
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: keyboardType ?? TextInputType.name,
          maxLines: maxLines,
          readOnly: readOnly ?? false,
          onTap: onTap,
          obscureText: obsecureText,
          suffixIcon: suffixIcon,
          validator: validator,
        ),
      ],
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

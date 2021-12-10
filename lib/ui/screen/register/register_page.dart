import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/date_formatter.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/custom_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime? initialDate;
  DateTime? initialFirstDate;
  DateTime? initialLastDate;
  DateTime? currentDate;

  bool isChecked = false;

  @override
  void initState() {
    initialDate = DateTime.now();
    initialFirstDate = DateTime(1900);
    initialLastDate = DateTime(2100);
    currentDate = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    birthdayController.dispose();
    passwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BuildBodyWidget(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          // height: Core.getDefaultBodyHeight(context),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sizedBox(),
                _text(
                  "Daftar",
                  fontSize: 56.0,
                  fontWeight: FontWeight.bold,
                ),
                _sizedBox(),
                _buildFormField(
                  controller: fullNameController,
                  hintText: "masukkan nama lengkap anda",
                  labelText: "Nama Lengkap",
                ),
                _buildFormField(
                  controller: emailController,
                  hintText: "masukkan alamat email anda",
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                _buildFormField(
                  controller: birthdayController,
                  hintText: "masukkan alamat email anda",
                  labelText: "Tanggal Lahir",
                  keyboardType: TextInputType.datetime,
                  readOnly: true,
                  onTap: () async {
                    DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: initialDate!,
                      firstDate: initialFirstDate!,
                      lastDate: currentDate!,
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
                        birthdayController.text = result.toString().todMMMMy();
                        initialDate = result;
                      });
                    }
                  },
                ),
                _buildFormField(
                  controller: addressController,
                  hintText: "masukkan nomor telepon anda",
                  labelText: "Nomor Telepon",
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                _buildFormField(
                  controller: addressController,
                  hintText: "masukkan alamat email anda",
                  labelText: "Alamat Lengkap",
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: 2,
                ),
                _sizedBox(),
                _buildCheckBox(),
                _sizedBox(
                  height: 48.0,
                ),
                CustomButton.defaultButton(
                  title: "Daftar",
                  titleSize: 18.0,
                  titleColor: Colors.orangeAccent.shade700,
                  buttonDefaultColor: Colors.white,
                  titleFontWeight: FontWeight.bold,
                  width: Core.getDefaultAppWidth(context),
                  height: 48.0,
                  onPressed: () => navigateAndRemoveUntil(
                    AppRoute.login,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildFormField({
    required TextEditingController controller,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    String? hintText,
    String? labelText,
    int? maxLines,
    bool? readOnly,
    VoidCallback? onTap,
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
        ),
      ],
    );
  }

  Widget _buildCheckBox() => Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    isChecked
                        ? Icons.check_box_rounded
                        : Icons.check_box_outline_blank_rounded,
                    color: isChecked ? Colors.white : Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: _text(
                "Saya telah membaca dan memahami semua Syarat & Ketentuan "
                "pada aplikasi Gangsar O sepenuhnya.",
                fontSize: 16.0,
                textAlign: TextAlign.justify,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );

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
          color: color ?? Colors.white,
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

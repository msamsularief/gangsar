import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/date_formatter.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/custom_form_field.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class DetailProfilePage extends StatefulWidget {
  const DetailProfilePage({Key? key}) : super(key: key);

  @override
  State<DetailProfilePage> createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  late ScrollController _scrollController;

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
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    birthdayController.dispose();
    phoneController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BuildBodyWidget(
      appBar: KlinikAppBar(title: "Detail Profile"),
      body: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        padding: const EdgeInsets.all(20.0),
        physics: ClampingScrollPhysics(),
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                hintText: "masukkan tanggal lahir anda",
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
                controller: phoneController,
                hintText: "masukkan nomor telepon anda",
                labelText: "Nomor Telepon",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              _buildFormField(
                controller: addressController,
                hintText: "masukkan alamat lengkap anda",
                labelText: "Alamat Lengkap",
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: 2,
              ),
              _sizedBox(
                height: 48.0,
              ),
              CustomButton.defaultButton(
                title: "Simpan",
                titleSize: 18.0,
                titleColor: Colors.white,
                titleFontWeight: FontWeight.bold,
                width: Core.getDefaultAppWidth(context),
                height: 48.0,
                onPressed: () => goBack(),
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
          color: color ?? Theme.of(context).textTheme.bodyText1!.color,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klinik/bloc/register/register.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/color_helper.dart';
import 'package:klinik/helper/date_formatter.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/custom_form_field.dart';
import 'package:klinik/ui/widget/klinik_flashbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerBloc = BlocProvider.of<RegisterBloc>(context);
    return BuildBodyWidget(
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            isLoading = true;
          } else if (state is RegisterFailure) {
            isLoading = false;

            FlashBar.showError(context, message: state.error);
          } else if (state is RegisterSuccess) {
            FlashBar.showOnSucess(context, message: state.message!);
            navigateAndReplace(AppRoute.login);
          }
        },
        child: _buildBody(context, registerBloc),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    RegisterBloc registerBloc,
  ) {
    void onRegisterButtonPressed() {
      if (_formKey.currentState!.validate()) {
        registerBloc.add(
          RegisterButtonPressed(
            email: emailController.text,
            password: passwordController.text,
            fullName: fullNameController.text,
            phoneNum: phoneController.text,
          ),
        );
      }
    }

    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          physics: ClampingScrollPhysics(),
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
                    controller: passwordController,
                    hintText: "masukkan password anda",
                    labelText: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    obsecureText: isObscure,
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => isObscure = !isObscure),
                      child: Icon(
                        isObscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off,
                        color: Colors.grey.shade400,
                        size: 24.0,
                      ),
                    ),
                    validator: (value) => value!.length < 8
                        ? 'Password tidak boleh kurang dari 8'
                        : null,
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
                          birthdayController.text =
                              result.toString().todMMMMy();
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
                  _sizedBox(),
                  _buildCheckBox(),
                  _sizedBox(
                    height: 48.0,
                  ),
                  isLoading
                      ? CustomButton.loadingButton(
                          buttonColor:
                              Theme.of(context).primaryColor.withOpacity(
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
      },
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

  Widget _buildCheckBox() => Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
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
                  color: isChecked
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(0.4),
                  size: 26.0,
                ),
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              flex: 10,
              child: _text(
                "Saya telah membaca dan memahami semua Syarat & Ketentuan "
                "pada aplikasi Gangsar O sepenuhnya.",
                fontSize: 16.0,
                textAlign: TextAlign.justify,
                fontWeight: FontWeight.w300,
                color: ColorHelper.fromHex("#240B1D"),
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

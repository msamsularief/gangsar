import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/color_helper.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/custom_form_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
          height: Core.getDefaultBodyHeight(context) -
              (Core.getDefaultAppBarHeight(context) * 1.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _sizedBox(),
                    _text(
                      "Lupa Kata Sandi",
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                    ),
                    _sizedBox(),
                    Container(
                      child: _text(
                        "Masukkan alamat email atau nomor telepon Anda, di mana alamat email tersebut akan menerima "
                        "Kode Verifikasi untuk mengatur ulang kata sandi Anda.",
                        textAlign: TextAlign.justify,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _sizedBox(
                      height: 4.0,
                    ),
                    CustomFormField(
                      controller: emailController,
                      hintText: "masukkan alamat email anda",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    ),
                    _sizedBox(
                      height: 80.0,
                    ),
                    CustomButton.defaultButton(
                      title: "Kirim",
                      titleSize: 18.0,
                      titleColor: Colors.white,
                      titleFontWeight: FontWeight.bold,
                      width: Core.getDefaultAppWidth(context),
                      height: 48.0,
                      onPressed: () {
                        goBack();
                        navigateTo(AppRoute.verifyForgotPassword);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/custom_form_field.dart';

class VerifyForgotPasswordPage extends StatefulWidget {
  const VerifyForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _VerifyForgotPasswordPageState createState() =>
      _VerifyForgotPasswordPageState();
}

class _VerifyForgotPasswordPageState extends State<VerifyForgotPasswordPage> {
  TextEditingController verificationCodeController = TextEditingController();

  @override
  void dispose() {
    verificationCodeController.dispose();
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
          height: Core.getDefaultBodyHeight(context),
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
                      "Verifikasi",
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                    _sizedBox(),
                    Container(
                      child: _text(
                        "Masukkan Kode Verifikasi yang Anda terima melalui email.",
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
                      controller: verificationCodeController,
                      hintText: "masukkan kode verifikasi",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    ),
                    _sizedBox(
                      height: 80.0,
                    ),
                    CustomButton.defaultButton(
                      title: "Kirim",
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

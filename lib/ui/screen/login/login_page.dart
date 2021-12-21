import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/custom_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BuildBodyWidget(
      body: SingleChildScrollView(
        child: _buildBody(context),
      ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _text(
                      "Gangsar O",
                      fontSize: 56.0,
                      fontWeight: FontWeight.bold,
                    ),
                    _sizedBox(),
                    Container(
                      child: _text(
                        "Selamat datang di aplikasi Gangsar O, silakan log in untuk melanjutkan.",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: _text(
                        "Email :",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    _sizedBox(
                      height: 4.0,
                    ),
                    CustomFormField(
                      controller: emailController,
                      hintText: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    _sizedBox(),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: _text(
                        "Password :",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    _sizedBox(
                      height: 4.0,
                    ),
                    CustomFormField(
                      controller: passwdController,
                      hintText: "Enter your password",
                      obscureText: true,
                      textInputAction: TextInputAction.send,
                    ),
                    _sizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          navigateTo(AppRoute.forgotPassword);
                        },
                        child: _text(
                          "Lupa Password?",
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    _sizedBox(
                      height: 48.0,
                    ),
                    CustomButton.defaultButton(
                      title: "Masuk",
                      titleSize: 18.0,
                      titleColor: Colors.orangeAccent.shade700,
                      buttonDefaultColor: Colors.white,
                      titleFontWeight: FontWeight.bold,
                      width: Core.getDefaultAppWidth(context),
                      height: 48.0,
                      onPressed: () => navigateTo(
                        AppRoute.home,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _text("Belum punya akun? "),
                    CustomButton.circularButton(
                      title: "Register",
                      titleColor: Colors.orangeAccent.shade700,
                      titleSize: 18.0,
                      width: Core.getDefaultAppWidth(context) / 2,
                      circularButtonColor: Colors.white,
                      titleFontWeight: FontWeight.w600,
                      onPressed: () => navigateTo(
                        AppRoute.register,
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

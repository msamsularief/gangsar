import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:klinik/bloc/login/login.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/color_helper.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/custom_form_field.dart';
import 'package:klinik/ui/widget/form_focus_node.dart';
// import 'package:klinik/ui/widget/klinik_flashbar.dart';

class LoginDoctorPage extends StatefulWidget {
  const LoginDoctorPage({Key? key}) : super(key: key);

  @override
  _LoginDoctorPageState createState() => _LoginDoctorPageState();
}

class _LoginDoctorPageState extends State<LoginDoctorPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();

  final FocusNode passwordFocus = FocusNode();

  bool isObscureTextVisible = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwdController.dispose();

    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final loginBloc = BlocProvider.of<LoginBloc>(context);
    return BuildBodyWidget(
      body: SingleChildScrollView(
        // child: BlocListener<LoginBloc, LoginState>(
        //   listener: (context, state) {
        //     if (state is LoginFailure) {
        //       isLoading = false;
        //       FlashBar.showError(
        //         context,
        //         message: state.error,
        //         duration: Duration(milliseconds: 2600),
        //       );
        //     }
        //     if (state is LoginLoading) {
        //       isLoading = !isLoading;
        //     }
        //     if (state is LoginSuccess) {
        //       print('Login Sucess');
        //       navigateAndRemoveUntil(AppRoute.home);
        //     }
        //   },
        //   child: _buildBody(context, loginBloc),
        // ),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    void onLoginButtonPressed() {
      TextInput.finishAutofillContext(
        shouldSave: true,
      );
      if (_formKey.currentState!.validate()) {
        passwordFocus.unfocus();
        // loginBloc.add(
        //   LoginButtonPressed(
        //       email: emailController.text, password: passwdController.text),
        // );
        // navigateAndRemoveUntil(AppRoute.homeDoctor);
        navigateTo(AppRoute.homeDoctor);
      }
    }

    // return BlocBuilder<LoginBloc, LoginState>(
    //   builder: (context, state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      physics: const ClampingScrollPhysics(),
      child: SizedBox(
        height: Core.getDefaultBodyHeight(context) -
            Core.getDefaultAppBarHeight(context),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _text(
                          "Gangsar O",
                          fontSize: 56.0,
                          fontWeight: FontWeight.bold,
                        ),
                        _text(
                          "(Dokter)",
                          fontStyle: FontStyle.italic,
                        ),
                      ],
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
                child: AutofillGroup(
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
                        validator: (value) {
                          if (value == null) {
                            return 'email cannot be null';
                          } else {
                            return null;
                          }
                        },
                        controller: emailController,
                        hintText: "Enter your email",
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (p0) => formFocusNode(
                          context,
                          passwordFocus,
                        ),
                        autofillHints: [AutofillHints.email],
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
                        validator: (value) {
                          if (value == null) {
                            return 'password cannot be null';
                          } else if (value.length < 8) {
                            return 'password must bigger than 8 character';
                          }
                        },
                        onEditingComplete: () =>
                            TextInput.finishAutofillContext(
                          shouldSave: true,
                        ),
                        focusNode: passwordFocus,
                        controller: passwdController,
                        hintText: "Enter your password",
                        obscureText: isObscureTextVisible,
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: [AutofillHints.password],
                        onFieldSubmitted: (p0) => onLoginButtonPressed(),
                        suffixIcon: GestureDetector(
                          onTap: () => setState(
                            () => isObscureTextVisible = !isObscureTextVisible,
                          ),
                          child: Icon(
                            isObscureTextVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off,
                            color: Colors.grey.shade400,
                            size: 24.0,
                          ),
                        ),
                      ),
                      _sizedBox(
                        height: 10.0,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => navigateTo(AppRoute.forgotPassword),
                          child: _text(
                            "Lupa Password?",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
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
                              title: "Masuk",
                              titleSize: 18.0,
                              titleColor: Colors.white,
                              titleFontWeight: FontWeight.bold,
                              width: Core.getDefaultAppWidth(context),
                              height: 48.0,
                              onPressed: () => onLoginButtonPressed(),
                            ),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Column(
              //     children: [
              //       _text("Belum punya akun? "),
              //       CustomButton.circularButton(
              //         title: "Register",
              //         titleColor: Theme.of(context).primaryColor.withOpacity(
              //               0.6,
              //             ),
              //         titleSize: 18.0,
              //         width: Core.getDefaultAppWidth(context) / 2,
              //         circularButtonColor:
              //             Theme.of(context).primaryColor.withOpacity(
              //                   0.1,
              //                 ),
              //         titleFontWeight: FontWeight.w600,
              //         onPressed: () => navigateTo(
              //           AppRoute.register,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
    //   },
    // );
  }

  Widget _text(
    String? text, {
    TextAlign? textAlign,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    FontStyle? fontStyle,
  }) =>
      Text(
        "$text",
        textAlign: textAlign ?? TextAlign.left,
        style: TextStyle(
          color: color ?? ColorHelper.fromHex("#240B1D"),
          fontSize: fontSize ?? 18.0,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontStyle: fontStyle ?? FontStyle.normal,
        ),
      );

  Widget _sizedBox({
    double? height,
  }) =>
      SizedBox(
        height: height ?? 24.0,
      );
}

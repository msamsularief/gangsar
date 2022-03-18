import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';

class SelectRole extends StatelessWidget {
  const SelectRole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildBodyWidget(
      body: Container(
        padding: EdgeInsets.all(20.0),
        height: Core.getDefaultAppHeight(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            text(
              context,
              text: "Gangsar O",
              fontSize: 72.0,
            ),
            // sizedBox(),
            text(
              context,
              text:
                  "Silakan pilih role user yang sesuai dengan kebutuhan Anda.",
              fontSize: 24.0,
            ),
            sizedBox(),
            CustomButton.circularButton(
              title: "Pasien",
              titleColor: Colors.white,
              width: Core.getDefaultAppWidth(context),
              height: 40.0,
              circularButtonColor: Theme.of(context).primaryColor,
              onPressed: () {
                navigateTo(AppRoute.login);
              },
            ),
            CustomButton.circularButton(
              title: "Dokter",
              titleColor: Theme.of(context).primaryColor,
              width: Core.getDefaultAppWidth(context),
              height: 40.0,
              circularButtonColor: Theme.of(context).primaryColor.withOpacity(
                    0.2,
                  ),
              onPressed: () {
                navigateTo(AppRoute.loginDoctor);
              },
            ),
            sizedBox(),
            sizedBox(),
          ],
        ),
      ),
    );
  }

  sizedBox({double? height}) => SizedBox(
        height: height ?? 20.0,
      );

  text(
    BuildContext context, {
    required String text,
    FontWeight? fontWeight,
    double? fontSize,
  }) =>
      Text(
        text,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: fontWeight ?? FontWeight.w500,
              fontSize: fontSize ?? 32,
            ),
      );
}

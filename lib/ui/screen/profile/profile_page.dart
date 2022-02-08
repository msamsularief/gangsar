// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:klinik/bloc/klinik/klinik_bloc.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/ui/widget/popup_widget.dart';

class ProfilePage extends StatelessWidget {
  final KlinikBloc klinikBloc;
  const ProfilePage({Key? key, required this.klinikBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> menus = [
      "Edit Profile",
      "Tantang Aplikasi",
      "Keluar",
    ];
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: menus.map((e) {
          return _buildMenuItem(
            text: e,
            onPressed: () {
              var tabIndex = menus.indexOf(e);
              if (e == menus.last) {
                popupWidget(
                  context,
                  klinikBloc,
                );
              } else if (tabIndex == 0) {
                navigateTo(AppRoute.detailProfile);
              }
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItem({
    String? text,
    void Function()? onPressed,
  }) {
    Color color = Colors.black;

    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: 32.0,
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: _text(
                text: "$text",
                height: 1.0,
              ),
            ),
            Expanded(
              child: Icon(
                Icons.navigate_next,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _text({
    String? text,
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    Alignment? alignment,
    int? maxLines,
    double? height,
  }) =>
      Container(
        alignment: alignment ?? Alignment.centerLeft,
        child: Text(
          '$text',
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
          maxLines: maxLines ?? 1,
          style: TextStyle(
            color: color ?? Colors.black,
            fontSize: fontSize ?? 16.0,
            height: height ?? 0.4,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:klinik/bloc/klinik/klinik_bloc.dart';
import 'package:klinik/bloc/klinik/klinik_event.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/ui/widget/custom_button.dart';

void popupWidget(BuildContext context, KlinikBloc klinikBloc) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: const Text("Yakin untuk logout?"),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          CustomButton.defaultButton(
            title: 'Ya',
            titleColor: Color.fromARGB(255, 132, 132, 132),
            width: MediaQuery.of(context).size.width / 4,
            buttonDefaultColor: Color.fromARGB(255, 246, 246, 246),
            onPressed: () {
              klinikBloc.add(LoggedOut());
              navigateAndRemoveUntil(AppRoute.login);
            },
          ),
          SizedBox(
            height: 50.0,
            child: VerticalDivider(
              color: Colors.grey.shade300,
              endIndent: 10.0,
              indent: 10.0,
              thickness: 1.0,
            ),
          ),
          CustomButton.defaultButton(
            title: 'Tidak',
            titleColor: Theme.of(context).primaryColor.withOpacity(0.8),
            buttonDefaultColor: Theme.of(context).primaryColor.withOpacity(
                  0.08,
                ),
            width: MediaQuery.of(context).size.width / 4,
            onPressed: () {
              goBack();
            },
          ),
        ],
      );
    },
  );
}

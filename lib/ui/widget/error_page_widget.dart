import 'package:flutter/material.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class ErrorPageWidget extends StatelessWidget {
  final String title;
  final String message;
  final String subMessage;
  final Widget child;
  const ErrorPageWidget(
      {Key? key,
      required this.title,
      required this.message,
      required this.subMessage,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildBodyWidget(
      appBar: KlinikAppBar(
        title: title,
      ),
      body: _buildCard(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              subMessage,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                  ),
            ),
            SizedBox(
              height: 40.0,
            ),
            child,
          ],
        ),
      ),
    );
  }

  ///Untuk membuild `Base Card` agar tampilan lebih tertata.
  Widget _buildCard(
          {required Widget? child,
          EdgeInsetsGeometry? margin,
          double? topPadding}) =>
      Container(
        margin: margin,
        padding: EdgeInsets.fromLTRB(
          20.0,
          topPadding ?? 40.0,
          20.0,
          20.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              blurStyle: BlurStyle.solid,
              color: Colors.purple.shade100.withOpacity(0.2),
              offset: Offset(1.0, 0.8),
              spreadRadius: 2,
            ),
            BoxShadow(
              blurRadius: 8.0,
              blurStyle: BlurStyle.solid,
              color: Colors.blueGrey.shade200.withOpacity(0.2),
              offset: Offset(1.8, 2.8),
              spreadRadius: 2,
            ),
          ],
        ),
        child: child,
      );
}

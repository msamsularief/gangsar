import 'package:flutter/material.dart';

Widget cardWidget(
        {EdgeInsetsGeometry? padding,
        EdgeInsetsGeometry? margin,
        BorderRadiusGeometry? borderRadius,
        Color? backgroundColor,
        required Widget child,
        VoidCallback? onTap}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(16.0),
          color: backgroundColor ?? Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              spreadRadius: 0.0,
              offset: Offset(
                1.4,
                4.2,
              ),
            ),
          ],
        ),
        padding: padding,
        margin: margin,
        child: child,
      ),
    );

import 'package:flutter/material.dart';

Widget cardWidget(
        {EdgeInsetsGeometry? padding,
        EdgeInsetsGeometry? margin,
        required Widget child,
        VoidCallback? onTap}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
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
